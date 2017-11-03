#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <io.h>

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


 byte lynx_rom[LYNX_MAXMEM];// lynx ROM copy - updated to allow for many roms
 byte bank0[LYNX_MAXMEM]; //rom bank
 byte bank1[LYNX_MAXMEM]; //user ram bank
 byte bank2[LYNX_MAXMEM]; //video memory (all colors in here for 128k version)
 byte bank3[LYNX_MAXMEM]; //expanded video memory	(for 48 & 96, green/alt green in here
 byte bank4[LYNX_MAXMEM]; //expanded user memory (for 128)
 byte vid_mem[262144];
unsigned int memscan_bno=0;
unsigned int memscan_start=0;


//unsigned char speccy=0;

// byte disk_rom_disabled=0;

 byte disk_rom_enabled=1;
 
 
 unsigned Z80_RDMEM(dword A)
{
	char lbl[100];


	if(hw_type==LYNX_HARDWARE_HACKSPECCY)//if(speccy==1)
	{
			return(bank0[A]);
	}



	if(hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
	{
		

	
		if((bank_latch & 0x08)==0)
		{
			if (A<0x6000)	
				return(bank0[A]);
			if(bank0[0xe000]!=0xff) // && (disk_rom_enabled==1))	// Disk rom is special - can be turned off
			{
				if((A>=0xe000)   && ((disk_options & 0x10)==0))
					return(bank0[A]);
			}

/*
			if(bank0[0xc000]!=0xff)
			{
				if(A>=0xc000)
					return(bank0[A]);
			}
*/
		//	return(0xff);
		}

		//THIS IS THE CORRECT PRIORITY FOR CPM TO WORK
		if ((bank_latch & 0x02)==0x02)	// WORKS VIDEO RAM
		{
				return(bank2[A]);  //other video banks read
		}else

		if ((bank_latch & 0x04)==0)	//USER RAM
		{
				return(bank1[A]);
		}
			

	//	if(hw_type==LYNX_HARDWARE_256)
	//	{
	//		if((bank_latch & 0x22)==0x02)	//VIDEO RAM
	//				return(bank2[A]); 
	//		else if((bank_latch & 0x22)==0x22)	//VIDEO RAM
	//		{
	//				return(bank3[A]);  //the seconds set of video memory
	//		}
	//	}

		
    //	if(hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
	//	{
	//		if ((bank_latch & 0x01)==0x01)	//expanded user ram
	//				return(bank4[A]);
	//	}
	}
	else
	{
		//see if ROM is paged in or not
		if((bank_latch & 0x10)==0 )		//ROMS BANK 0
		{
			//	sprintf(lbl," BANK0 READ PC=%4X  VidLatch=%X BankLatch=%X Addr=%X:( ",get_pc(),video_latch,bank_latch,A);
			//	MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
			//	exit(-1);
			//	return(0xff);
			if (A<0x6000)
				return(bank0[A]);
			//			if((A>=0x6000) && (A<0x8000))
			//				return(bank0[0xe000+(A-0x6000)]);
			//			if(A>=0x8000 && A<0xc000)
			//				return(bank0[A-0x8000]);
			//if(A>=0xc000 && A<0xe000)
			//	return(bank0[0x4000+(A-0xc000)]);
//			if(machine_type==LYNX_96_DISK)
			if(bank0[0xe000]!=0xff) //&& (disk_rom_enabled==1))	// Disk rom is special - can be turned off
			{
				if((A>=0xe000)   && ((disk_options&0x10)==0))
				return(bank0[A]);
			}
//			if(bank0[0xc000]!=0xff)
//			{
//				if(A>=0xc000)
//				return(bank0[A]);
//			}
		
		}	

		
		
		if ((bank_latch & 0x20)==0)	//USER RAM
		{
//			if(machine_type==LYNX_96 || machine_type==LYNX_96_DISK)
			if(hw_type==LYNX_HARDWARE_96)
		//	if(hw_type==LYNX_96 || hw_type==LYNX_96_DISK)
			{
				return(bank1[A]);
			}
			else
			{
				if(A>=0x6000 && A<0x8000)
					return(bank1[A]);
				if(A>=0xe000 && A<=0x10000)		//Mirror
					return(bank1[A-0x8000]);	
				if(A>=0x8000 && A<0xa000)
					return(bank1[A]);
				if(A>=0x0000 && A<0x2000)
					return(bank1[A+0x8000]);	//mirror
				if(A>=0x2000 && A<0x4000)
					return(bank1[A+0x8000]);	//mirror
				if(A>=0x4000 && A<0x6000)
					return(bank1[A+0x2000]);	//mirror
				if(A>=0xa000 && A<0xc000)
					return(bank1[A-0x2000]);	
				if(A>=0xc000 && A<0xe000)
					return(bank1[A-0x6000]);	//mirror
			}
		}
	//	return(0xff);  //  ;>
		if ((bank_latch & 0x40)==0x40)	//vidram

		{
			if ((video_latch & 0x04)==0) 
			{
				if(A>=0xa000 && A<0xe000)
					return(bank2[A]);		//BLUE  RED
				if(A>=0x8000 && A<0xa000)
					return(bank2[A+0x2000]);	//mirror
				if(A>=0x6000 && A<0x8000)
					return(bank2[A+0x6000]);	//mirror
				if(A>=0xe000 && A<0x10000)
					return(bank2[A-0x2000]);	//mirror
				if(A>=0x0000 && A<0x2000)
					return(bank2[A+0xa000]);	//mirror
				if(A>=0x2000 && A<0x4000)
					return(bank2[A+0x8000]);	//mirror
				if(A>=0x4000 && A<0x6000)
					return(bank2[A+0x8000]);	//mirror
			}
			if ((video_latch & 0x08)==0)
			{
				if(A>=0xa000 && A<0xe000)
					return(bank3[A]);//		if((video_latch & 0x20)==0x20 && (bank_latch & 0x02)==0x02)
											//AGREEN  GREEN
				if(A>=0x8000 && A<0xa000)
					return(bank3[A+0x2000]);	//mirror
				if(A>=0x6000 && A<0x8000)
					return(bank3[A+0x6000]);	//mirror
				if(A>=0xe000 && A<0x10000)
					return(bank3[A-0x2000]);	//mirror

				if(A>=0x0000 && A<0x2000)
					return(bank3[A+0xa000]);	//mirror
				if(A>=0x2000 && A<0x4000)
					return(bank3[A+0x8000]);	//mirror
				if(A>=0x4000 && A<0x6000)
					return(bank3[A+0x8000]);	//mirror
			}
		}

	}
//	sprintf(lbl," ERROR - couldnt find that memory address PC=%4X   VidLatch=%X BankLatch=%X Addr=%X:( ",get_pc(),video_latch,bank_latch,A);
//	MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
	return(0xff);  //  ;>
}

void Z80_WRMEM(dword A,byte V)
{
	char lbl[100];



	if(hw_type==LYNX_HARDWARE_HACKSPECCY)//if(speccy==1)
	{
		if((A<0x4000)) //|| (A>=0xc000))
			return;
		else
			bank0[A]=V;
		return;
	}


	if(hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
	{

		if((bank_latch & 0x80)==0)
		{
			bank1[A]=V;				//USER MEMORY WRITE
		}

		if((bank_latch & 0x40)==0x40) //WORKS
		{
			bank2[A]=V;		//standard video  write to red/blue/green
		}		
		
		
		
		//	if(hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
	//	{
	//		if((bank_latch & 0x10)==0x10)
	//					bank4[A]=V;
	//	}
	//	if(hw_type==LYNX_HARDWARE_256)
	//	{
	//			if((bank_latch & 0x60)==0x40) //WORKS
	//					bank2[A]=V;		//standard video  write to red/blue/green
	//			else if((bank_latch & 0x60)==0x60)
	//			{
	//				bank3[A]=V;		//secnond vid bank
	//			}
	//	}
	}
	else
	{
		if((bank_latch & 0x01)==0)
		{
//			if(machine_type==LYNX_96 || machine_type==LYNX_96_DISK)
//			if(hw_type==LYNX_96 || hw_type==LYNX_96_DISK)
			if(hw_type==LYNX_HARDWARE_96)
						bank1[A]=V;
			else
			{
				if(A>=0x6000 && A<0x8000)
					bank1[A]=V;
				else if(A>=0xe000 && A<=0x10000)	//mirror
					bank1[A-0x8000]=V;
				else if(A>=0x8000 && A<0xa000)
					bank1[A]=V;
				else if(A>=0x0000 && A<0x2000)
					bank1[A+0x8000]=V;
				else if(A>=0x2000 && A<0x4000)
					bank1[A+0x6000]=V;
				else if(A>=0x4000 && A<0x6000)
					bank1[A+0x2000]=V;
				else if(A>=0x0000 && A<0x2000)
					bank1[A+0x8000]=V;
				else if(A>=0xc000 && A<0xe000)
					bank1[A-0x6000]=V;
				else if(A>=0xa000 && A<0xc000)
					bank1[A-0x2000]=V;
			}
		}
//		if((video_latch & 0x20)==0x20 && (bank_latch & 0x02)==0x02)
		if((bank_latch & 0x02)==0x02)
		{
			if ((video_latch & 0x04)==0) 
			{
				if(A>=0xa000 && A<0xe000)
					bank2[A]=V;				// BLUE RED
				else if(A>=0x8000 && A<0xa000)
					bank2[A+0x2000]=V;				// mirror
				else if(A>=0x6000 && A<0x8000)
					bank2[A+0x6000]=V;				// mirror
				else if(A>=0xe000 && A<0x10000)
					bank2[A-0x2000]=V;				// mirror
				else if(A>=0x0000 && A<0x2000)
					bank2[A+0xa000]=V;				// mirror
				else if(A>=0x2000 && A<0x4000)
					bank2[A+0x8000]=V;				// mirror
				else if(A>=0x4000 && A<0x6000)
					bank2[A+0x8000]=V;				// mirror

	//NOT TESTED YET - WERE MISSING
				//ONE MIRROR OUT OF THE VIDEO READS AND WRITESS

				//		else if(A>=0xa000 && A<0xc000)
		//			bank2[A-0x2000]=V;				// mirror
			}
		}
//		if((video_latch & 0x20)==0x20 && (bank_latch & 0x04)==0x04)
		if((bank_latch & 0x04)==0x04)

		{
			if ((video_latch & 0x08)==0) 
			{
				if(A>=0xa000 && A<0xe000)
					bank3[A]=V;				//AGREEN  GREEN
				else if(A>=0x8000 && A<0xa000)
					bank3[A+0x2000]=V;				// mirror
				else if(A>=0x6000 && A<0x8000)
					bank3[A+0x6000]=V;				// mirror
				else if(A>=0xe000 && A<0x10000)
					bank3[A-0x2000]=V;				// mirror

				else if(A>=0x0000 && A<0x2000)
					bank3[A+0xa000]=V;				// mirror
				else if(A>=0x2000 && A<0x4000)
					bank3[A+0x8000]=V;				// mirror
				else if(A>=0x4000 && A<0x6000)
					bank3[A+0x8000]=V;				// mirror
			}
		}
	}
}



extern  int  _stdcall  save_mem_dump()
{
	int  handle2;
    int size_written;

    /* open a file for output		  */
    handle2 = open( "mem0.dmp",O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
      size_written = write( handle2, bank0,
			    LYNX_MAXMEM );
		close( handle2 );
      if( size_written != LYNX_MAXMEM ) 
		  return(0);
	}
	else
	{
		  return(0);
	}
    handle2 = open( "mem1.dmp",O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
      size_written = write( handle2, bank1,
			    LYNX_MAXMEM );
		close( handle2 );
      if( size_written != LYNX_MAXMEM ) 
		  return(0);
	}
	else
	{
		  return(0);
	}
    handle2 = open( "mem2.dmp",O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
      size_written = write( handle2, bank2,
			    LYNX_MAXMEM );
		close( handle2 );
      if( size_written != LYNX_MAXMEM ) 
		  return(0);
	}
	else
	{
		  return(0);
	}
    handle2 = open( "mem3.dmp",O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
      size_written = write( handle2, bank3,
			    LYNX_MAXMEM );
		close( handle2 );
      if( size_written != LYNX_MAXMEM ) 
		  return(0);
	}
	else
	{
		  return(0);
	}
	return(1);
}


int save_scr_dump()
{
	int  handle2;
    int size_written;

    handle2 = open( "scr.dmp",O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
      size_written = write( handle2, bank2,
			    0x4000 );
		close( handle2 );
      if( size_written != 0x4000 ) 
		  return(0);
	}
	else
	{
		  return(0);
	}
	return(1);
}

void clearmem()
{
	int y;

	//Clear Memory to FF's - important!!
	for(unsigned int f=0;f<LYNX_MAXMEM;f++)
	{
		bank1[f]=bank2[f]=bank3[f]=bank4[f]=0xff;


//CPM HACK

//		bank2[f]=0x00;
	}
}



extern  int _stdcall  poke_mem(unsigned int loc,unsigned int val,unsigned int bno)
{
//	Z80_WRMEM(loc,val);
	loc=loc&0x0000ffff;

	if(bno==0)
		bank0[loc]=val;
	else if(bno==1)
		bank1[loc]=val;
	else if(bno==2)
		bank2[loc]=val;
	else if(bno==3)
		bank3[loc]=val;
	else if(bno==4)
		bank4[loc]=val;

	return(0);
}



extern  int _stdcall  peek_mem(dword loc)
{
	return(Z80_RDMEM(loc));
}



extern  int _stdcall get_memmap(unsigned char vbmap[],unsigned char bankno)
{
	int f;
	for(f=0;f<65536;f++)
	{
		if(bankno==0)
			vbmap[f]=bank0[f];
		else if(bankno==1)
			vbmap[f]=bank1[f];
		else if(bankno==2)
			vbmap[f]=bank2[f];
		else if(bankno==3)
			vbmap[f]=bank3[f];
		else if(bankno==4)
			vbmap[f]=bank4[f];
	}
	return(1);
}

extern  int _stdcall get_memscan(unsigned char mscan[])
{
	unsigned int f;
	memscan_start=memscan_start%65536;

	for(f=0;f<256;f++)
	{
		if(memscan_bno==0)
			mscan[f]=bank0[memscan_start+f];
		else if(memscan_bno==1)
			mscan[f]=bank1[memscan_start+f];
		else if(memscan_bno==2)
			mscan[f]=bank2[memscan_start+f];
		else if(memscan_bno==3)
			mscan[f]=bank3[memscan_start+f];
		else if(memscan_bno==4)
			mscan[f]=bank4[memscan_start+f];
	}
	return(1);
}

extern  int _stdcall set_memscan(dword start,dword bannkno)
{
	memscan_bno=bannkno;
	memscan_start=start;
	return(1);
}
