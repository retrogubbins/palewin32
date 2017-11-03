
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


unsigned  char rompath[200];

 unsigned char buffer[LYNX_MAXMEM];//leave room for 64k rom ;)




void create_dummy_rom()
{
	int  handle,handle2;
	unsigned int  ret,size_read,f,g,h,size_written;
	handle = open( "none",O_RDWR | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle != -1 )
	{
		for(f=0;f<0x2000;f++)
			buffer[f]=0xff;
		size_written = write( handle, buffer,0x2000 );
		if( size_written != 0x2000 )
		{
			ret=MessageBox(NULL,":( Couldnt write the Dummy ROM file - duh!","PALE ROM Build",MB_ICONERROR | MB_OK);
			return;
		}
		close(handle);
	}
}


extern  int  _stdcall  build_rom(unsigned char r0[],unsigned char r1[],unsigned char r2[],
								 unsigned char r3[],unsigned char r4[],unsigned char r5[],
								 unsigned char r6[],unsigned char r7[],unsigned char rpath[])
{
	int  handle,handle2;
	unsigned int  size_read,f,g,h,size_written;
	unsigned int cdd,retrn,romend;
	LONG ret;
	char lbl[300];
//	static int first_time=0;

   /* Get the current working directory: */
//	if(first_time==0)
//	if(first==1)
//	{
//		first_time=0;
//		_getcwd( rompath, _MAX_PATH );//save the workign diretory first time as the ROM path
//	}
	for (f=0;f<strlen((const char*)rpath);f++)
		rompath[f]=rpath[f];
	rompath[f]=0;

	_chdir((char *)rompath);   
	
	//Create a dummy 8k ROM thats empty
	create_dummy_rom();

	//Open up all 8 roms involved in the image
	//and copy them to the current rom in use by the emulator
//		sprintf(lbl,"filenames is %s %s %s",r0,r1,r2);
//		retrn=MessageBox(NULL,lbl,"PALE ROM Build",MB_YESNO | MB_DEFBUTTON1);

	//Open up output file
	handle = open( "CURRENT.ROM",O_RDWR | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle != -1 )
	{
		h=0;
		//Now open up each of the 8 ROM files
		//sprintf(lbl,"1st filename is %s",r0);
		//retrn=MessageBox(NULL,lbl,"PALE ROM Build",MB_YESNO | MB_DEFBUTTON1);
		for(g=0;g<8;g++)
		{
			if(g==0)handle2 = open( (char*)r0, O_RDONLY | O_BINARY );
			else if(g==1)handle2 = open( (char*)r1, O_RDONLY | O_BINARY );
			else if(g==2)handle2 = open( (char*)r2, O_RDONLY | O_BINARY );
			else if(g==3)handle2 = open( (char*)r3, O_RDONLY | O_BINARY );
			else if(g==4)handle2 = open( (char*)r4, O_RDONLY | O_BINARY );
			else if(g==5)handle2 = open( (char*)r5, O_RDONLY | O_BINARY );
			else if(g==6)handle2 = open( (char*)r6, O_RDONLY | O_BINARY );
			else if(g==7)handle2 = open( (char*)r7, O_RDONLY | O_BINARY );

			if( handle2 != -1 )
			{
				size_read = read( handle2, buffer,sizeof( buffer ) );
				close( handle2 );
				if( size_read != 8192 )
				{
					sprintf(lbl,":( Encountered a bad ROM size for ROM number %d",g);
					ret=MessageBox(NULL,lbl,"PALE ROM Build",MB_ICONERROR | MB_OK);
					return(0);
				}
				for(f=0;f<0x2000;f++)
					lynx_rom[g*0x2000+f]=buffer[f];
				//	lynx_rom[h++]=buffer[f];
				close(handle2);
			}
			else
			{
					sprintf(lbl,":( Sorry, couldn't find ROM number %d",g);
					ret=MessageBox(NULL,lbl,"PALE ROM Build",MB_ICONERROR | MB_OK );//MB_YESNO | MB_DEFBUTTON1);
					return(0);
			}

		}
		//Now copy the file into the current rom - simple write
		size_written = write( handle, lynx_rom,0x10000 );
		if( size_written != 0x10000 )
		{
			ret=MessageBox(NULL,":( Couldnt write the CURRENT.ROM file - duh!","PALE ROM Build",MB_ICONERROR | MB_OK);
			return(0);
		}
		close(handle);
	}
	else
	{
		ret=MessageBox(NULL,":( Couldn't open up the CURRENT.ROM file","PALE ROM Build",MB_ICONERROR | MB_OK);
		return(0);
	}
//ret=MessageBox(NULL,"ROM BUILT !!!","PALE ROM Build",MB_ICONERROR | MB_OK);
	return(1);
}





int load_lynx_rom()
{
	int  handle,handle2;
	unsigned int  size_read;
	unsigned int cdd,f,romend;
	LONG ret;	
char lbl[200];

	_chdir((const char*)rompath);   

	handle = open("CURRENT.ROM", O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, buffer,
			sizeof( buffer ) );
	  close( handle );
	  if( size_read == -1 )
	  {
//				ret=MessageBox(NULL,":( Found the Current ROM, but not right size","PALE ROM Load",MB_YESNO | MB_DEFBUTTON1);
				return(0);
	  }
	}
	else
	{
//		ret=MessageBox(NULL,":( Couldn't open the Currrent ROM file","PALE ROM Load",MB_YESNO | MB_DEFBUTTON1);
		return(0);
	}
//	ret=MessageBox(NULL,"Loaded the ROM","PALE ROM Load",MB_YESNO | MB_DEFBUTTON1);
//	if (machine_type==LYNX_48)
//		romend=0x4000;
//	else if (machine_type==LYNX_96)
//		romend=0x6000;
//	else if (machine_type==LYNX_128)
//		romend=0x6000;
//	else if (machine_type==LYNX_USER1)
//		romend=0xFFFF;
//	else if (machine_type==LYNX_USER2)
//		romend=0xFFFF;
//	else if (machine_type==LYNX_USER3)
//		romend=0xFFFF;
//	else if (machine_type==LYNX_USER4)
//		romend=0xFFFF;
		romend=0x10000;
	for(f=0;f<romend;f++)
		bank0[f]=buffer[f];

//	ret=MessageBox(NULL,":)  ROM LOADED","PALE ROM Load",MB_YESNO | MB_DEFBUTTON1);
	return(1);
	
}


void patch_lynx_rom()
{
	unsigned int sav_ad;
	//disable a few ROM IO routines [and trap others?)
//return;

//remove checksumming on Tape MLOAD	
//bank0[0x3fa7]=0;
//bank0[0x3fa8]=0;


	set_t_mode(tape_mode);	//sets tape mode TAP or RAW
	
	return;


if (hw_type==LYNX_HARDWARE_48 || hw_type==LYNX_HARDWARE_96)
{	

	//These are for the TAPE load/save routines
	bank0[0xd67]=0xed;	//change Tape Byte output, just return 0 in A ?
	bank0[0xd68]=0x00;
	bank0[0xd69]=0xc9;	

	bank0[0xb65]=0xc9;	//disabled completely - Read Tape Sync
	
//	bank0[0xcd4]=0xed;	//change Read Bit, just return 1 in A
//	bank0[0xcd5]=0x01;
//	bank0[0xcd6]=0xc9;
	bank0[0xcd4]=0xc3;	//change Read Bit, just return 1 in A
	bank0[0xcd5]=0xd5;
	bank0[0xcd6]=0x0c;

	bank0[0xc95]=0xc3;	//set up an infint loop to wait here whilst VB is loading the RAM
	bank0[0xc96]=0x95;
	bank0[0xc97]=0x0c;

	bank0[0x3f62]=0xc3;	//and again for MLOAD
	bank0[0x3f63]=0x62;
	bank0[0x3f64]=0x3f;

	
	//Patch Save routine to output OUT 93,x trapped here as SAVE
	//jump back in at 0cfb

	sav_ad=0xbcb;
	bank0[sav_ad+0]=0x20;
	bank0[sav_ad+1]=0xf4;
	bank0[sav_ad+2]=0x01;//ld BC,0093
	bank0[sav_ad+3]=0x93;
	bank0[sav_ad+4]=0x00;
	bank0[sav_ad+5]=0xed;//out a (c)
	bank0[sav_ad+6]=0x79;
	bank0[sav_ad+7]=0x00;//never gets to these :)
	bank0[sav_ad+8]=0x00;




//	bank0[0x8cf]=0xc9;			//dev clear srcreen ld a,b etc bugs araound 08da in 48/96k rom










}
else if (hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)

{
	//LYNX 128 STUFF
	//LYNX 128 STUFF
	//LYNX 128 STUFF

	//These are for the TAPE load/save routines
	bank0[0xd3d]=0xed;	//change Tape Byte output, just return 0 in A ?
	bank0[0xd3e]=0x00;
	bank0[0xd3f]=0xc9;	
	bank0[0xb65]=0xc9;	//disabled completely - Read Tape Sync

	bank0[0xd76]=0xed;	//change Read Bit, just return 1 in A
	bank0[0xd77]=0x01;
	bank0[0xd78]=0xc9;

	//NOW disable LOAD & MLOAD completely
//	bank0[0xc95]=0xc3;
//	bank0[0xc96]=0x95;
	//	bank0[0xc97]=0x0c;

	bank0[0xc92]=0xc3;
	bank0[0xc93]=0x92;
	bank0[0xc94]=0x0c;

//	bank0[0x5f2a]=0xc3;
//	bank0[0x5f2b]=0x62;
//	bank0[0x5f2c]=0x3f;
	bank0[0x5f2a]=0xc3;
	bank0[0x5f2b]=0x2a;
	bank0[0x5f2c]=0x5f;


	
	//Patch Save routine to output OUT 93,x trapped here as SAVE
	//jump back in at 0cfb
	sav_ad=0xbcb;
	bank0[sav_ad+0]=0x20;
	bank0[sav_ad+1]=0xf4;
	bank0[sav_ad+2]=0x01;//ld BC,0093
	bank0[sav_ad+3]=0x93;
	bank0[sav_ad+4]=0x00;
	bank0[sav_ad+5]=0xed;//out a (c)
	bank0[sav_ad+6]=0x79;
	bank0[sav_ad+7]=0x00;//never gets to these :)
	bank0[sav_ad+8]=0x00;

	
	//LYNX 128 Patches
	//YEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEESS
//	bank0[0x1f8e]=0xc9;	//disables setup of variables area (at moment VTBL is too low and overwrites jumpblocks)

//	bank0[0x1f8f]=0x07;//usual Lynx 48K values
//	bank0[0x1f90]=0x67;

	//why these two bytes were wrong in the rom I dont know ?)
	bank0[0x1746]=0x07;  // becomes VTBL at 6210		NOT NEEDED for Russells ROM but here anyway for ROM1281 from Martyn
	bank0[0x1747]=0x67;		//6211
}



}


