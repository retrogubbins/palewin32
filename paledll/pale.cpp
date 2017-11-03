// ===========================================================================
// ===========================================================================
//						PALE  Petes Amazing Lynx Emulator
//						PALE  Petes Amazing Lynx Emulator
//						PALE  Petes Amazing Lynx Emulator
//						PALE  Petes Amazing Lynx Emulator
//
//						Written by Pete Todd
//						For some reason in 2001 - 2006
//
//
//						Acknowledgments to Marcel de Kogel (z80 core)
//
// ===========================================================================
// ===========================================================================

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "z80.h"
#include "windows.h"
#include <math.h>
#include <io.h>
#include <time.h>
#include <direct.h>
#include <stdlib.h>
#include "libdsk.h"
#include "Z80Dasm.h"

#include "palesound.h"
#include "Paledisk.h"
#include "PaleIO.h"
#include "PaleUTILS.h"
#include "PaleMEM.h"
#include "Pale.h"
#include "PaleVID.h"
#include "PalePRINTER.h"
#include "PaleTAPS.h"
#include "PaleROM.h"

//#define LYNX_SMALL 0
//#define LYNX_BIG 1

static float dll_vers=6.12;


 char lbl_trap[100];



boolean cursor_on=FALSE;
int machine_type=LYNX_128;
int hw_type=LYNX_HARDWARE_128;
 int romrev=0;
// int screen_type=LYNX_BIG;
 unsigned char c_mode=0;
 int verbo=0; //flag for messages

 int kbd_type=0; //0=english/us keyboard  1=french keyboard

unsigned int cpm_fix=20;//noof EI requests to ignore



 int cycl_last;
 int q=0;

 int emu_speed=100;

 int curr_maxmem=0;
 int lynx_rom_loaded=0;
 char toggle=0;


//void save_lynx_tap();
//int load_lynx_sounds();
//void create_dummy_disk();



BOOL APIENTRY DllMain( HANDLE hModule, 
                       DWORD  ul_reason_for_call, 
                       LPVOID lpReserved
					 )
{
    return TRUE;
}



extern  int  _stdcall  get_version(unsigned char emu_query[])
{
	//Query the DLL Version
	sprintf((char*)emu_query,"DLL Version: %.2f",dll_vers);
	return(0);
}

extern  int  _stdcall  run_emulator();



// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  
// INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  INIT EMULATOR ***  



extern  int  _stdcall start_peripherals()
{
	reset_printer();
	init_diskstuff();
	init_tapestuff();
	return(0);
}

extern  int  _stdcall  init_emulator(int mc_type,int hard_type) //unsigned char mc_type)
{
	int ret;
	unsigned int f;
	char lbl1[6],lbl2[6],lbl[100];

	verbo=0;
	machine_type=mc_type;
	hw_type=hard_type;

	clearmem();
	clearports();
	clearcrtc();

	//Load the Lynx Rom - only does this once - copies it from array thereafter
	ret=load_lynx_rom();
 
	

	//Patch up some IO routines - SAVE/LOAD, Sound etc.
if(hw_type!=LYNX_HARDWARE_HACKSPECCY) //if(speccy==0)
		patch_lynx_rom();

	
	//This MUST be after the ROM load so that the initial ROM values are saved when switching between Tape operation types 
	//nope, this doesnt work here :(
	//set_t_mode(tape_mode);

	// initialise the Z80_IPeriod and Z80_IRQ variables,
	set_IPeriod(40000);
	set_ICount(40000);


	Z80_Reset();
	
	file_id=0;
	level9=0;//used as kludge for lev9
	lbl_trap[0]=0;

	

	return(ret);
}





extern  int  _stdcall  run_emulator()
{
	unsigned int ret;

	static	unsigned int new_keyval,looper=0;

	if(looper++>100)
	{
		looper=0;
		if(emu_speed >100)	//stop keyrepeat for faster emus
		{
				//48/96K deflaults
//				bank1[0x6233]=0x00;
//				bank1[0x6234]=0x08;	//H0800 delay bef repeat  128 is 0c00 for both
//				bank1[0x6237]=0x00;
//				bank1[0x6238]=0x08;	//H0800 delay between repeats

				if(hw_type==LYNX_HARDWARE_48 || hw_type==LYNX_HARDWARE_96)
//				if(machine_type<2)
				{
//					new_keyval=0x0800*(float)((float)emu_speed/100.0);
					new_keyval=0x0800*(float)((float)emu_speed/100.0);
					bank1[0x6233]=new_keyval % 256;
					bank1[0x6234]=new_keyval / 256;
//					bank1[0x6237]=new_keyval % 256;
//					bank1[0x6238]=new_keyval / 256;
				}


	//THIS TEST IS NEEDED TO PREVENT WRITES WHEN IN CPM MODE
	//THIS TEST IS NEEDED TO PREVENT WRITES WHEN IN CPM MODE
	//THIS TEST IS NEEDED TO PREVENT WRITES WHEN IN CPM MODE
	//THIS TEST IS NEEDED TO PREVENT WRITES WHEN IN CPM MODE

				else if(hw_type==LYNX_HARDWARE_128 && bank2[0]!=0)
				{
					new_keyval=0x0c00*(float)((float)emu_speed/100.0);
					bank1[0x6233]=new_keyval % 256;
					bank1[0x6234]=new_keyval / 256;
//					bank1[0x6237]=new_keyval % 256;
//					bank1[0x6238]=new_keyval / 256;
				}
		}		
	}

	ret=Z80_Execute();

	return(ret);
}


void reset_puter()
{
	//this is called from the Z80 when it traps the 0 address ie   CALL0 
	reset_disk_stuff();  //if used
}



extern  int  _stdcall  reset_emulator()
{
	int ret;
	char lbl1[200];
	clearmem();
	clearports();
	clearcrtc();

//	ret=load_lynx_rom();
//	patch_lynx_rom();
	Z80_Reset();
	return(ret);
}



extern  int  _stdcall  kill_emulator()
{
	int ret;
	char lbl1[200];
	kill_sound();

	kill_disk(0);
	kill_disk(1);
	
	//VERY BIG BODGE - to get round crash with soundserver
	exit(-1);	

	return(1);
}




extern  int  _stdcall  query_emulator(unsigned char emu_query[],unsigned char emu_query2[],unsigned char emu_query3[],unsigned char emu_query4[])
{
	int ret,f,g;

	Z80_RegisterDump_String (emu_query,emu_query2);

	//Query the port activity
	sprintf((char*)emu_query3,"%02x,%02x %s",
		video_latch,bank_latch,
		lbl_trap);

	if(lbl_trap[0]!=0)
	{
		sprintf((char*)emu_query4,"%s \x0d\x0a ",
				lbl_trap);
		lbl_trap[0]=0;	//clear the trap
	}
	else
		emu_query4[0]=0;

	return(0);
}





extern  int _stdcall  set_speed(dword speedunits,dword speedperc)
{
	char lbl[200];
	int req_cyc;
	static int fred=4000000;//MHz
	
	emu_speed=speedunits;

	if(hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
		fred=600*emu_speed;//*2;
	else
		fred=400*emu_speed;//*2;
	req_cyc=fred;//(x/1000);  //  1/10th of sec update period also set in VB
	if(vid_mode==1)
		req_cyc=req_cyc/252;

	set_IPeriod(req_cyc);
	
	return(0);
}


extern int _stdcall  set_autospeed(byte  frf)
{
//	auto_speed=frf;
	return(0);
}


extern  int _stdcall  set_soundstream(byte  frf)
{
//	MessageBox(NULL,"HELLEO","PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
//return(0);
	if(frf==1)
	{
		//	enable_soundstream=frf;
		init_sound();
		//sound_running=1;
	}
	else
		kill_sound();
	return(0);
}



extern  int _stdcall emu_checktim(unsigned int vb_timer_interval)
{
		return(0);
}



extern  int _stdcall screen_mode(dword mode)
{
//	screen_type=mode;
	return(1);
}



//extern  int _stdcall get_memmap(unsigned char vbmap[],unsigned char bankno)


//Z80_Dasm (filebuf+pc,buf,pc+offset);



//endef



extern  int  _stdcall  get_sysvar(unsigned char emu_query[],unsigned char emu_query2[])
{
	char lbl[100];
	//Query the System variables
	sprintf((char*)emu_query," STACK\t%4X\x005",bank1[0x61ee]+256*bank1[0x61ef]);
	sprintf(lbl," TOV\t%4X\x005",bank1[0x621f]+256*bank1[0x6220]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," EOB\t%4X\x005",bank1[0x61fc]+256*bank1[0x61fd]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," CURRLP\t%4X\x005",bank1[0x61f6]+256*bank1[0x61f7]);
	strcat((char*)emu_query,lbl);
	sprintf(lbl," CONTLP\t%4X\x005",bank1[0x6209]+256*bank1[0x620a]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," SOB\t%4X\x005",bank1[0x61fa]+256*bank1[0x61fb]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," DATAP\t%4X\x005",bank1[0x61f8]+256*bank1[0x61f9]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," STBL\t%4X\x005",bank1[0x6213]+256*bank1[0x6214]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," ATBL\t%4X\x005",bank1[0x6211]+256*bank1[0x6212]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," RSP\t%4X\x005",bank1[0x620d]+256*bank1[0x620e]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," RSTACK\t%4X\x005",bank1[0x620b]+256*bank1[0x620c]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," POLBUF\t%4X\x005",bank1[0x61fe]+256*bank1[0x61ff]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," VTBL\t%4X\x005",bank1[0x620f]+256*bank1[0x6210]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," PRINTD\t%4X\x005",bank1[0x6200]+256*bank1[0x6201]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," LPRINTD\t%4X\x005",bank1[0x6202]+256*bank1[0x6203]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," KEYB\t%4X\x005",bank1[0x6204]+256*bank1[0x6205]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," OTYPE\t%4X\x005",bank1[0x6206]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," LASTDSP\t%4X\x005",bank1[0x6207]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," VTYPE\t%4X\x005",bank1[0x6208]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," FTBL\t%4X\x005",bank1[0x6215]+256*bank1[0x6216]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," IEXT\t%4X\x005",bank1[0x6222]+256*bank1[0x6222]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," EEXT\t%4X\x005",bank1[0x6225]+256*bank1[0x6226]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," INPLSUB\t%4X\x005",bank1[0x6227]+256*bank1[0x6228]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," EXECSUB\t%4X\x005",bank1[0x622B]+256*bank1[0x622C]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," ZFLAG\t%4X\x005",bank1[0x6220]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," AUTOFL\t%4X\x005",bank1[0x622e]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," CRST\t%4X\x005",bank1[0x622f]+256*bank1[0x6230]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," LASTK\t%4X\x005",bank1[0x6235]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," STATUS\t%4X\x005",bank1[0x6236]); 
	strcat((char*)emu_query,lbl);

	sprintf(lbl," KDEL\t%4X\x005",bank1[0x6233]+256*bank1[0x6234]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," KREP\t%4X\x005",bank1[0x6237]+256*bank1[0x6238]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," FTBL\t%4X\x005",bank1[0x6215]+256*bank1[0x6216]); 
	strcat((char*)emu_query,lbl);
	sprintf(lbl," TTBL\t%4X\x005",bank1[0x6217]+256*bank1[0x6218]); 
	strcat((char*)emu_query,lbl);

	sprintf(lbl," EmuSpeed\t%d\x005",emu_speed); 
	strcat((char*)emu_query,lbl);

	sprintf(lbl," IPeriod\t%d\x005",get_IPeriod()); 
	strcat((char*)emu_query,lbl);



	sprintf((char*)emu_query2," XTTBL\t%4X\x005",bank1[0x6219]+256*bank1[0x621a]); 
	sprintf(lbl," XITBL\t%4X\x005",bank1[0x621b]+256*bank1[0x621c]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," XETBL\t%4X\x005",bank1[0x621d]+256*bank1[0x621e]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," PROTST\t%4X\x005",bank1[0x626b]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," OUTB\t%4X\x005",bank1[0x626d]+256*bank1[0x626e]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," CHRTBL\t%4X\x005",bank1[0x626f]+256*bank1[0x6270]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," CPHTBL\t%4X\x005",bank1[0x6271]+256*bank1[0x6272]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," BPERL\t%4X\x005",bank1[0x6273]+256*bank1[0x6274]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," MASK\t%4X\x005",bank1[0x6275]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," BLUBANK\t%4X\x005",bank1[0x628e]+256*bank1[0x628f]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," REDBANK\t%4X\x005",bank1[0x6290]+256*bank1[0x6291]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," GRNBANK\t%4X\x005",bank1[0x6292]+256*bank1[0x6293]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," DBASLM\t%4X\x005",bank1[0x6282]+256*bank1[0x6283]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," VIDEO\t%4X\x005",bank1[0x6288]+256*bank1[0x6289]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," EDST\t%4X\x005",bank1[0x62f1]+256*bank1[0x62f2]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," \x005"); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," Lynx 128 VARS\x005"); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," ----------------\x005"); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," 61BA Byte\t%4X\x005",bank1[0x61ba]+256*bank1[0x61bb]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," MOOST\t%4X\x005",bank1[0x61e1]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," BSTO\t%4X\x005",bank1[0x6952]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," DDT\t%4X\x005",bank1[0x6953]+256*bank1[0x6954]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," CHRSET\t%4X\x005",bank1[0x6957]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," AUXCHR\t%4X\x005",bank1[0x6958]+256*bank1[0x6959]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," FNTRAM\t%4X\x005",bank1[0x695b]+256*bank1[0x695c]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," TRPRAM\t%4X\x005",bank1[0x695e]+256*bank1[0x695f]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," WRPRAM\t%4X\x005",bank1[0x6964]+256*bank1[0x6965]); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," AGREEN\t%4X\x005",bank1[0x61df]+256*bank1[0x61e0]); 
	strcat((char*)emu_query2,lbl);

//emu_speed_per=194;


//	sprintf(lbl," EmuSpeedPerc\t%d\x005",emu_speed_per); 
//	strcat((char*)emu_query2,lbl);
		
/*
	sprintf(lbl," \x005"); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," Disk VARS\x005"); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," -----------------\x005"); 
	strcat((char*)emu_query2,lbl);
	sprintf(lbl," Options\t%2X Side\t%2X\x005",disk_options,disk_side); 
	strcat((char*)emu_query2,lbl);
	
	sprintf(lbl," Control\t%2X Track\t%2X\x005",disk_comreg,disk_trackreg); 
	strcat((char*)emu_query2,lbl);
	
	sprintf(lbl," Sector\t%2X Data\t%2X\x005",disk_sectreg,disk_statusreg); 
	strcat((char*)emu_query2,lbl);
	
	sprintf(lbl," Status\t%2X\x005",disk_statusreg); 
	strcat((char*)emu_query2,lbl);
	//for(int y=0;y<4;y++)
	//{
	//	sprintf(lbl,"%2X\t",disk_1793[y]); 
	//	strcat((char*)emu_query2,lbl);
	//}
*/

	return(0);
}
	
	// YYYYeeeeeeeeeeeeeeeeehhhhaaaaaaaaaaaaaaaahhhhhhhhhhh!!!! !!!!   !!!!!  !  !!!






// !!!!


//int Z80_Dasm (unsigned char *buffer,char *dest,unsigned PC)

extern  int _stdcall set_c_mode (unsigned int modee)
{
	return(0);
}

extern  int _stdcall set_iper (unsigned int modee)
{
	set_IPeriod(modee);
	return(0);
}

extern  int _stdcall set_kbdtype (unsigned int modee)
{
	kbd_type=modee;
	return(0);
}

extern  int _stdcall set_vidmode (unsigned int modee)
{
	vid_mode=modee;
	return(0);
}

extern  int _stdcall set_sound_div_in (unsigned int modee)
{
	sound_div_in=modee;
	return(0);
}

extern  int _stdcall set_b3_video (unsigned int modee)
{
//	if (modee==1) start_ss_nmi=1;
//	if (modee==1) start_m1_irq=1;

	show_bank3_video=modee;

	return(0);
}

extern  int _stdcall set_cpmfix (unsigned int modee)
{
	cpm_fix=modee;
	return(0);
}



