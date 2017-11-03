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

#include "IOPort.h"

int printer_locked=0;


 byte printer_buffer[PRINTER_BUFLEN];
 int printer_tail=0;
 int printer_head=0;

 unsigned char printer_status;
 unsigned char printer_data;




unsigned int printer_current_oport=PORT_LPT1;
unsigned int printer_current_iport=PORT_LPT1+1;
unsigned int printer_current_cport=PORT_LPT1+2;


unsigned int printer_type=PRINTER_REAL;
 
void reset_printer()
{
	BOOL ret;

ret=StartUpIoPorts(0x379, 0,0);

	printer_status=3;//bit 2 is SEL bit 1 is PE  bit 0 is BUSY
	printer_data=0;
	printer_tail=0;
	printer_head=0;
	for(int f=0;f<PRINTER_BUFLEN;f++)
		printer_buffer[f]=0;

}

extern int _stdcall get_printer_data(unsigned char vb_prndat[])
{
	int	x=0;

	x=0;
//if(printer_locked==0)
//{
	while(printer_tail!=printer_head)
	{
		vb_prndat[x++]=printer_buffer[printer_tail];
		printer_tail=(printer_tail+1)%(PRINTER_BUFLEN);
	}
//}
	return(x);
}


extern int _stdcall set_printer_type(unsigned int typ)
{

	printer_type=typ;
	if(typ==2)
	{
		printer_current_oport=PORT_LPT1;
		printer_current_iport=PORT_LPT1+1;
		printer_current_cport=PORT_LPT1+2;
	}
	else if(typ==3)
	{
		printer_current_oport=PORT_LPT2;
		printer_current_iport=PORT_LPT2+1;
		printer_current_cport=PORT_LPT2+2;
	}
	return(0);
}



void init_the_printer(void)
{
	if(printer_type==2 || printer_type==3)
	{
		outportb(printer_current_cport,0x04);	//bit 2 is the /INIT for the printer
		Sleep(2);
		outportb(printer_current_cport,0x00);	//bit 2 is the /INIT for the printer
		Sleep(2);
	}
}

extern void _stdcall init_printer(void)
{
	init_the_printer();
}

