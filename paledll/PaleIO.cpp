#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <io.h>
#include <time.h>
#include "z80.h"
#include "windows.h"


#include <stdlib.h>
#include "libdsk.h"
#include "Paledisk.h"
#include "Pale.h"
#include "PaleIO.h"
#include "PaleVID.h"
#include "PalePRINTER.h"
#include "PaleMEM.h"
#include "PaleTAPS.h"
#include "PaleUTILS.h"
#include "IOPort.h"

byte speccy_port_in=0;
byte speccy_port_out=0;
int start_im1_irq=0;
int start_ss_nmi=0;
int break_nmi=0;
unsigned char show_bank2;
unsigned char show_bank3;
unsigned char show_alt_green;

extern void save_lynx_tap();

byte z80ports_in[LYNX_MAXPORTS];
byte z80ports_out[LYNX_MAXPORTS];
int ip_port;
unsigned char bank_latch;//=0xff;
unsigned char video_latch;//=0xff;
unsigned char port84;//=0x00;
unsigned  char crtc_reg=0;


void set_banklatch(unsigned char yg)
{
	bank_latch=yg;
}

void Z80_Out (dword Port,byte Value)
{ 
	static byte raw_motor_last=0;
	static byte Value_last=0;
	static unsigned int temp_bufptr=0;
	static byte video_latch_last=0;
	unsigned int ret,f,g,Max;
	unsigned long soundtim_this;
	char lbl[200],lbl2[200];
	unsigned int tmp;
	unsigned int cycs_per_sample;
	static byte port84_last=0;
	float emu_clock;


	if(hw_type==LYNX_HARDWARE_HACKSPECCY) //if(speccy==1)return;
	{
		if((Port & 0x00fe)==0x00fe )
			speccy_port_out=Value;//NOOOOOOOOOOOOOOOOOOOOOO!
		return;
	}

	z80ports_out[Port]=Value;

	// BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH 
	// BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH 
	// BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH 
	// BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH  BANK LATCH 
	if(hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
	{
		if((Port & 0xff)==0x82)
		{
			bank_latch=Value;
		}
	}
	else
	{

//FIXME - rev2x pcbs have this modded to xx7f thus releasing b register (also one of the SPLYNX mods)

//fixme so this should prob be 0x00ff

			if((Port & 0x207f)==0x207f)
		//	if((Port & 0xff)==0x7f)   -  this doesnt work for interline writes eg PENGO - prob because it should be ox00ff
			{
				bank_latch=Value;
			}
	}	
	
	//  VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH  
	//  VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH  
	//  VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH  
	//  VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH   VIDEO LATCH  
// fixme - get this right prob an &0x00ff too
	
	if((Port & 0xff)==0x80)
	{
		video_latch_last=video_latch;
		video_latch=Value;
	
		
		if((video_latch & 0x10)==0x10)	//0= show green bank, 1=alt green
			show_alt_green=1;
		else
			show_alt_green=0;


		show_bank2=show_bank3=1;

	//	if((video_latch & 0x40)==0x40)//interline monostable freezes z80 till next scanline
	//		set_blank_mono(1);		
		
		
		if(hw_type==LYNX_HARDWARE_48 || hw_type==LYNX_HARDWARE_96)
		{
			//THESE NEXT ONLY AFFECT THE 4896
			if((video_latch & 0x04)==0x04)// && (video_latch & 0x20)==0x00)	//0= show red/blue bank, 1=inhibit
				show_bank2=0;
			else
				show_bank2=1;
			if((video_latch & 0x08)==0x08)// && (video_latch & 0x20)==0x00)	//0= show green/altgreen bank, 1=inhibit
				show_bank3=0;
			else
				show_bank3=1;
			if((Value & 0x02)==0x02)	//0= motor off, 1=on
			{
				raw_motor=1;
			}
			else
			{
				raw_motor=0;
				stop_tape();
			}
		}
		else
		{
			if((Value & 0x08)==0x08)	//0= motor off, 1=on
			{
				raw_motor=1;
			}
			else
			{
				raw_motor=0;
				stop_tape();
			}
		}
	}

	// CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC 
	// CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC 
	// CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC 
	// CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC  CRTC 
	if((Port & 0xff)==0x86)	//CRTC register select
	{
		crtc_reg=Value;
	}
	if((Port & 0xff)==0x87)	//CRTC data reg
	{
		CRTC_reg[crtc_reg]=Value;
		if((crtc_reg==10) && ((Value & 0x20)==0x20))
			cursor_on=FALSE;
		if((crtc_reg==10) && ((Value & 0x20)!=0x20))
			cursor_on=TRUE;
	}

	// SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND 
	// SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND 
	// SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND 
	// SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND  SOUND 
	// AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE 
	// AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE 
	// AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE 
	// AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE AND TAPE 
	
	if(((Port & 0xff)==0x84)) 
	{
		port84=Value;
		if((raw_motor==1) && (tape_operation==TAPE_STOPPED))
			start_tape_record();
	}

	


	//  DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK 
	//  DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK 
	//  DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK 
	//  DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK   DISK 
	if((Port & 0xff)==0x54)	//DISK Write reg 1793 Command/Status Register
	{
		disk_comreg=Value;
		do_disk_command();
	}



	if((Port & 0xff)==0x55)	//DISK Write reg 1793 Track Register
	{
		do_disk_updates();	//if a command is pending then do it
		disk_trackreg[disk_drive]=Value;
		disk_track_buf_ptr=0;
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Set TRACK = %d\n",disk_trackreg[disk_drive]);
			fprintf(stream_disk_trace,lbl2);
		}
		if(Value>=dgeom[disk_drive].dg_cylinders)
		{
			disk_trackreg[disk_drive]=dgeom[disk_drive].dg_cylinders-1;
			if(disk_trace_on==1)
			{
				sprintf(lbl2,"Limited - Trackreg = %d\n",disk_trackreg[disk_drive]);
				fprintf(stream_disk_trace,lbl2);
			}
		}
	
	}
	if((Port & 0xff)==0x56)	//DISK Write reg 1793 Sector Register
	{
		do_disk_updates();	//if a command is pending then do it
		disk_sectreg=Value;
		disk_sect_buf_ptr=0;
		if(disk_trace_on==1)
		{
			sprintf(lbl2,"Set SECTOR = %d\n",disk_sectreg);
			fprintf(stream_disk_trace,lbl2);
		}
	}

	
	if((Port & 0xff)==0x57)	//DISK Write reg 1793 Data Register
	{
		if((disk_comreg & 0xf8)==0xf0)	//if were in a write track command
		{
			if(disk_trace_on==1)
			{
				sprintf(lbl2,">>> DATA Write (Track) - Head %d Track %d Sector %d Ptr %d  Value %2X\n",disk_head_to_write,disk_track_to_write,disk_sect_to_write,disk_track_buf_ptr,Value);
				fprintf(stream_disk_trace,lbl2);
			}
			disk_statusreg=0x00;//disk_statusreg | 0x02;//set DRQ data request active
			disk_statusreg=disk_statusreg | 0x02;//set readuy for data
			disk_statusreg=disk_statusreg | 0x01;//set busy flag
			//THROW AWAY first 90 bytes of DAM header
			//just pass the data for each sector through to libdsk

			//rubbish code
			//I dont do anything with the trackbuf created here anyway at the moment
			if(temp_bufptr++>90)
//					disk_track_buf[disk_track_buf_ptr++]=Value;
//					disk_track_buf[disk_track_buf_ptr]=Value;
			if(temp_bufptr>603)
				temp_bufptr=0;

			disk_track_buf_ptr++;
			if(disk_track_buf_ptr>=BYTES_PER_TRACK)
			{
				do_disk_updates();
				disk_statusreg=0x00;
			}
		}
		else if((disk_comreg & 0xe0)==0xa0)	//write sector command
		{
			if(disk_trace_on==1)
			{
				sprintf(lbl2,">>> DATA Write (Sector) - Drive %d Side %d Track %d Sector %d DataP %d  Value %2X\n",disk_drive_to_write,disk_head_to_write,disk_track_to_write,disk_sect_to_write,disk_sect_buf_ptr,Value);
				fprintf(stream_disk_trace,lbl2);
			}
			disk_statusreg=0x00;//disk_statusreg | 0x02;//set DRQ data request active
			disk_statusreg=disk_statusreg | 0x02;//set readuy for data
			disk_statusreg=disk_statusreg | 0x01;//set busy flag

			if(disk_sect_buf_ptr<BYTES_PER_SECT)disk_sect_buf[disk_sect_buf_ptr++]=Value;
			if(disk_sect_buf_ptr>=BYTES_PER_SECT)
			{
				do_disk_updates();
				disk_statusreg=0x00;//disk_statusreg | 0x02;//set DRQ data request active
			}
		}
		disk_datareg=Value;
		return;
	}
	if((Port & 0xff)==0x58)	//DISK Write Options
	{
		do_disk_updates();	//if a command is pending then do it

		disk_options=Value;
		if((disk_options&0x10)==0x10)
			 disk_rom_enabled=1;
		else
			 disk_rom_enabled=0;
		if((disk_options&0x08)==0x08)
			 disk_motor=0;
		else
			 disk_motor=1;
		if((disk_options&0x40)==0x40)
			 disk_precomp=0;
		else
			 disk_precomp=1;
		if((disk_options&0x80)==0x80)
			 disk_step125=1;
		else
			 disk_step125=0;	//defaults back to 250ns

		disk_drive=disk_options & 0x03;

		if((disk_options & 0x04)==0x04)
		{
			disk_head=1;
			if(disk_trace_on==1)
			{
				sprintf(lbl2,"Disk Head = 1\n");
				fprintf(stream_disk_trace,lbl2);
			}
		}
		else
		{
			disk_head=0;
			if(disk_trace_on==1)
			{
				sprintf(lbl2,"Disk Head = 0\n");
				fprintf(stream_disk_trace,lbl2);
			}
		}
		if(disk_trace_on==1)
		{
				sprintf(lbl2,"Disk Options Set - Options = %2X\n",Value);
				fprintf(stream_disk_trace,lbl2);
		}
	}




	// PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF
	// PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF
	// PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF
	// PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF
	// PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF
	// PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF
	if((Port & 0xff)==0x7d)	//Printer Initialise reg
	{
		if(printer_type==PRINTER_REAL)
		{
			outportb(printer_current_cport,0x01);	//Lynx uses Read port usually
		}
		else
		{
			//HAH - prob used asthe strobe too...
			//	MessageBox(NULL,"Printer Init WRITE","PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
		}
	}

	if((Port & 0xff)==0x7e)	//Printer Data reg
	{
		//Okay, store the incoming data in a jolly old circular buffer
		printer_data=Value;
		if(printer_type==PRINTER_REAL)	//  unless its the real DEAL  ;)
		{
			outportb(printer_current_oport,printer_data);

			Sleep(2);
			outportb(printer_current_cport,0x01);
			Sleep(2);
			outportb(printer_current_cport,0x00);
			Sleep(2);
		}
		else
		{
			printer_buffer[printer_head]=printer_data;
			printer_head=(printer_head+1)%PRINTER_BUFLEN;

		}
	}

	if((Port & 0xff)==0x93)//trap for SAVE routine
	{
		save_lynx_tap();
	}
} 


unsigned char testbit(char inbyt,int testbi)
{

	return((inbyt & (0x01<<testbi))>>testbi);


}


void map_speccy_keys()
{
	bit(&z80ports_in[0xbffe],0,testbit(z80ports_in[0x980],3));
	bit(&z80ports_in[0xbffe],1,testbit(z80ports_in[0x780],2));
	bit(&z80ports_in[0xbffe],2,testbit(z80ports_in[0x680],5));
	bit(&z80ports_in[0xbffe],3,testbit(z80ports_in[0x580],5));
	bit(&z80ports_in[0xbffe],4,testbit(z80ports_in[0x480],2));
		
	bit(&z80ports_in[0x7ffe],0,testbit(z80ports_in[0x480],3));
	bit(&z80ports_in[0x7ffe],1,testbit(z80ports_in[0x280],6));//sym shift
	bit(&z80ports_in[0x7ffe],2,testbit(z80ports_in[0x580],3));
	bit(&z80ports_in[0x7ffe],3,testbit(z80ports_in[0x480],4));
	bit(&z80ports_in[0x7ffe],4,testbit(z80ports_in[0x480],5));

	bit(&z80ports_in[0xfefe],0,testbit(z80ports_in[0x080],7) & testbit(z80ports_in[0x980],0) & testbit(z80ports_in[0x980],5) & testbit(z80ports_in[0x980],2)
			 & testbit(z80ports_in[0x080],4) & testbit(z80ports_in[0x080],5));//SHIFT

	bit(&z80ports_in[0xfefe],1,testbit(z80ports_in[0x280],3));
	bit(&z80ports_in[0xfefe],2,testbit(z80ports_in[0x180],3));
	bit(&z80ports_in[0xfefe],3,testbit(z80ports_in[0x180],5));
	bit(&z80ports_in[0xfefe],4,testbit(z80ports_in[0x380],3));

	bit(&z80ports_in[0xfdfe],0,testbit(z80ports_in[0x280],5));//A
	bit(&z80ports_in[0xfdfe],1,testbit(z80ports_in[0x280],4));
	bit(&z80ports_in[0xfdfe],2,testbit(z80ports_in[0x180],4));
	bit(&z80ports_in[0xfdfe],3,testbit(z80ports_in[0x380],5));//F
	bit(&z80ports_in[0xfdfe],4,testbit(z80ports_in[0x380],4));

	bit(&z80ports_in[0xfbfe],0,testbit(z80ports_in[0x280],1));
	bit(&z80ports_in[0xfbfe],1,testbit(z80ports_in[0x280],2));
	bit(&z80ports_in[0xfbfe],2,testbit(z80ports_in[0x180],2));
	bit(&z80ports_in[0xfbfe],3,testbit(z80ports_in[0x380],1));
	bit(&z80ports_in[0xfbfe],4,testbit(z80ports_in[0x380],2));

	bit(&z80ports_in[0xf7fe],0,testbit(z80ports_in[0x080],0));
	bit(&z80ports_in[0xf7fe],1,testbit(z80ports_in[0x280],0));
	bit(&z80ports_in[0xf7fe],2,testbit(z80ports_in[0x180],0));
	bit(&z80ports_in[0xf7fe],3,testbit(z80ports_in[0x180],1));
	bit(&z80ports_in[0xf7fe],4,testbit(z80ports_in[0x380],0) & testbit(z80ports_in[0x980],2));

	bit(&z80ports_in[0xeffe],0,testbit(z80ports_in[0x780],0) & testbit(z80ports_in[0x980],0));// 0

	bit(&z80ports_in[0xeffe],1,testbit(z80ports_in[0x680],0));
	bit(&z80ports_in[0xeffe],2,testbit(z80ports_in[0x580],1) & testbit(z80ports_in[0x980],5));
	bit(&z80ports_in[0xeffe],3,testbit(z80ports_in[0x580],0) & testbit(z80ports_in[0x080],4));
	bit(&z80ports_in[0xeffe],4,testbit(z80ports_in[0x480],0) & testbit(z80ports_in[0x080],5));

	bit(&z80ports_in[0xdffe],0,testbit(z80ports_in[0x780],1));
	bit(&z80ports_in[0xdffe],1,testbit(z80ports_in[0x680],2));
	bit(&z80ports_in[0xdffe],2,testbit(z80ports_in[0x680],1));
	bit(&z80ports_in[0xdffe],3,testbit(z80ports_in[0x580],2));
	bit(&z80ports_in[0xdffe],4,testbit(z80ports_in[0x480],1));
}


byte Z80_In (dword Port)
{  
	unsigned char tmp;
	unsigned int tmp2;
	char lbl[200],lbl2[200];
	static unsigned int raw_motor_last2=0;
	static char e=0;

	
	if(hw_type==LYNX_HARDWARE_HACKSPECCY) //if(speccy==1)
	{

		map_speccy_keys();

		if(Port==0x7ffe)
		{
			if(tape_level>raw_threshold)  //80)For Zen (Tape 3)  //70)for Colossal adventure
				bit(&z80ports_in[0x7ffe],6,1);
			else
				bit(&z80ports_in[0x7ffe],6,0);
		}	
		return(z80ports_in[Port]);//980 is enter key for lynx
	
	}

	//	if((Port & 0xff)==0x84)		//SINGLE STEP PORT  ?only 128???
	//		start_nmi_irq=1;


	// DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT   
	// DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT   
	// DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT   
	// DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT   
	// DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT   
	// DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT    DISK INPUT   
	if((Port & 0xff)==0x50)
	{
		//		if(disk_trace_on==1)
		//		{
		//			sprintf(lbl2," STATUS READ Value = %2X\n",disk_statusreg);
		//			fprintf(stream_disk_trace,lbl2);
		//		}
		return(disk_statusreg);//noticce that dual purpose here
	}
	if((Port & 0xff)==0x51)
		return(disk_trackreg[disk_drive]);
	if((Port & 0xff)==0x52)
		return(disk_sectreg);
	if((Port & 0xff)==0x53)
	{
		if((disk_comreg & 0xe0)==0x80)	//if were in a read sector command
		{
			tmp=disk_sect_buf[disk_sect_buf_ptr++];
			if(disk_trace_on==1)
			{
				sprintf(lbl2," *** DATA Read (Sector) - Drive %d Head %d Track %d ,Sector %d, SECT BUFPTR %d  Value = %2X\n",disk_drive,disk_head,disk_trackreg[disk_drive],disk_sectreg,disk_sect_buf_ptr-1,tmp);
				fprintf(stream_disk_trace,lbl2);
			}

			if(disk_sect_buf_ptr>=BYTES_PER_SECT)
			{
				disk_statusreg=0x00;
				disk_sect_buf_ptr=0;
			}
			return(tmp);
		}
		else if((disk_comreg & 0xf8)==0xc0)//Read Address
		{
			tmp=disk_sect_buf[disk_sect_buf_ptr++];

			if(disk_sect_buf_ptr>=8)
			{
				disk_statusreg=0x00;
				disk_sect_buf_ptr=0;
			}			
			return(tmp);
		}
		sprintf(lbl2,"some other read of 53 port is %2X",Port);
		MessageBox(NULL,lbl2,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
		return(disk_datareg);
	}

	// PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF
	// PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF PRINTER STUFF
	if((Port & 0xff)==0x7c)	//Printer status reg
	{
		if(printer_type==PRINTER_REAL)
		{
			unsigned char p_busy,p_sel,p_pe;
			printer_status=inportb(printer_current_iport);	//bit 2 is the /INIT for the printer
			p_busy=(printer_status & 0x80)>>7;	//shift status bit into lynx BUSY
			p_sel=~(printer_status & 0x10)>>2;	//shift status bit into lynx SEL in
			p_pe=(printer_status & 0x20)>>4;	//PE paper end	
			printer_status=p_busy | p_sel | p_pe;			
			return(printer_status);
		}
		else
		{
			return(printer_status);
		}
	}

	if((Port & 0xff)==0x7d)	//Printer Initialise reg
	{
		if(printer_type==PRINTER_REAL)
		{
			init_the_printer();
		}
		else
		{
			//		MessageBox(NULL,"Printer Init READ","PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
		}
	}

	// TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE 
	// TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE 
	// TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE 
	// TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE  TAPE 

	
	

	if(((Port & 0xff)==0x80) && (raw_motor==1))
	{
		if(hw_type==LYNX_HARDWARE_96 || hw_type==LYNX_HARDWARE_48)
		{
			if(tape_operation==TAPE_STOPPED)
				start_tape_play();

			if(tape_level>raw_threshold)  //80)For Zen (Tape 3)  //70)for Colossal adventure
				bit(&z80ports_in[0x80],0,0);
				//return(z80ports_in[Port] | 0x4f);
			else
				bit(&z80ports_in[0x80],0,1);
		}
	}

	if(((Port & 0xff)==0x82) && (raw_motor==1))	// 128 Tape Input port
	{
		{
			if(tape_operation==TAPE_STOPPED)
				start_tape_play();

			if(tape_level>raw_threshold)  //80)For Zen (Tape 3)  //70)for Colossal adventure
				bit(&z80ports_in[0x82],2,0);
			else
				bit(&z80ports_in[0x82],2,1);
			return(z80ports_in[0x82]);//mimic the inverter inside lynx
		}
	}

	if((Port & 0xff)==0x87)	//CRTC data reg - not accurate emu
		return(CRTC_reg[crtc_reg]);
	else
		return(z80ports_in[Port]);



} 

 

void clearports()
{
int y;
	//SET ALL PORTS TO Default values
	for(unsigned int f=0;f<LYNX_MAXPORTS;f++)
	{
		z80ports_in[f]=0xff;
		//IMPORTANT IN PORTS
		//FOR 128
		//0x84  single step port ?
		z80ports_out[f]=0x00;
	}
	//set up the main bank ports
	video_latch=0x00;

	bank_latch=0x00;
	disk_rom_enabled=1;
}




//Set up the Interface routines to z80 engine
void Z80_Patch (Z80_Regs *Regs)
{ } 

int Z80_Interrupt(void)
{  

	static int ii=0,jj=0;
	
	if ((start_ss_nmi==1))// || (break_nmi==1))	//not corrrect EMU
	{
		start_ss_nmi=0;
		return(Z80_NMI_INT);
	}	
	else if ( start_im1_irq==1 || (break_nmi==1))//who knows, is the key to here or what !!?
	{
			start_im1_irq=0;
			return(0xff);//IM1 interrupt device  FF - rst 38
	}
	else
		return(Z80_IGNORE_INT );
}




extern  int _stdcall  set_inp( unsigned int loc,unsigned int val)
{
	loc=loc&0x0000ffff;
	z80ports_in[loc]=val;

if(loc==0x7f)bank_latch=val;	
	return(0);
}
