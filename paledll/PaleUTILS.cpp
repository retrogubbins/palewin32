
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

extern  int _stdcall disassemble (char *destin,unsigned int jogval,int bank)
{
	int g,retr,f,start,mid,end,linecount;
	unsigned int curp,peecee;
	char lbl[200];
	char dis_buf[4000];
	char return_char[4];


	//Poss might have to increase this
	// to avoid routine below scanning backwards into other vars space
	peecee=get_pc();
	curp=peecee-32+jogval;
	
	//skip forward to the relevant byte
	sprintf(return_char,"\x0d\x0a");
	sprintf(dis_buf,"\x00");
	mid=0;
	for (f=0;f<64;f++)
	{
		if(curp==peecee)
		{
			mid=strlen(dis_buf);//sprintf(lbl,"_");
			//strcat(dis_buf,lbl);
		}
		sprintf(lbl,"%4X\t",curp);
		strcat(dis_buf,lbl);
//		retr=Z80_Dasm((unsigned char *)bank0+curp,lbl,curp);
		if(bank==0)
				retr=Z80_Dasm((unsigned char *)bank0+curp,lbl,curp);
		else if(bank==1)
				retr=Z80_Dasm((unsigned char *)bank1+curp,lbl,curp);
		else if(bank==2)
				retr=Z80_Dasm((unsigned char *)bank2+curp,lbl,curp);
		else if(bank==3)
				retr=Z80_Dasm((unsigned char *)bank3+curp,lbl,curp);
		else if(bank==4)
				retr=Z80_Dasm((unsigned char *)bank4+curp,lbl,curp);
		//		retr=Z80_Dasm((unsigned char *)bank0+curp,lbl,curp);
//		retr=Z80_Dasm((unsigned char *)bank0+curp,lbl,curp);
		if (strlen(lbl)==0) return(0);
		strcat(dis_buf,lbl);
		strcat(dis_buf,return_char);
		curp+=retr;	//advance to the next opcode
	}
	end=strlen(dis_buf);
	if (mid!=0)
	{
		//okay, we've got a listing, now search thru
		//to fnd the PC line, and then take the 14 lines either side of it
		//and copy them to the output buffer
		start=0;
		f=0;	
		//Skip to PC line
//		while(dis_buf[f++]!='_')
//		{
//			if(f>end)return(0);
//		};
		//Now go back 6 lines
		f=mid;
		for(g=0;g<5;g++)
		{
			while(dis_buf[f--]!='\x0a')
			{
				if(f<=0)return(0);
			}
		}
		start=f;
		for(f=start;f<end;f++)
			destin[f-start]=dis_buf[f];
	}
		else return(0);
	return(1);
}



void sleep( clock_t wait )
{
   clock_t goal;
   goal = wait + clock();
   while( goal > clock() )
      ;
}




void bit(unsigned char *vari,unsigned char posit,unsigned char valu)
{
        if (valu==0)
                *vari=(*vari & (255-((unsigned char)1 << posit)));
        else
                *vari=(*vari | ((unsigned char)1 << posit));
}
