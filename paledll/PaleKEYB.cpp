

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


extern int kbd_type;


extern  int _stdcall  send_keymap(byte  *keymap)
{
	char lbl[100];
	unsigned int f,g,foundcode,ip_bit;
	unsigned char keycode;
	static dword k_codes[128][2]={
	0x480,3, //space - 32
	0,0,0,0,0,0,0,0,0,0,0,0,
	0,0,0,0,0,0,0,0,
	0,0, // +
	0,0, //  ,
	0,0,  // -
	0,0, //  .
	0,0, // /
	0x780,0, // 0 - 48
	0x80,0,0x280,0,0x180,0,0x180,1,0x380,0,
	//0,0,0x280,0,0x180,0,0x180,1,0x380,0,
	0x480,0,0x580,0,0x580,1,
	0x680,0, // 9
	0,0,0,0, // : and ;
	0,0,0,0, // =
	0,0,0,0, // unused
	0,0, 		// @
	0x280,5,// A - 65
	0x480,5,0x180,5,0x180,4,0x180,2,0x380,5,0x380,4,
	0x480,2,0x680,1,0x580,5,0x680,5,0x780,2,0x580,3,
	0x480,4,0x680,2,0x780,1,0x280,1,0x380,1,0x280,4,
	0x380,2,0x580,2,0x380,3,0x280,2,0x180,3,0x480,1,
	0x280,3  // Z - 90
	}; // ]


	for(f=8;f<255;f++)
	{
		ip_port=0;
		ip_bit=0;
		keycode=f;
		if(keycode==8)//backspc
		{
			ip_port=0x980;
			ip_bit=0;
		}
		else if(keycode==13)//return
		{
			ip_port=0x980;
			ip_bit=3;
		}
		else if(keycode==16)// shift 
		{
			ip_port=0x80;
			ip_bit=7;
		}
		else if(keycode==17)// ctrl 
		{
			ip_port=0x280;
			ip_bit=6;
		}
		else if(keycode==20)     //  shift lock
		{
			ip_port=0x80;
			ip_bit=3;
		}
		else if(keycode==27)//ESCAPE
		{
			ip_port=0x80;
			ip_bit=6;
		}
		else if(keycode==37)     //   left arrow
		{
			ip_port=0x980;
			ip_bit=2;
		}
		else if(keycode==38)     //   up arrow
		{
			ip_port=0x80;
			ip_bit=4;
		}
		else if(keycode==39)     //   right arrow
		{
			ip_port=0x980;
			ip_bit=5;//239;
		}
		else if(keycode==40)     //   down arrow
		{
			ip_port=0x80;
			ip_bit=5;
		}
		else if(keycode==186)     //  ;
		{
			ip_port=0x780;
			ip_bit=5;
		}
		else if(keycode==187)     //  = key on pc, becomes @ key on lynx
		{
			ip_port=0x880;
			ip_bit=1;
		}
		else if(keycode==188)     //  , key comma
		{
			ip_port=0x680;
			ip_bit=3;
		}
		else if(kbd_type==0 && keycode==189)     //   -
		{
			ip_port=0x880;
			ip_bit=0;
		}
		else if(keycode==190)     //  .
		{
			ip_port=0x780;
			ip_bit=3;
		}
		else if(keycode==191)     //  / 
		{
			ip_port=0x880;
			ip_bit=3;
		}
		else if(keycode==192)     //  (# for eng keyb, ' for mine (US)) will become : on lynx 
		{
			ip_port=0x880;	//but no ? for some odd one its the other sing quot!!!
			ip_bit=5;
		}
		else if(keycode==219)     //  [
		{
			ip_port=0x880;
			ip_bit=2;
		}
		else if(keycode==221)     //  ]
		{
			ip_port=0x980;
			ip_bit=1;
		}
		else if(kbd_type==1 && keycode==222)     //  # key (for french keyboard users to get - and = on lynx'
		{
			ip_port=0x880;
			ip_bit=0;
		}
		//for rest from SPACE to Z
		else if(keycode>31 && keycode<91)
		{
			ip_port=k_codes[keycode-32][0];
			ip_bit=k_codes[keycode-32][1];
			//sprintf(lbl,"ipport is %04x, ipbyt is %d",ip_port,ip_byt);
			//	MessageBox(NULL,lbl,"PALE Debug",MB_YESNOCANCEL | MB_DEFBUTTON2);
		}
		else if (keymap[112]>1)
			break_nmi=1;
		else
			break_nmi=0;

		if( ip_port!=0)
		{
			if(keymap[f]>1)//127)
			{
				bit(&z80ports_in[ip_port],ip_bit,0);
				bit(&z80ports_in[0x5000+ip_port],ip_bit,0);//so that invaders works
				//need to do these mirrors better
			}
			else //if(keymap[f]==0)//keymap could be 1 toggled
			{
				bit(&z80ports_in[ip_port],ip_bit,1);
				bit(&z80ports_in[0x5000+ip_port],ip_bit,1);
			}
		}
	}
	return(0);
}
