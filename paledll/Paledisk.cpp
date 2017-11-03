#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <io.h>
#include <time.h>
#include "z80.h"
#include "windows.h"
#include <math.h>
#include <direct.h>
#include <stdlib.h>
#include "libdsk.h"
#include "Z80Dasm.h"

#include "palesound.h"
#include "Paledisk.h"
#include "PaleIO.h"
#include "PaleMEM.h"
#include "PaleUTILS.h"
#include "Pale.h"
#include "PaleVID.h"
#include "PalePRINTER.h"
#include "PaleTAPS.h"
#include "PaleROM.h"

//THIS WILL NEED TO BE CHANGED FOR LINUX
#define REAL_DRIVER "ntwdm"
//#define REAL_DRIVER "floppy"




int drive_types[NOOF_DRIVES];	//the drive types eg: RAW, REAL, DSK
DSK_PDRIVER ddrive[NOOF_DRIVES];
DSK_GEOMETRY dgeom[NOOF_DRIVES];
DSK_FORMAT dformat[10];
char disk_trackreg[NOOF_DRIVES];
char disk0[LYNX_MAX_DISK_SIZE];

int disk_options=0;
byte disk_comreg;	
byte disk_sectreg;	
byte disk_statusreg;	
byte disk_datareg;	
int disk_head=0;
byte disk_motor=0;
byte disk_precomp=0;
byte disk_step125=0;
byte disk_drive=0;
int last_command;

int	diskscan_start=0;
int diskscan_driveno=0;

int disk_trace_on=0;
FILE *stream_disk_trace;

//THESE ARE FOR LIBDSK
char disk_sect_to_write=0;
char disk_head_to_write=0;
int disk_sect_buf_ptr=0;
char disk_sect_buf[BYTES_PER_SECT];
char disk_track_buf[BYTES_PER_TRACK];
int disk_track_buf_ptr=0;
char disk_track_to_write=0;
char disk_drive_to_write=0;

char convert_format=0;


void convert_error(int errerno,char errtxt[]);
void reddy();


void kill_disk(int driveno)
{
	int ret;
	char lbl1[50];
	ret=dsk_close(&ddrive[driveno]);
}



extern  void _stdcall set_drive_type(int driveno,int drivesize,unsigned int dtyp)
{
	char lbl[200];

	kill_disk(driveno);
//	if(dtyp==LYNX_FDD_RAW_IMAGE ||dtyp==LYNX_FDD_DSK_IMAGE ||dtyp==LYNX_FDD_REAL )
	if(dtyp<3)
	{
		drive_types[driveno]=dtyp;
		setup_disk_geometry(driveno,drivesize);
		open_working_disk(driveno);
	}
}


void open_working_disk(int driveno)
{
	int ret,kk;
	char lbl[200],work_fname[200];
	
	if (drive_types[driveno]==LYNX_FDD_RAW_IMAGE)
	{
		_chdir((char *)rompath);   
		sprintf(work_fname,"lynxdisk%1d",driveno);
		ret=dsk_open(&ddrive[driveno],work_fname,"raw",NULL);
		if(ret!=0)
		{

//			convert_error(ret,lbl);	
//			MessageBox(NULL,lbl,"PALE Disk (Open) ERROR (Dummy Disk creation)",MB_ICONEXCLAMATION | MB_OK);
			//And Make a dummy disk
			create_dummy_disk(driveno);
//			ret=dsk_creat(&ddrive[driveno],work_fname,"raw",NULL);
			ret=dsk_open(&ddrive[driveno],work_fname,"raw",NULL);
			if(ret!=0)
			{
				convert_error(ret,lbl);	
				MessageBox(NULL,lbl,"PALE Disk IMAGE (Create) ERROR",MB_ICONEXCLAMATION | MB_OK);
			}
		}
		dsk_set_option(ddrive[driveno], "DOUBLESTEP", 0); //dont doublestep Image files
	}
	else if (drive_types[driveno]==LYNX_FDD_DSK_IMAGE)
	{
		_chdir((char *)rompath);   
		sprintf(work_fname,"lynxdisk%1d",driveno);
		ret=dsk_open(&ddrive[driveno],work_fname,"dsk",NULL);
		if(ret!=0)
		{

		//	convert_error(ret,lbl);	
		//	MessageBox(NULL,lbl,"PALE Disk (Open) ERROR",MB_ICONEXCLAMATION | MB_OK);
			//And Make a dummy disk
			create_dummy_disk(driveno);
		//	ret=dsk_creat(&ddrive[driveno],work_fname,"dsk",NULL);
		ret=dsk_open(&ddrive[driveno],work_fname,"dsk",NULL);
			if(ret!=0)
			{
				convert_error(ret,lbl);	
				MessageBox(NULL,lbl,"PALE Disk IMAGE (Create) ERROR",MB_ICONEXCLAMATION | MB_OK);
			}
		}
		dsk_set_option(ddrive[driveno], "DOUBLESTEP", 0); //dont doublestep Image files
	}
	else
	{
		if(driveno==0)sprintf(work_fname,"A:");
		else if(driveno==1)sprintf(work_fname,"B:");
		ret=dsk_open(&ddrive[driveno],work_fname, REAL_DRIVER,NULL);
		if(ret!=0)
		{
			convert_error(ret,lbl);	
			MessageBox(NULL,lbl,"PALE Disk REAL (OPEN) ERROR",MB_ICONEXCLAMATION | MB_OK);
		}

		//TEST GEOMETRY TO FIND OUT WHETHER TO DOUBLE STEP THE DRIVE OR NOT
		if(dgeom[driveno].dg_cylinders==(dsk_pcyl_t)40)
			dsk_set_option(ddrive[driveno], "DOUBLESTEP", 1);	//for 48tpi disk in 96tpi drive
		else
			dsk_set_option(ddrive[driveno], "DOUBLESTEP", 0);
//			MessageBox(NULL,"Formatting new disk","PALE Disk IMAGE (Create)",MB_ICONEXCLAMATION | MB_OK);
//			for(int j=0;j<40;j++)
//			{
//				ret=dsk_pformat(phys_disk0,&disk_geom,j, 0,&disk_format,0xe5);
//				ret=dsk_pformat(phys_disk0,&disk_geom,j, 1,&disk_format,0xe5);
//		ret=dsk_apform(phys_disk,&disk_geom,(dsk_pcyl_t)j,(dsk_phead_t)0,0xe5);
	}
}

void setup_disk_geometry(int driveno,int dsize)
{
	int ret;
	char lbl[200];
	dgeom[driveno].dg_sidedness=(dsk_sides_t)SIDES_ALT;
	if(dsize==DRIVE200K)
	{
		dgeom[driveno].dg_cylinders=(dsk_pcyl_t)40;
		dgeom[driveno].dg_heads=(dsk_phead_t)1;
	}
	else if(dsize==DRIVE800K)
	{
		dgeom[driveno].dg_cylinders=(dsk_pcyl_t)80;
		dgeom[driveno].dg_heads=(dsk_phead_t)2;
	}
	dgeom[driveno].dg_sectors=(dsk_psect_t)10;//SECT_PER_TRACK;
	dgeom[driveno].dg_secbase=(dsk_psect_t)1;
	dgeom[driveno].dg_secsize=(size_t)BYTES_PER_SECT;

	dgeom[driveno].dg_datarate=RATE_DD;
	dgeom[driveno].dg_rwgap=(dsk_gap_t)0x10;
	dgeom[driveno].dg_fmtgap=(dsk_gap_t)0x30;
	dgeom[driveno].dg_fm=0;
	dgeom[driveno].dg_nomulti=0;
	dgeom[driveno].dg_noskip=0;
}



int get_drivesize(int driveno)
{
	int ret;
	//look at the signatures to find out which disk size to use
	ret=dsk_pread(ddrive[driveno],&dgeom[driveno],disk_sect_buf,
				(dsk_pcyl_t)0,(dsk_phead_t)0,
				(dsk_psect_t)1);

	switch(disk_sect_buf[5])
	{
		case 0x81:return(DRIVE200K);
		case 0x8c:return(DRIVE800K);
	}
	return(BADDRIVE);
}


void clear_track_buf()
{
	for(int y=0;y<BYTES_PER_TRACK;y++)
		disk_track_buf[y]=(char)0xe5;
}
void clear_sect_buf()
{
	for(int y=0;y<BYTES_PER_SECT;y++)
		disk_sect_buf[y]=(char)0xe5;
}

void do_disk_updates()
{
	int ret,same;
	char lbl[200],lbl2[200];
char diag_buf[512];

if(last_command==0)return;
	
	if((last_command & 0xe0)==0xa0)  //we had a write sector last time - so write the sector buffer out
	{
		ret=dsk_pwrite(ddrive[disk_drive_to_write],&dgeom[disk_drive_to_write],disk_sect_buf,(dsk_pcyl_t)disk_track_to_write,(dsk_phead_t)disk_head_to_write,
											(dsk_psect_t)disk_sect_to_write);

		if(disk_trace_on==1)
		{
			sprintf(lbl2,"LibDisk Write (SECTOR) Drive %d Head %d Track %d Sector %d ret=%d\n",disk_drive_to_write,disk_head_to_write,disk_track_to_write,disk_sect_to_write,ret);
			fprintf(stream_disk_trace,lbl2);
		}
		if(ret!=0)
		{
			convert_error(ret,lbl);	
			MessageBox(NULL,lbl,"PALE Disk Write (SECTOR) Error",MB_ICONEXCLAMATION | MB_OK);
		}
		last_command=0;disk_comreg=0;
		disk_statusreg=0;
	}
	if((last_command & 0xf8)==0xf0)  //we had a write track last time - so write the track buffer out
	{
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"LibDisk Write (TRACK) Head %d Track %d\n",disk_head_to_write,disk_track_to_write);
			fprintf(stream_disk_trace,lbl2);
		}

//For CPM disk should format tracks 2 onwards as interleaved 1,6,2,7,3,8,4,9,5,10
		for(int k=0;k<10;k++)
		{
			dformat[k].fmt_cylinder=(dsk_pcyl_t)disk_track_to_write;
			dformat[k].fmt_head=(dsk_phead_t)disk_head_to_write;	
			dformat[k].fmt_sector=(dsk_psect_t)(k+1);	
			dformat[k].fmt_secsize=(size_t)512;	
		}

		ret=dsk_pformat(ddrive[disk_drive_to_write],&dgeom[disk_drive_to_write],(dsk_pcyl_t)disk_track_to_write,(dsk_phead_t)disk_head_to_write,(const DSK_FORMAT *)&dformat,0xe5);

		if(ret!=0)
		{
			convert_error(ret,lbl);	
			MessageBox(NULL,lbl,"PALE Disk Write (TRACK) Error",MB_ICONEXCLAMATION | MB_OK);
		}
		last_command=0;disk_comreg=0;
		disk_statusreg=0;
	}
}






void do_disk_command()
{
	int ret;
	unsigned char command,status;
	char lbl[200],lbl2[200];
	static char step_direction=+1;
	int dtr,dsr;//temporary vars

	//Look at the commad register to decide what to do
	last_command=disk_comreg;

	if ((disk_comreg & 0xf0)==0)//restore
	{
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Restore\n");
			fprintf(stream_disk_trace,lbl2);
		}
		disk_trackreg[disk_drive]=0;
		disk_statusreg=disk_statusreg | 0x04;	//set Track 0 positioned (type 1)
		disk_statusreg=disk_statusreg | 0x02;	//set Index Mark Detected (type 1)
		disk_statusreg=disk_statusreg | 0x20;	//set Head Loaded
	}
	else if((disk_comreg & 0xf0)==0x10)//Seek
	{
		disk_trackreg[disk_drive]=disk_datareg;
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Seek - Drive %d Track %d\n",disk_drive,disk_trackreg[disk_drive]);
			fprintf(stream_disk_trace,lbl2);
		}
/*
		if(disk_trackreg[disk_drive]<0)
		{
			disk_trackreg[disk_drive]=0;
			disk_statusreg=disk_statusreg & 0x10;	//set couldnt find track
			return;
		}
		else
*/
//		sprintf(lbl2,"Seek - Drive %d Track %d\n",disk_drive,disk_trackreg[disk_drive]);
//		MessageBox(NULL,lbl2,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);

			
		if (disk_trackreg[disk_drive]>=dgeom[disk_drive].dg_cylinders) //TRACKS PER DISK
		{
			disk_trackreg[disk_drive]=dgeom[disk_drive].dg_cylinders-1;
			disk_statusreg=disk_statusreg & 0x10;	//set couldnt find track	- used to be =0x10 bug?
			return;
		}
		if (disk_trackreg[disk_drive]==0)disk_statusreg=disk_statusreg | 0x04;//set TRACK0 flag
		disk_statusreg=disk_statusreg | 0x02;	//set Index Mark Detected (type 1)
		disk_statusreg=disk_statusreg | 0x20;	//set Head Loaded
	}

	//FIXME - cursor was left over 0x20 for a reason?
	else if((disk_comreg & 0xe0)==0x20)//Step
	{
		disk_trackreg[disk_drive]+=step_direction;
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Step ? track is currently %d\n",disk_trackreg[disk_drive]);
			fprintf(stream_disk_trace,lbl2);
		}
		if(disk_trackreg[disk_drive]<0)
		{
			disk_trackreg[disk_drive]=0;
			disk_statusreg=disk_statusreg & 0x10;	//set couldnt find track
			return;
		}
		else if (disk_trackreg[disk_drive]>=dgeom[disk_drive].dg_cylinders)
		{
			disk_trackreg[disk_drive]=dgeom[disk_drive].dg_cylinders-1;
			disk_statusreg=disk_statusreg = 0x10;	//set couldnt find track
			return;
		}
		if (disk_trackreg[disk_drive]==0)disk_statusreg=disk_statusreg | 0x04;//set TRACK0 flag
		disk_statusreg=disk_statusreg | 0x02;	//set Index Mark Detected (type 1)
		disk_statusreg=disk_statusreg | 0x20;	//set Head Loaded
	}
	else if((disk_comreg & 0xe0)==0x40)//Step-In
	{
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Step In\n");
			fprintf(stream_disk_trace,lbl2);
		}
		disk_trackreg[disk_drive]++;
		step_direction=+1;
		if(disk_trackreg[disk_drive]>=dgeom[disk_drive].dg_cylinders)
		{
			disk_trackreg[disk_drive]=dgeom[disk_drive].dg_cylinders-1;
			disk_statusreg=disk_statusreg & 0x10;	//set couldnt find track
			return;
		}
		if (disk_trackreg[disk_drive]==0)disk_statusreg=disk_statusreg | 0x04;//set TRACK0 flag
		disk_statusreg=disk_statusreg | 0x02;	//set Index Mark Detected (type 1)
		disk_statusreg=disk_statusreg | 0x20;	//set Head Loaded
	}
	else if((disk_comreg & 0xe0)==0x60)//Step_Out
	{
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Step Out\n");
			fprintf(stream_disk_trace,lbl2);
		}
		disk_trackreg[disk_drive]--;	//had a =0 for the trackreg here once
		step_direction=-1;
		if(disk_trackreg[disk_drive]<0)
			disk_trackreg[disk_drive]=0;
		if (disk_trackreg[disk_drive]==0)disk_statusreg=disk_statusreg | 0x04;//set TRACK0 flag
		disk_statusreg=disk_statusreg | 0x02;	//set Index Mark Detected (type 1)
		disk_statusreg=disk_statusreg | 0x20;	//set Head Loaded
	}
	else if((disk_comreg & 0xe0)==0x80)//				*********    Read Sector INIT  *******
	{
		clear_sect_buf();
		disk_sect_buf_ptr=0;

		ret=dsk_pread(ddrive[disk_drive],&dgeom[disk_drive],disk_sect_buf,
			(dsk_pcyl_t)disk_trackreg[disk_drive],(dsk_phead_t)disk_head,
			(dsk_psect_t)disk_sectreg);


		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Read Sector - Drive %d Head %d, Track %d ,Sector %d    REt=%d\n",disk_drive,disk_head,disk_trackreg[disk_drive],disk_sectreg,ret);
			fprintf(stream_disk_trace,lbl2);
		}
		if(ret!=0)
		{
			convert_error(ret,lbl);	
			MessageBox(NULL,lbl,"PALE Disk Read (SECTOR) Error",MB_ICONEXCLAMATION | MB_OK);
		}
		disk_statusreg=0;
		disk_statusreg=disk_statusreg | 0x01;//set busy flag
		disk_statusreg=disk_statusreg | 0x02;//set ready for data
		last_command=0;
		return;
	}
	else if((disk_comreg & 0xe0)==0xa0)//Write Sector
	{
		disk_sect_to_write=disk_sectreg;
		disk_track_to_write=disk_trackreg[disk_drive];
		disk_head_to_write=disk_head;
		disk_drive_to_write=disk_drive;
		disk_sect_buf_ptr=0;
		clear_sect_buf();

		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Write Sector - Drive %d Head %d, Track %d ,Sector %d\n",disk_drive,disk_head,disk_trackreg[disk_drive],disk_sectreg);
			fprintf(stream_disk_trace,lbl2);
		}
		disk_statusreg=0;
		disk_statusreg=disk_statusreg | 0x01;//set busy flag
		disk_statusreg=disk_statusreg | 0x02;//set ready for data
		return;
	}
	else if((disk_comreg & 0xf8)==0xc0)//Read Address
	{
			//		MessageBox(NULL,"DISK READ ADDR","PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
			//Track address, Side number, Sector address,
			//	Sector Length, CRC1, CRC2
			if(disk_trace_on==1)
			{
				sprintf(lbl2," *** DATA Read (ADDRESS)");
				fprintf(stream_disk_trace,lbl2);
			}
			// FOR REAL DISKS??
			//dsk_psecid(DSK_PDRIVER self, const DSK_GEOMETRY *geom,
			//				dsk_pcyl_t cylinder, dsk_phead_t head,
			//				DSK_FORMAT *result);
			disk_sect_buf_ptr=0;
			clear_sect_buf();
			disk_sect_buf[disk_sect_buf_ptr++]=disk_trackreg[disk_drive];
			disk_sect_buf[disk_sect_buf_ptr++]=disk_head;
			disk_sect_buf[disk_sect_buf_ptr++]=disk_sectreg++;		//Increment along to next sector
			disk_sect_buf[disk_sect_buf_ptr++]=(char)255;
			disk_sect_buf[disk_sect_buf_ptr++]=0;
			disk_sect_buf[disk_sect_buf_ptr++]=0;
			disk_sect_buf_ptr=0;
			
			disk_statusreg=0;
			disk_statusreg=disk_statusreg | 0x01;//set busy flag
			disk_statusreg=disk_statusreg | 0x02;//set ready for data
			return;
	}
	else if((disk_comreg & 0xf8)==0xe0)//Read Track
	{
		MessageBox(NULL,"DISKREAD TRACK - not implemented yet","PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
	}
	else if((disk_comreg & 0xf8)==0xf0)//Write Track
	{
		disk_track_to_write=disk_trackreg[disk_drive];
		disk_sect_to_write=disk_sectreg;
		disk_head_to_write=disk_head;
		disk_drive_to_write=disk_drive;
		disk_track_buf_ptr=0;
		clear_track_buf();
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Write Track - Drive %d Head %d, Track %d ,Sector %d\n",disk_drive,disk_head,disk_trackreg[disk_drive],disk_sectreg);
			fprintf(stream_disk_trace,lbl2);
		}
		disk_statusreg=0;
		disk_statusreg=disk_statusreg | 0x01;//set busy flag
		disk_statusreg=disk_statusreg | 0x02;//set ready for data
		return;
	}
	else if((disk_comreg & 0xf0)==0xd0)//Force Interrupt
	{
		//		MessageBox(NULL,"DISKFORCE INTERRUPT","PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
		disk_statusreg=0x00;	//set Track 0 positioned (type 1)
		last_command=0;
		disk_statusreg=disk_statusreg | 0x20;	//set HEAD LOADed (type 1)
		disk_statusreg=disk_statusreg | 0x02;	//set Index Mark Detected (type 1)
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"DISKFORCE INTERRUPT - Drive %d Head %d, Track %d ,Sector %d\n",disk_drive,disk_head,disk_trackreg[disk_drive],disk_sectreg);
			fprintf(stream_disk_trace,lbl2);
		}
		//start_im1_irq=1;
	}
}



void get_disk_driver_types()
{
	int ret,kk;
	char lbl[200];
	char drvname[200];
	char drvdesc[200];
	char drv0[20];
	char drv1[20];
	char drv2[20];
	char drv3[20];
	char drv4[20];
	char drv5[20];
	char *drvtypes[20];

	drvtypes[0]=drv0;
	drvtypes[1]=drv0;
	drvtypes[2]=drv0;
	drvtypes[3]=drv0;
	drvtypes[4]=drv0;
	drvtypes[5]=drv0;
//for(kk=0;kk<20;kk++)
//	sprintf(drvtypes[kk],"none");
//ret=TRUE;
//kk=0;
//while(1)//ret==TRUE)
//{
//	ret= dsk_type_enum(kk, (char **)drvtypes[kk]);
//	ret= dsk_type_enum(kk, (char **)drvtypes[kk]);
//	sprintf(lbl,"Enum %d Returned %d type: ",kk,ret);
//	strcat(lbl,drvtypes[kk]);
//	MessageBox(NULL,lbl,"PALE Disk Driver Type Enumeration",MB_ICONEXCLAMATION | MB_OK);
//	kk++;
//}
//	ret=dsk_open(&phys_disk,work_fname, disk_type,NULL);
//	sprintf(drvname, dsk_drvname(phys_disk));
//	sprintf(drvdesc, dsk_drvdesc(phys_disk));
//	sprintf(lbl,"Driver Found: %s , description: %s",drvname.drvdesc);
//	sprintf(lbl,"Using Driver: ");
//	strcat(lbl,drvname);
//	MessageBox(NULL,lbl,"PALE Disk Driver Open",MB_ICONEXCLAMATION | MB_OK);
}

void reset_disk_stuff()
{
	disk_options=0;
	disk_comreg=0;

	for(int f=0;f<NOOF_DRIVES;f++)
	{
		disk_trackreg[f]=0;
	}
	disk_sectreg=0;
	clear_track_buf();
	clear_sect_buf();
	disk_statusreg=0;
	disk_head=0;
	disk_precomp=0;
	disk_step125=0;
	disk_motor=0;
	disk_drive=0;
}



void init_diskstuff()
{
	reset_disk_stuff();	
	for(int f=0;f<NOOF_DRIVES;f++)
	{
		set_drive_type(f,DRIVE200K,LYNX_FDD_RAW_IMAGE);
	}
	disk_drive=0;
}



extern  int  _declspec(dllexport) load_disk_dev()
{
	int ret;
	int  handle,handle2;
	int  size_read;
	int cdd,f;
	return(1);			
}

int drivesize(int driveno)
{
	return(BYTES_PER_SECT*SECT_PER_TRACK*dgeom[driveno].dg_cylinders*dgeom[driveno].dg_heads);
}


void create_dummy_disk(int driveno)
{
	int  handle,handle2;
	unsigned int  ret,size_read,f,g,h,size_written,dum;
	char work_fname[50];
	char lbl[100];
	sprintf(work_fname,"lynxdisk%1d",driveno);
	handle = open( work_fname,O_RDWR | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle != -1 )
	{
		dum=drivesize(driveno);
		for(f=0;f<dum;f++)
			disk0[f]=(char)0xe5;
		size_written = write( handle, disk0,dum);
		if( size_written != dum )
		{
			ret=MessageBox(NULL,":( Couldnt write the Dummy DISK file - duh!","PALE Initialisation",MB_ICONERROR | MB_OK);
			return;
		}
		close(handle);
	}
}


extern  int  _declspec(dllexport) load_disk(int driveno,char fnam[])
{
	int ret,errorr,g,h;
	int  handle,handle2;
	int  size_read,size_written;
	int cdd,f;
	char lbl[200],work_fname[200];

	handle=open( fnam, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, disk0,LYNX_MAX_DISK_SIZE );
	  close( handle );
	  if( size_read == -1 )
	  {
				ret=MessageBox(NULL,":( Couldn't open the DISK file","PALE Disk Load",MB_YESNO | MB_DEFBUTTON1);
				return(1);
	  }
	  else
	  {


		if(size_read==(200*1024))
			set_drive_type(driveno,DRIVE200K,LYNX_FDD_RAW_IMAGE);
		else 
			set_drive_type(driveno,DRIVE800K,LYNX_FDD_RAW_IMAGE);
//		else
//		{
//					sprintf(lbl,":( BAD SIZE DISK file %u (must be 200K or 800K)",size_read);
//					ret=MessageBox(NULL,lbl,"PALE Disk Load",MB_YESNO | MB_DEFBUTTON1);
//					return(1);
//		}
		
		
		_chdir((char *)rompath);   
				
			sprintf(work_fname,"lynxdisk%1d",driveno);

			handle2 = open( work_fname,O_RDWR | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
				if( handle2 != -1 )
				{
					size_written = write( handle2, disk0,size_read);
					if( size_written != size_read )
					{
						ret=MessageBox(NULL,":( Couldnt Copy Disk to the Dummy DISK file - duh!","PALE Load Disk",MB_ICONERROR | MB_OK);
						return(1);
					}
					close(handle2);
					return(0);
				}
				else
				{
						ret=MessageBox(NULL,":( Couldnt Copy Disk to the Dummy DISK file - duh!","PALE Load Disk",MB_ICONERROR | MB_OK);
						return(1);
				}
	  }
	}
	else
	{
		ret=MessageBox(NULL,":( Couldn't open the DISK file","PALE Lynx Disk Load",MB_YESNO | MB_DEFBUTTON1);
		return(1);
	}
	return(1);			
}


extern  int  _declspec(dllexport) start_disk_trace()
{
	int ret;
	disk_trace_on=1;
	// Open for write 
	if( (stream_disk_trace = fopen( "DISKTRACE.TXT", "w+" )) == NULL )
			ret=MessageBox(NULL,"DIDNT OPEN DISK TRACE FILE","PALE Debug - Press Yes to Exit, CANCEL to NoTrap",MB_YESNOCANCEL | MB_DEFBUTTON2);
	return(1);			
}

extern  int  _declspec(dllexport) stop_disk_trace()
{
		disk_trace_on=0;
		fclose(stream_disk_trace);
		return(1);			
}


extern  int  _stdcall  save_disk_dump()
{
	int  handle2,ret;
    int size_written;

    /* open a file for output		  */
    handle2 = open( "disk.dmp",O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
      size_written = write( handle2, disk0,
			    LYNX_MAX_DISK_SIZE );
		close( handle2 );
      if( size_written != LYNX_MAX_DISK_SIZE ) 
		  return(0);
	}
	else
	{
		  return(0);
	}
	return(0);
}


extern  int  _stdcall  save_disk(int driveno,char fnam[])
{
	int  handle,handle2;
	int size_written,size_read,ret;
	char work_fname[100];

	
	
	if (drive_types[driveno]==LYNX_FDD_REAL)
		return(0);			//fake a good save
	else
	{
		/* open a file for output		  */
		handle2 = open( fnam,O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
		if( handle2 != -1 )
		{
			//Straight copy of lynxdisk file to the save filename
			_chdir((char *)rompath);   

				
			sprintf(work_fname,"lynxdisk%1d",driveno);
			
			handle=open( work_fname, O_RDONLY | O_BINARY );
			if( handle != -1 )
			{
			  size_read = read( handle, disk0,drivesize(driveno) );
			  close( handle );
			  if( size_read == -1 )
			  {
						ret=MessageBox(NULL,":( Couldn't open the Working Disk file","PALE Disk Save",MB_YESNO | MB_DEFBUTTON1);
						return(1);
			  }
			  else 
			  {
						size_written = write( handle2, disk0,drivesize(driveno) );
						close( handle2 );
						if( size_written != drivesize(driveno)) 
							return(0);
			  }
			}
			else
			{
				ret=MessageBox(NULL,":( Couldn't open the Working Disk file","PALE Lynx Disk Save",MB_YESNO | MB_DEFBUTTON1);
				return(1);
			}
		}
		else
		{
			ret=MessageBox(NULL,"Couldnt Write the DISK file","PALE Save Disk",MB_YESNOCANCEL | MB_DEFBUTTON2);
			  return(1);
		}
	}
	return(1);
}











void convert_error(int errerno,char errtxt[])
{
	char lbl1[200],lbl2[200],lbl3[200];

	strcpy (errtxt,dsk_strerror(errerno));
	sprintf(lbl3," at Drive:%u Head:%u Track:%u Sector:%u",disk_drive,disk_head,disk_trackreg[disk_drive],disk_sectreg);
	strcat(errtxt,lbl3);
	
	if(disk_trace_on==1)
	{
		sprintf(lbl2,"DSKLIB  ***  ERROR  :  ");
		strcat(lbl2,errtxt);
		fprintf(stream_disk_trace,lbl2);
	}	
}


//REMEMBER - VB these are FUNCTIONS therefore they MUST have a returned variable

extern int _stdcall get_diskstat1(unsigned char set1[])
{
	set1[0]=(unsigned char)disk_comreg;
	set1[1]=(unsigned char)disk_datareg;
	set1[2]=(unsigned char)((disk_options&0x10)==0);
	set1[3]=(unsigned char)disk_motor;
	set1[4]=(unsigned char)disk_precomp;
	set1[5]=(unsigned char)disk_step125;
	return(1);
}

extern int _stdcall get_diskstat2(unsigned char set2[])
{
	int driveno=0;
	set2[0]=(unsigned char)disk_drive;
	set2[1]=(unsigned char)disk_head;
	set2[2]=(unsigned char)disk_trackreg[disk_drive];
	set2[3]=(unsigned char)disk_sectreg;
	set2[4]=(unsigned char)disk_statusreg;
	set2[5]=(unsigned char)disk_options;
	return(1);
}



extern int _stdcall get_cpmvars(unsigned char set2[])
{
	for(int f=0;f<0x100;f++)
		set2[f]=bank1[f];
	return(1);
}

extern  int _stdcall get_diskscan(unsigned char dscan[])
{
	unsigned int f;
	diskscan_start=diskscan_start%(800*1024);

	for(f=0;f<256;f++)
	{
		if(diskscan_driveno==0)
			dscan[f]=bank0[diskscan_start+f];
		else if(diskscan_driveno==1)
			dscan[f]=bank1[diskscan_start+f];
	}
	return(1);
}

extern  int _stdcall set_diskscan(dword start,dword driveno)
{
	diskscan_driveno=driveno;
	diskscan_start=start;
	return(1);
}
