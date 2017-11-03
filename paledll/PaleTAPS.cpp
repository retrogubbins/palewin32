
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
#include <malloc.h>

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


 unsigned char lbuffer[LYNX_MAXMEM];//leave room for 'big' prog
 int level9; //kludge
 int file_id; //type offile loaded
int breakin=0;	//stops program after loading
unsigned char taprom[30];


#define	 BASE_SAMPLE_RATE 22050

#define  TAPE_CYCS_RECORD_4896 128
#define  TAPE_CYCS_PLAY_4896 36
//#define  TAPE_CYCS_RECORD_128 40
#define  TAPE_CYCS_RECORD_128 158
#define  TAPE_CYCS_PLAY_128 114
//#define  TAPE_CYCS_PLAY_128 200

#define FORCE_OFF 0
#define FORCE_STOP 1
#define FORCE_PLAY 2
#define FORCE_RECORD 3

#define		BASE_RAW_BUFLEN 64  // 64MB

unsigned int tape_spd=TAPE_CYCS_PLAY_4896;
int tape_spd_adjust=0;

int tape_override=FORCE_OFF;


//unsigned char raw_tape[LYNX_MAX_RAW];

unsigned int raw_buflen;//set by init
unsigned char *raw_tape;

unsigned int raw_position=0;
unsigned int raw_play=0;
unsigned int raw_rec=0;
unsigned int raw_samples=0;
unsigned int raw_motor=0;
unsigned int tape_mode=TAP_TAPES;
unsigned char tape_level=0;
unsigned int tapecyc_last=0;
unsigned int tapewid;
unsigned int tapewid_last=0;
unsigned int tot_tape_cycles=0;
unsigned int raw_sample_rate=BASE_SAMPLE_RATE;

unsigned char raw_threshold=0x70;//70 is good for Colossal ADvent 80 for Zen (tape 3)

unsigned char tape_inverted=0;

unsigned char tape_operation=TAPE_STOPPED;

void save_lynx_tap()
{
	unsigned int  buf_p=0,quot=0,size_read,load_address;
	unsigned char buffer[65536];//leave room for 'big' proggy ;)
	char lbl[100],plab[100],pnam[100];
	unsigned char csum;
	unsigned int cdd,f,ret,e1,e2,e3;
	unsigned int tap_leng,exec_address, buf_pale,end_address,start_address,prog_size;


	int  handle2,end_nam;
    int size_written;
	//jump here from ROM save routine
	//get filename and any parameters
	//save header
	//save program between bounds
	//for(f=0;f<10;f++)
	//{
	//	plab[f]=pale_mem[e1+f];		
	//}
	//plab[10]='/0';
	e1=get_de();
	quot=0;buf_p=0;
	//Get filename - skip to second "
	while (quot<2)
	{
		plab[buf_p]=bank1[e1+buf_p];
		if(bank1[e1+buf_p++]=='"')
			quot++;
	}
	plab[buf_p-1]='\0';
	plab[0]=' ';		//wipe out first " ready for save

	e2=strlen(plab);
	for(f=0;f<e2;f++)
		pnam[f]=plab[f+1];

	strcat(pnam,".TAP");	
	//sprintf(lbl,"DE points to %s, pnam is %s",plab,pnam);
	//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);

    /* open a file for output		  */
    handle2 = open( pnam,O_RDWR | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
		//write header - the filename
		buffer[0]='"';
		for(f=1;f<e2;f++)
		{
				buffer[f]=plab[f];		
		}
		end_nam=f;
		buffer[end_nam]='"';
		buffer[end_nam+1]=0x42;	//BASIC proggy designator
		start_address=bank1[0x61fa]+256*bank1[0x61fb];//should be 694D
		end_address=bank1[0x61fc]+256*bank1[0x61fd];
		//write tape length (end of program pointer-load address)
		tap_leng=end_address-start_address+1;
		buffer[end_nam+2]=tap_leng % 256;
		buffer[end_nam+3]=tap_leng / 256;
		//write Prog
		csum=0;
		for(f=0;f<tap_leng;f++)
		{
			buffer[end_nam+4+f]=bank1[start_address+f];
		}
		//write Execution Addr
		//		exec_address=buffer[buf_p]+256*buffer[buf_p+1];
		e2=get_ix();

	//	sprintf(lbl,"Hello Pete,IX is %4X",e2);
	//	MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
				e1=bank1[0x61fc]+256*bank1[0x61fd];

				
//WHY OH WHY DONT ASK ME WHY BUT THE LYNX
//LIKES TO HAVE 1600 bytes added to this address !
				
//e3=1600+((0x10000+e2)-e1)%0xffff;		// rom does IX-(61fc/d)
//				buffer[end_nam+4+f]=e3 % 256;
//				buffer[end_nam+4+f+1]=e3 / 256;//these seem to retrurn control okay - should be IX ? based though
//				buffer[end_nam+4+f+2]=e3 / 256;

		buffer[end_nam+4+f]=0;		//exec addr
		buffer[end_nam+4+f+1]=0;
		buffer[end_nam+4+f+2]=0;	//copy byte

		
		
		prog_size=tap_leng+end_nam+4+3+1;	
		// OKAY, actually write the file to disk
		size_written = write( handle2, buffer,prog_size );
		//sprintf(lbl,"Hello Pete,I Wrote %d bytes",size_written);
		//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
		close( handle2 );
	}
	//return to ROM
	set_pc(0xc59);  //  do a ret jump back into the ROM 
}

 
extern  int _stdcall load_lynx_tap(unsigned char fn[],unsigned char fn2[], unsigned char tape_type)
{
	int  lhandle,lhandle2;
	unsigned int  buf_p=0,quot=0,size_read,load_address;
	char lbl[100];
	unsigned char csum;
	unsigned int cdd,f,ret;
	unsigned int tap_leng,exec_address, buf_pale;
	char csum_ok[10];
	
	//sprintf(lbl,"nam is %s,  nam2 is %s",fn,fn2);
	//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
	// open a file for input		  
	lhandle = open( (char*)fn, O_RDONLY | O_BINARY );
	if( lhandle != -1 )
	{
	  size_read = read( lhandle, lbuffer,
			sizeof( lbuffer ) );
	  close( lhandle );
	  if( size_read == -1 )
				return(0);
	}
	else
	{
		return(0);
	}

	if(tape_type==0) //standard tape with name
	{
		//Get filename - skip to second "
		while (quot<2)
		{
			if(lbuffer[buf_p++]=='"')
				quot++;
		}
		lbuffer[buf_p-1]='\0';
		lbuffer[0]=' ';		//wipe out first " ready for printing
	}

	//If next char is A5 we forgot to remove it from the TAP file !
	//we could have either 4d 'M' mc or 42 'B' basic, *** or 41 - 'A' level 9 data ***
	//If next char is 42 only then we have a basic proggy
	if(lbuffer[buf_p]==0xa5)
	{




//		MessageBox(NULL,"A5 Byte Found in Header : This is non standard and should be rmeoved.","PALE Debug",MB_ICONINFORMATION);

		
		buf_p++;
		file_id=lbuffer[buf_p];
		buf_p++;
	}
	else
	{
		file_id=lbuffer[buf_p];
		buf_p++; //skip over the 42 ( or 4D) B or M (when no a5 there - everyone but me !)
	}

	//Get Length
	if(file_id==TAP_BASIC)
	{
		load_address=bank1[0x61fa]+256*bank1[0x61fb];//should be 694D
		tap_leng=lbuffer[buf_p]+256*lbuffer[buf_p+1];
		buf_p+=2;
	}
	else if(file_id==TAP_BINARY)
	{
		tap_leng=lbuffer[buf_p]+256*lbuffer[buf_p+1];
		load_address=lbuffer[buf_p+2]+256*lbuffer[buf_p+3];
		buf_p+=4;
	}else //DATA - swap dest and length
	{
		load_address=lbuffer[buf_p]+256*lbuffer[buf_p+1];
		tap_leng=lbuffer[buf_p+2]+256*lbuffer[buf_p+3];
		buf_p+=4;
	}

	buf_pale=load_address;
	//Get Prog
	csum=0;
	for(f=0;f<tap_leng;f++)
	{
		csum+=lbuffer[buf_p];//only used for binary MLOADed progs & Level 9 Data
		bank1[buf_pale++]=lbuffer[buf_p++];
	}

	//dec ptr to point to last byte of prog in memory
	buf_pale--;

	if(file_id==TAP_BASIC)
	{
//MessageBox(NULL,"Updating 61fc","PALE Debug",MB_ICONINFORMATION);

		//Update end of program pointer in the BASIC os 
		bank1[0x61fc]=buf_pale % 256;
		bank1[0x61fd]=buf_pale / 256;
	}

	sprintf(csum_ok,"No Checksum");
	//skip over next two bytes if binary file - csum related
	if(file_id==TAP_BINARY || file_id==TAP_DATA)
	{
		sprintf(csum_ok,"Checksum OK");
		if(csum!=lbuffer[buf_p++])
		{
			//MessageBox(NULL,"Bad Checksum Possibly for this File?","PALE Debug",MB_ICONINFORMATION);
			sprintf(csum_ok,"Checksum BAD");
		}
		if(lbuffer[buf_p++]==0x4e)
			MessageBox(NULL,"Got a funny N byte thing after the checksum!","PALE Debug",MB_ICONINFORMATION);
	}
	
	//Get Execution Addr
	if(file_id==TAP_BASIC || file_id==TAP_BINARY)
		exec_address=lbuffer[buf_p]+256*lbuffer[buf_p+1];
	else
		exec_address=0;

	if(file_id==TAP_BASIC || file_id==TAP_BINARY)
		sprintf((char*)fn2,"Name:%s \x0d\x0a ID:%02x \x0d\x0a Start %04x \x0d\x0a End %04x \x0d\x0a Length %04x \x0d\x0a Run %04x\x0d\x0a %s",lbuffer,file_id,load_address,buf_pale,tap_leng-1,exec_address,csum_ok);
	else  //Data
		sprintf((char*)fn2,"Name: n/a \x0d\x0a ID: %04x \x0d\x0a Start %04x \x0d\x0a End %04x \x0d\x0a Length %04x \x0d\x0a Run %04x",file_id,load_address,buf_pale,tap_leng-1);


	if(breakin==1)
	{
		set_hl(buf_pale);
		set_de(0);
		set_pc(0xcfb);  //jump back into the ROM load routine - this one to the prompt (but MEM not set correctly)
	}


	if(exec_address!=0 && file_id!=TAP_DATA)
	{
		if(file_id==TAP_BINARY)
		{
			set_hl(exec_address);//as the ROM does it
			set_pc(exec_address);  //jump to the invaders routine :))
		}
		else
		{
			set_hl(buf_pale);//end byte of program
			set_de(exec_address);
			set_pc(0xcc1);  //jump back into the ROM load routine
		}
	}
	else
	{
		set_hl(buf_pale);
		set_de(exec_address);
		set_pc(0xcfb);  //jump back into the ROM load routine - this one to the prompt (but MEM not set correctly)
	}

	return(1);
}

 

extern  int _stdcall load_lev9_tap(unsigned char fn[],unsigned char fn2[])
{
	int  handle,handle2;
	int file_id;
	unsigned int  buf_p=0,quot=0,size_read,load_address;
	unsigned char buffer[65536];//leave room for 'big' proggy ;)
	char lbl[100];
	unsigned char csum;
	unsigned int cdd,f,ret;
	unsigned int tap_leng,exec_address, buf_pale;

		
	//Remove .TAP
	f=0;
	while(fn[f]!='.')
		f++;
	fn[f]='\0';

	strcpy(lbl,(char*)fn);
	strcat(lbl,"3.tap");
	
	//LOAD RED BANK
	handle = open( lbl, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, buffer,
			sizeof( buffer ) );
	  close( handle );
	  if( size_read == -1 )
				return(0);
	}
	else
	{
		return(0);
	}

	buf_p=0;
	//If next char is A5 we forgot to remove it from the TAP file !
	//we could have either 4d 'M' mc or 42 'B' basic, *** or 41 - 'A' level 9 data ***
	//If next char is 42 only then we have a basic proggy
	if(buffer[buf_p]==0xa5)
	{
		buf_p++;
		file_id=buffer[buf_p];
		buf_p++;
	}
	else
	{
		file_id=buffer[buf_p];
		buf_p++; //skip over the 42 ( or 4D) B or M (when no a5 there - everyone but me !)
	}
	load_address=buffer[buf_p]+256*buffer[buf_p+1];
	tap_leng=buffer[buf_p+2]+256*buffer[buf_p+3];
	buf_p+=4;
	//Get DATA
	for(f=0;f<tap_leng;f++)
	{
		bank2[0xc000+f]=buffer[buf_p++];
	}
	strcpy(lbl,(char*)fn);
	strcat(lbl,"4.tap");
	//LOAD BLUE BANK
	handle = open( lbl, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, buffer,
			sizeof( buffer ) );
	  close( handle );
	  if( size_read == -1 )
				return(0);
	}
	else
	{
		return(0);
	}
	buf_p=0;
	if(buffer[buf_p]==0xa5)
	{
		buf_p++;
		file_id=buffer[buf_p];
		buf_p++;
	}
	else
	{
		file_id=buffer[buf_p];
		buf_p++; //skip over the 42 ( or 4D) B or M (when no a5 there - everyone but me !)
	}
	load_address=buffer[buf_p]+256*buffer[buf_p+1];
	tap_leng=buffer[buf_p+2]+256*buffer[buf_p+3];
	buf_p+=4;
	//Get DATA
	for(f=0;f<tap_leng;f++)
	{
		bank2[0xa000+f]=buffer[buf_p++];
	}
	strcpy(lbl,(char*)fn);
	strcat(lbl,"5.tap");
	//LOAD normal memory 7800 after advloader
	handle = open( lbl, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, buffer,
			sizeof( buffer ) );
	  close( handle );
	  if( size_read == -1 )
				return(0);
	}
	else
	{
		return(0);
	}
	buf_p=0;
	if(buffer[buf_p]==0xa5)
	{
		buf_p++;
		file_id=buffer[buf_p];
		buf_p++;
	}
	else
	{
		file_id=buffer[buf_p];
		buf_p++; //skip over the 42 ( or 4D) B or M (when no a5 there - everyone but me !)
	}
	load_address=buffer[buf_p]+256*buffer[buf_p+1];
	tap_leng=buffer[buf_p+2]+256*buffer[buf_p+3];
	buf_p+=4;
	//Get DATA
	for(f=0;f<tap_leng;f++)
	{
		bank1[load_address+f]=buffer[buf_p++];
	}
	set_pc(0x7056); //re-enter level 9 loader
	level9=1;//kludge
	return(1);
}

extern  int _stdcall z80_to_tap(unsigned char in_fnam[],unsigned char out_fnam[], dword Tleng,dword Tstart,dword prog_type,dword Texecute)
{
	int  handle,handle2,bufp;
	unsigned int  buf_p=0,quot=0,size_read,load_address;
	unsigned char buffer[65536];//leave room for 'big' proggy ;)
	unsigned char buffer_out[65536];//leave room for 'big' proggy ;)
	char lbl[100];
	unsigned char csum;
	unsigned int cdd,f,ret;
	unsigned int tap_leng,exec_address, buf_pale;
	char csum_ok[10];
    int size_written;

  // open a file for input		  
	handle = open( (char*)in_fnam, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, buffer,
			sizeof( buffer ) );
	  close( handle );
	  if( size_read == -1 )
				return(0);
	}
	else
	{
		return(0);
	}


    /* open a file for output		  */
    handle2 = open( (char*)out_fnam,O_RDWR | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
		bufp=0;
		//write header
		buffer_out[bufp++]='"';
		buffer_out[bufp++]='N';
		buffer_out[bufp++]='O';
		buffer_out[bufp++]='N';
		buffer_out[bufp++]='A';
		buffer_out[bufp++]='M';
		buffer_out[bufp++]='E';
		buffer_out[bufp++]='"';

		prog_type=1;
		
		if(prog_type==0)
		{
			buffer_out[bufp++]=TAP_BASIC;	//BASIC proggy designator
			//write tape length (end of program pointer-load address)
			buffer_out[bufp++]=Tleng % 256;
			buffer_out[bufp++]=Tleng / 256;
		}
		else if(prog_type==1)
		{
			buffer_out[bufp++]=TAP_BINARY;	//BINARY proggy designator
			//write tape length (end of program pointer-load address)
			buffer_out[bufp++]=size_read % 256;
			buffer_out[bufp++]=size_read / 256;
			//write tape start 
			buffer_out[bufp++]=Tstart % 256;
			buffer_out[bufp++]=Tstart / 256;
		}
		else if(prog_type==2)
			buffer_out[bufp++]=TAP_DATA;	//LEVEL9 data designator


		csum=0;
		for(f=0;f<size_read;f++)
		{
				csum+=buffer[f] % 256;
				buffer_out[bufp++]=buffer[f];		
		}
		if(prog_type==0)
		{
			buffer_out[bufp++]=0;
			buffer_out[bufp++]=0;
		}
		else if(prog_type==1)
		{
			//write checksum
			buffer_out[bufp++]=csum;
			buffer_out[bufp++]=csum;
			//write Execution Addr
			buffer_out[bufp++]=Texecute % 256;
			buffer_out[bufp++]=Texecute / 256;
			buffer_out[bufp++]=Texecute / 256;	//last byte is a copy
		}

		size_written = write( handle2, buffer_out,bufp );
		close( handle2 );
	}

	return(size_read);
}



extern  int _stdcall set_breakin (unsigned int modee)
{
	breakin=modee;
	return(0);
}


extern  int  _declspec(dllexport) load_raw(char fnam[])
{
	int ret,errorr,g,h;
	int  handle,handle2;
	int  size_read,size_written;
	int cdd,f;
	char lbl[200];

	handle=open( fnam, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  raw_samples = read( handle, raw_tape,raw_buflen);
	  close( handle );
	  if( raw_samples == -1 )
	  {
				ret=MessageBox(NULL,":( Couldn't Read the Input file","PALE Load RAW",MB_ICONERROR | MB_OK);
				return(1);
	  }
	}
	else
	{
		ret=MessageBox(NULL,":( Couldn't open the Input file","PALE Load RAW",MB_ICONERROR | MB_OK);
		return(1);
	}
	raw_position=0;

	if(raw_samples==raw_buflen)
		ret=MessageBox(NULL,"This RAW file is too big, try increasing the buffer size","PALE Load RAW",MB_ICONERROR | MB_OK);
	
	
	return(raw_samples);			
}



extern  int  _stdcall  save_raw(char fnam[])
{
	int  handle,handle2;
	int size_written,size_read,ret;
	
	/* open a file for output		  */
	handle2 = open( fnam,O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
	if( handle2 != -1 )
	{
		size_written = write( handle2, raw_tape,raw_position );
		close( handle2 );
	}
	else
	{
		ret=MessageBox(NULL,":( Couldn't open the Output file","PALE Save RAW",MB_ICONERROR | MB_OK);
		return(1);
	}
	raw_position=0;
	return(0);
}
/*
'-----------------------------------------------------------------------------------
' Wave File Format
'-----------------------------------------------------------------------------------
' RIFF Chunk   ( 12 bytes)
' 00 00 - 03  "RIFF"
' 04 04 - 07  Total Length to Follow  (Length of File - 8)
' 08 08 - 11  "WAVE"
'
' FORMAT Chunk ( 24 bytes )
' 0C 12 - 15  "fmt_"
' 10 16 - 19  Length of FORMAT Chunk  Always 0x10
' 14 20 - 21  Audio Format            Always 0x01
' 16 22 - 23  Channels                1 = Mono, 2 = Stereo
' 18 24 - 27  Sample Rate             In Hertz
' 1C 28 - 31  Bytes per Second        Sample Rate * Channels * Bits per Sample / 8
' 20 32 - 33  Bytes per Sample        Channels * Bits per Sample / 8
'                                       1 = 8 bit Mono
'                                       2 = 8 bit Stereo or 16 bit Mono
'                                       4 = 16 bit Stereo
' 22 34 - 35  Bits per Sample
'
' DATA Chunk
' 24 36 - 39  "data"
' 28 40 - 43  Length of Data          Samples * Channels * Bits per Sample / 8
' 2C 44 - End Data Samples
'              8 Bit = 0 to 255             unsigned bytes
'             16 Bit = -32,768 to 32,767    2's-complement signed integers
'-----------------------------------------------------------------------------------
*/

#define WAV_HEADER_LENGTH 44


extern  int  _stdcall  save_wav(char fnam[])
{
	unsigned int  handle,handle2;
	unsigned int leng,size_written,size_read,ret;
	char t_head[WAV_HEADER_LENGTH];
	
	//Build Header Info
	t_head[0]='R';t_head[1]='I';t_head[2]='F';t_head[3]='F';
	leng=WAV_HEADER_LENGTH+raw_position-8;
//	t_head[4]=leng>>(3*8);
//	t_head[5]=leng>>(2*8);
//	t_head[6]=leng>>8;
//	t_head[7]=leng;
	t_head[4]=leng;
	t_head[5]=leng>>8;
	t_head[6]=leng>>(2*8);
	t_head[7]=leng>>(3*8);

	t_head[8]='W';t_head[9]='A';t_head[10]='V';t_head[11]='E';
	t_head[12]='f';t_head[13]='m';t_head[14]='t';t_head[15]=' ';

	t_head[16]=0x10;//leng of format chunk always 0x10
	t_head[17]=0;
	t_head[18]=0;
	t_head[19]=0;
	
	t_head[20]=0x01;//channels
	t_head[21]=0;
	t_head[22]=0x01;//audio format always 0x01
	t_head[23]=0;


	t_head[24]=raw_sample_rate; //0x22;//22050 hertz
	t_head[25]=raw_sample_rate>>8; //0x56;
	t_head[26]=raw_sample_rate>>(2*8);
	t_head[27]=0;

	t_head[28]=raw_sample_rate; // 0x22;//bytes per sec
	t_head[29]=raw_sample_rate>>8; // 0x56;
	t_head[30]=raw_sample_rate>>(2*8);
	t_head[31]=0;

	t_head[32]=0x01;//bytes per sample
	t_head[33]=0;

	t_head[34]=0x08;//bits per sample
	t_head[35]=0;

	t_head[36]='d';t_head[37]='a';t_head[38]='t';t_head[39]='a';

	t_head[40]=raw_position;
	t_head[41]=raw_position>>8;
	t_head[42]=raw_position>>(2*8);
	t_head[43]=raw_position>>(3*8);

	/* open a file for output		  */
	handle2 = open( fnam,O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
	if( handle2 != -1 )
	{
		size_written = write( handle2, t_head,WAV_HEADER_LENGTH );
		size_written = write( handle2, raw_tape,raw_position );
		close( handle2 );
	}
	else
	{
		ret=MessageBox(NULL,":( Couldn't open the Output file","PALE Save RAW",MB_ICONERROR | MB_OK);
		return(1);
	}
	return(0);
}


extern  int  _stdcall  load_wav(char fnam[])
{
	unsigned int  handle,handle2,wav_length;
	unsigned int leng,size_written,size_read,ret;
	char lbl[200];

	handle=open( fnam, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, raw_tape,raw_buflen);
	  close( handle );
	  if( size_read == -1 )
	  {
				ret=MessageBox(NULL,":( Couldn't Read the Input file","PALE Load WAV",MB_ICONERROR | MB_OK);
				return(1);
	  }
	}
	else
	{
		ret=MessageBox(NULL,":( Couldn't open the Input file","PALE Load WAV",MB_ICONERROR | MB_OK);
		return(1);
	}

	raw_position=0;


	if(size_read==raw_buflen)
		ret=MessageBox(NULL,"This WAV file is too big, try increasing the buffer size","PALE Load WAV",MB_ICONERROR | MB_OK);

	//raw_tape[5]=0;
	//sprintf(lbl,"Header %s",raw_tape);
	//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
	
	if(raw_tape[0]!='R')
	{
		ret=MessageBox(NULL,"That's not a Standard RIFF format WAV File","PALE Load WAV",MB_ICONERROR | MB_OK);
		return(1);
	}
	//Build Header Info
	raw_samples=raw_tape[43]<<(3*8)+raw_tape[42]<<(2*8)+raw_tape[41]<<8+raw_tape[40];

//sprintf(lbl,"T43 = %x 42=%x  41=%x  ",raw_tape[43],raw_tape[42],raw_tape[41]);
//ret=MessageBox(NULL,lbl,"PALE Load WAV",MB_ICONERROR | MB_OK);

	if(raw_tape[20]!=0x01)
	{
		ret=MessageBox(NULL,"This looks like a Stereo File, I expected MONO","PALE Load WAV",MB_ICONERROR | MB_OK);
		return(1);
	}

	raw_sample_rate=(raw_tape[26]<<(2*8))+(raw_tape[25]<<8)+raw_tape[24];

//sprintf(lbl,"T26 = %x 25=%x  24=%x  ",raw_tape[26],raw_tape[25],raw_tape[24]);
//ret=MessageBox(NULL,lbl,"PALE Load WAV",MB_ICONERROR | MB_OK);

//sprintf(lbl,"IN DLL Sample Rate = %x",raw_sample_rate);
//ret=MessageBox(NULL,lbl,"PALE Load WAV",MB_ICONERROR | MB_OK);

	if(raw_tape[36]!='d')
	{
		ret=MessageBox(NULL,"Couldn't Find the 'data' segment","PALE Load WAV",MB_ICONERROR | MB_OK);
		return(1);
	}

	//now copy the data down into the first bit
	for(unsigned int f=0;f<raw_samples;f++)
		raw_tape[f]=raw_tape[f+44];



	return(raw_samples);
}







void stop_tape()
{
	tape_operation=TAPE_STOPPED;
	raw_motor=0;
}


void start_tape_play()
{
	tape_operation=TAPE_PLAY;
	if(hw_type==LYNX_HARDWARE_48 || hw_type==LYNX_HARDWARE_96)
		tape_spd=TAPE_CYCS_PLAY_4896/(raw_sample_rate/BASE_SAMPLE_RATE);
	else
		tape_spd=TAPE_CYCS_PLAY_128/(raw_sample_rate/BASE_SAMPLE_RATE);
	raw_motor=1;
}

void start_tape_record()
{
char lbl[200];

	tape_operation=TAPE_RECORD;
	if(hw_type==LYNX_HARDWARE_48 || hw_type==LYNX_HARDWARE_96)
		tape_spd=TAPE_CYCS_RECORD_4896/(raw_sample_rate/BASE_SAMPLE_RATE);
	else
		tape_spd=TAPE_CYCS_RECORD_128/(raw_sample_rate/BASE_SAMPLE_RATE);
//sprintf(lbl,"tape_spd is %u rawsamprate is %u",tape_spd,raw_sample_rate);
//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
	raw_motor=1;
}

extern  int  _stdcall  force_raw_play()
{
	tape_override=FORCE_PLAY;//force start

	return(0);
}

extern  int  _stdcall  force_raw_auto()
{
	tape_override=FORCE_OFF;
	return(0);
}

extern  int  _stdcall  force_raw_rec()
{

	tape_override=FORCE_RECORD;
	return(1);
}

extern  int  _stdcall  force_raw_stop()
{
	tape_override=FORCE_STOP;//force stop
	return(0);
}

extern  int  _stdcall  rewind_raw()
{
	raw_position=0;
	return(0);
}

extern  unsigned int  _stdcall  get_raw_position()
{
	return(raw_position);
}

extern  unsigned int  _stdcall  get_raw_samples()
{
	return(raw_samples);
}

extern  int  _stdcall  get_raw_motor()
{
	return(raw_motor);
}

extern  int  _stdcall  get_tape_level()
{
	return(tape_level);
}


void raw_clear()
{
	for(int f=0;f<raw_buflen;f++)
		raw_tape[f]=128;
	raw_position=0;
}

extern  int  _stdcall  tape_clear()
{
	raw_clear();
	return(0);
}

void update_tape()
{
	set_tapecyc(0);
	if (tape_mode==RAW_TAPES && tape_override!=FORCE_STOP)// && (raw_motor==1))	
	{	
		//TAPE OUTPUT
		//TAPE OUTPUT
		if(tape_operation==TAPE_RECORD  || tape_override==FORCE_RECORD)
		{
			//synthesise the output waveform from measuring the number of elapsed z80 cycles
			//since the last time this routine was called
			//Get the no of cycles that have passed
			if(hw_type==LYNX_HARDWARE_48 || hw_type==LYNX_HARDWARE_96)
			{
				//4896 uses software to synthesise a sin(ish) waveform
				raw_tape[raw_position]=128+((signed int)(port84-32)*4);
			}
			else if (hw_type==LYNX_HARDWARE_128 || LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
			{
				//128 uses values 19h and 27h 31d & 37d output to port 84 as straight two levels
				raw_tape[raw_position]=128+((signed int)(port84-32)*8);
			}
			else if(hw_type==LYNX_HARDWARE_HACKSPECCY)
				//speccy 
				raw_tape[raw_position]=speccy_port_out;
//				raw_tape[raw_position]=128+((signed int)((speccy_port_out & 0x10)-8));

			
			if(tape_inverted==1)
				raw_tape[raw_position]=255-raw_tape[raw_position];//Inverts Output Signal As well

			raw_position++;
			if (raw_position>=raw_buflen)
				raw_position=raw_buflen-1;
		}
		//TAPE INPUT
		else if(tape_operation==TAPE_PLAY || tape_override==FORCE_PLAY)
		{
				//tape_level=(unsigned char)((((signed int)raw_tape[raw_position]-(signed int)128)/(signed int)8)+1)&0x0f;
				if(tape_inverted==1)
					tape_level=(255-raw_tape[raw_position]);	//inverts input signal
				else
					tape_level=raw_tape[raw_position];
		
				raw_position++;
				if (raw_position>=raw_buflen)
					raw_position=raw_buflen-1;
	
				port84=tape_level;					//Copy the Tape Signal to the Sound Output

				if(hw_type==LYNX_HARDWARE_HACKSPECCY)
				{
					tape_spd_adjust=25;
					speccy_port_out=tape_level;
				}
		}
	}
}



int set_rawbuflen(unsigned int gt)
{

	char lbl[200];

	free(raw_tape);
	raw_tape=(unsigned char *)malloc(gt*1024000);

	if(raw_tape==NULL)
	{
		MessageBox(NULL,"Couldn't Allocate enough Memory for the TAPE buffer","PALE ",MB_OK );
		raw_tape=(unsigned char *)malloc(1000000);
		if(raw_tape==NULL)
		{
			MessageBox(NULL,"Couldn't Allocate enough Memory for ANY tape buffer :(","PALE ",MB_OK );
		}
		else
			raw_buflen=1000000;
	}
	raw_buflen=gt*1024000;

//	sprintf(lbl,"Allocated tape buffer - %x",raw_buflen);
//	MessageBox(NULL,lbl,"PALE ",MB_OK );

	return(0);
}

void set_t_mode(int ff)
{
	unsigned int sav_ad;

	tape_mode=ff;


	if (tape_mode==TAP_TAPES)	//TAP
	{
		set_rawbuflen(1);

		if (hw_type==LYNX_HARDWARE_48 || hw_type==LYNX_HARDWARE_96)
		{	
			//These are for the TAPE load/save routines
			taprom[0]=bank0[0xd67];
			bank0[0xd67]=0xed;	//change Tape Byte output, just return 0 in A ?
			taprom[1]=bank0[0xd68];
			bank0[0xd68]=0x00;
			taprom[2]=bank0[0xd69];
			bank0[0xd69]=0xc9;	

			taprom[3]=bank0[0xb65];
			bank0[0xb65]=0xc9;	//disabled completely - Read Tape Sync
			
		//	bank0[0xcd4]=0xed;	//change Read Bit, just return 1 in A
		//	bank0[0xcd5]=0x01;
		//	bank0[0xcd6]=0xc9;
			taprom[4]=bank0[0xcd4];
			bank0[0xcd4]=0xc3;	//change Read Bit, just return 1 in A
			taprom[5]=bank0[0xcd5];
			bank0[0xcd5]=0xd4;
			taprom[6]=bank0[0xcd6];
			bank0[0xcd6]=0x0c;

			taprom[7]=bank0[0xc95];
			bank0[0xc95]=0xc3;	//set up an infint loop to wait here whilst VB is loading the RAM
			taprom[8]=bank0[0xc96];
			bank0[0xc96]=0x95;
			taprom[9]=bank0[0xc97];
			bank0[0xc97]=0x0c;

			taprom[10]=bank0[0x3f62];
			bank0[0x3f62]=0xc3;	//and again for MLOAD
			taprom[11]=bank0[0x3f63];
			bank0[0x3f63]=0x62;
			taprom[12]=bank0[0x3f64];
			bank0[0x3f64]=0x3f;

			
			//Patch Save routine to output OUT 93,x trapped here as SAVE
			//jump back in at 0cfb

			sav_ad=0xbcb;
			taprom[13]=bank0[sav_ad+0];
			bank0[sav_ad+0]=0x20;
			taprom[14]=bank0[sav_ad+1];
			bank0[sav_ad+1]=0xf4;
			taprom[15]=bank0[sav_ad+2];
			bank0[sav_ad+2]=0x01;//ld BC,0093
			taprom[16]=bank0[sav_ad+3];
			bank0[sav_ad+3]=0x93;
			taprom[17]=bank0[sav_ad+4];
			bank0[sav_ad+4]=0x00;
			taprom[18]=bank0[sav_ad+5];
			bank0[sav_ad+5]=0xed;//out a (c)
			taprom[19]=bank0[sav_ad+6];
			bank0[sav_ad+6]=0x79;
			taprom[20]=bank0[sav_ad+7];
			bank0[sav_ad+7]=0x00;//never gets to these :)
			taprom[21]=bank0[sav_ad+8];
			bank0[sav_ad+8]=0x00;


			
			
			// Fake a SYNC marker of 0x0C to load Tapes with odd marker
//			bank0[0xb80]=0x0c;	// read marker
//			bank0[0xbad]=0x0c;  //write marker byte


		}
else if (hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
		{
			//LYNX 128 STUFF

			//These are for the TAPE load/save routines
			taprom[0]=bank0[0xd3d];
			bank0[0xd3d]=0xed;	//change Tape Byte output, just return 0 in A ?
			taprom[1]=bank0[0xd3e];
			bank0[0xd3e]=0x00;
			taprom[2]=bank0[0xd3f];
			bank0[0xd3f]=0xc9;	
			taprom[3]=bank0[0xb65];
			bank0[0xb65]=0xc9;	//disabled completely - Read Tape Sync

			taprom[4]=bank0[0xd76];
			bank0[0xd76]=0xed;	//change Read Bit, just return 1 in A
			taprom[5]=bank0[0xd77];
			bank0[0xd77]=0x01;
			taprom[6]=bank0[0xd78];
			bank0[0xd78]=0xc9;

			//NOW disable LOAD & MLOAD completely
		//	bank0[0xc95]=0xc3;
		//	bank0[0xc96]=0x95;
			//	bank0[0xc97]=0x0c;

			taprom[7]=bank0[0xc92];
			bank0[0xc92]=0xc3;
			taprom[8]=bank0[0xc93];
			bank0[0xc93]=0x92;
			taprom[9]=bank0[0xc94];
			bank0[0xc94]=0x0c;

		//	bank0[0x5f2a]=0xc3;
		//	bank0[0x5f2b]=0x62;
		//	bank0[0x5f2c]=0x3f;
			taprom[10]=bank0[0x5f2a];
			bank0[0x5f2a]=0xc3;
			taprom[11]=bank0[0x5f2b];
			bank0[0x5f2b]=0x2a;
			taprom[12]=bank0[0x5f2c];
			bank0[0x5f2c]=0x5f;


			
			//Patch Save routine to output OUT 93,x trapped here as SAVE
			//jump back in at 0cfb
			sav_ad=0xbcb;
			taprom[13]=bank0[sav_ad+0];
			bank0[sav_ad+0]=0x20;
			taprom[14]=bank0[sav_ad+1];
			bank0[sav_ad+1]=0xf4;
			taprom[15]=bank0[sav_ad+2];
			bank0[sav_ad+2]=0x01;//ld BC,0093
			taprom[16]=bank0[sav_ad+3];
			bank0[sav_ad+3]=0x93;
			taprom[17]=bank0[sav_ad+4];
			bank0[sav_ad+4]=0x00;
			taprom[18]=bank0[sav_ad+5];
			bank0[sav_ad+5]=0xed;//out a (c)
			taprom[19]=bank0[sav_ad+6];
			bank0[sav_ad+6]=0x79;
			taprom[20]=bank0[sav_ad+7];
			bank0[sav_ad+7]=0x00;//never gets to these :)
			taprom[21]=bank0[sav_ad+8];
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
	else
	{
		set_rawbuflen(BASE_RAW_BUFLEN);//64MB buffer !!!
	
		//Dont do anything if its in RAW mode - should be perfect emulation
		//so restore the ROM to its original state
		if (hw_type==LYNX_HARDWARE_48 || hw_type==LYNX_HARDWARE_96)
		{	
			//These are for the TAPE load/save routines
			bank0[0xd67]=0xf5;//taprom[0];	//change Tape Byte output, just return 0 in A ?
			bank0[0xd68]=0xe5;//taprom[1];
			bank0[0xd69]=0xd5;//taprom[2];	

			bank0[0xb65]=0xc5;	//disabled completely - Read Tape Sync
			
		//	bank0[0xcd4]=0xed;	//change Read Bit, just return 1 in A
		//	bank0[0xcd5]=0x01;
		//	bank0[0xcd6]=0xc9;
			bank0[0xcd4]=0x01;	//change Read Bit, just return 1 in A
			bank0[0xcd5]=0x80;
			bank0[0xcd6]=0x00;

			bank0[0xc95]=0xcd;	//set up an infint loop to wait here whilst VB is loading the RAM
			bank0[0xc96]=0x65;
			bank0[0xc97]=0x0b;

			bank0[0x3f62]=0x2a;	//and again for MLOAD
			bank0[0x3f63]=0xee;
			bank0[0x3f64]=0x61;

			
			//Patch Save routine to output OUT 93,x trapped here as SAVE
			//jump back in at 0cfb

			sav_ad=0xbcb;
			bank0[sav_ad+0]=0xcd;
			bank0[sav_ad+1]=0xb4;
			bank0[sav_ad+2]=0x0b;//ld BC,0093
			bank0[sav_ad+3]=0x13;
			bank0[sav_ad+4]=0x1a;
			bank0[sav_ad+5]=0x21;//out a (c)
			bank0[sav_ad+6]=0x00;
			bank0[sav_ad+7]=0x00;//never gets to these :)
			bank0[sav_ad+8]=0xe5;
		}
else if (hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
		{
			//LYNX 128 STUFF

			//These are for the TAPE load/save routines
			bank0[0xd3d]=0xf5;	//change Tape Byte output, just return 0 in A ?
			bank0[0xd3e]=0xe5;
			bank0[0xd3f]=0xd5;	
			
			bank0[0xb65]=0xc5;	//disabled completely - Read Tape Sync

			bank0[0xd76]=0x01;	//change Read Bit, just return 1 in A
			bank0[0xd77]=0x80;
			bank0[0xd78]=0x00;

			//NOW disable LOAD & MLOAD completely
		//	bank0[0xc95]=0xc3;
		//	bank0[0xc96]=0x95;
			//	bank0[0xc97]=0x0c;

			bank0[0xc92]=0x2a;
			bank0[0xc93]=0xfa;
			bank0[0xc94]=0x61;

		//	bank0[0x5f2a]=0xc3;
		//	bank0[0x5f2b]=0x62;
		//	bank0[0x5f2c]=0x3f;
			bank0[0x5f2a]=0x2a;
			bank0[0x5f2b]=0xee;
			bank0[0x5f2c]=0x61;
			
			//Patch Save routine to output OUT 93,x trapped here as SAVE
			//jump back in at 0cfb
			sav_ad=0xbcb;
			bank0[sav_ad+0]=0xcd;
			bank0[sav_ad+1]=0xb4;
			bank0[sav_ad+2]=0x0b;//ld BC,0093
			bank0[sav_ad+3]=0x13;
			bank0[sav_ad+4]=0x1a;
			bank0[sav_ad+5]=0xcd;//out a (c)
			bank0[sav_ad+6]=0xa6;
			bank0[sav_ad+7]=0x62;//never gets to these :)
			bank0[sav_ad+8]=0xc3;
		}
	}
}


extern  int  _stdcall  set_tape_mode(int gt)
{
	set_t_mode(gt);
	
	return(0);
}

extern  int  _stdcall  set_tape_operation(int gt)
{
	tape_operation=gt;	//0=stop 1=Play  2=record

	return(0);
}


extern  int  _stdcall  set_tape_spd(int gt)
{
	//Note this is the speed threshold dev stuff
	tape_spd=gt;
	
	return(0);
}


extern  int  _stdcall  set_tape_spd_adjust(int gt)
{
	//Note this is the tweakable speed adjustment
	tape_spd_adjust=gt-50;
	
	return(0);
}


extern  int  _stdcall  set_tape_inverted(int gt)
{
	tape_inverted=gt;
	
	return(0);
}

extern  int  _stdcall  get_raw_threshold(int gt)
{
	
	return(raw_threshold);
}
extern  int  _stdcall  set_raw_threshold(int gt)
{
	raw_threshold=gt;
	
	return(0);
}

extern  int  _stdcall  set_raw_position(unsigned int gt)
{
	raw_position=gt;
	
	return(0);
}


extern  int  _stdcall  set_raw_samprate(unsigned int gt)
{
	raw_sample_rate=gt;
	if ((raw_sample_rate<BASE_SAMPLE_RATE) || (raw_sample_rate>100000))	
	{	
		MessageBox(NULL,"Invalid Sample Rate","PALE ",MB_OK );
		raw_sample_rate=BASE_SAMPLE_RATE;
	}
	return(0);
}

extern  int  _stdcall  get_raw_samprate(int gt)
{
	return(raw_sample_rate);
}
extern  int  _stdcall  get_raw_samprate_index(int gt)
{
	return((raw_sample_rate/BASE_SAMPLE_RATE)-1);
}



extern  int  _stdcall  set_raw_buflen(int gt)
{
	
	if(tape_operation!=TAPE_STOPPED || tape_override==FORCE_PLAY ||  tape_override==FORCE_RECORD )
	{
		MessageBox(NULL,"STOP the tape before changing Buffer Length","PALE Change RAWBufferLength",MB_ICONERROR | MB_OK);
		return(0);
	}


	set_rawbuflen(gt);
	
	return(0);
}
extern  int _stdcall get_tape_monitor(unsigned char tapemon[],unsigned int gt)
{
	int f;
	if(raw_position>gt)
	{
		for(f=0;f<gt;f++)
		{
				//this little calc makes it return the last N points
				//hence this monitor works on SAVEing proggies too
				tapemon[f]=raw_tape[raw_position+f-gt];
		}
	}
	return(1);
}



void init_tapestuff()
{

	set_rawbuflen(1);


}




extern  int  _declspec(dllexport) load_tpa(char fnam[])
{
	int ret,errorr,g,h;
	int  handle,handle2;
	int  size_read,size_written;
	int cdd,f;
	char lbl[200];
	char cpmtpa[65536];

	handle=open( fnam, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, cpmtpa,65536);
	  close( handle );
	  if( size_read == -1 )
	  {
				ret=MessageBox(NULL,":( Couldn't Read the Input file","PALE Load CPM TPA",MB_ICONERROR | MB_OK);
				return(1);
	  }
	}
	else
	{
		ret=MessageBox(NULL,":( Couldn't open the Input file","PALE Load CPM TPA",MB_ICONERROR | MB_OK);
		return(1);
	}

	if(size_read==65536)
		ret=MessageBox(NULL,"This file is too big for the TPA","PALE Load CPM TPA",MB_ICONERROR | MB_OK);
	
	//Copy the data directly into CPM TPA
	for(f=0;f<size_read;f++)
		bank1[0x100+f]=cpmtpa[f];
	

	return(size_read);			
}


extern  int  _declspec(dllexport) run_tpa()
{

	//set bank sswitch to bank 1
	set_banklatch(0x08);
	set_pc(0x100);

	return(0);
}




#define LEADER_SPEC_SPEED 30
#define SYNC1_SPEC_SPEED 10
#define SYNC2_SPEC_SPEED 8
#define DATA0_SPEC_SPEED 12
#define DATA1_SPEC_SPEED 24


#define SPEC_TAPE_HI 240
#define SPEC_TAPE_LO 10

void write_speccyleader()
{
//pilot tone 808Hz
	int f,g,h;
	//Silence
	for(g=0;g<400*LEADER_SPEC_SPEED;g++)
			raw_tape[raw_position++]=128;
	for(f=0;f<8063;f++)
	{
		for(g=0;g<LEADER_SPEC_SPEED;g++)
			raw_tape[raw_position++]=SPEC_TAPE_HI;
		for(g=0;g<LEADER_SPEC_SPEED;g++)
			raw_tape[raw_position++]=SPEC_TAPE_LO;
	}

	//Synch Bit short pulse at 2450Hz
		for(g=0;g<SYNC1_SPEC_SPEED;g++)
			raw_tape[raw_position++]=SPEC_TAPE_HI;
		for(g=0;g<SYNC2_SPEC_SPEED;g++)
			raw_tape[raw_position++]=SPEC_TAPE_LO;
	
		//for(g=0;g<SYNC2_SPEC_SPEED;g++)
		//	raw_tape[raw_position++]=SPEC_TAPE_HI;
		//for(g=0;g<SYNC2_SPEC_SPEED;g++)
		//	raw_tape[raw_position++]=SPEC_TAPE_LO;

}

void write_spec1()
{
//bit 1 at 1024Hz
	int f,g,h;
		for(g=0;g<DATA1_SPEC_SPEED;g++)
			raw_tape[raw_position++]=SPEC_TAPE_HI;
		for(g=0;g<DATA1_SPEC_SPEED;g++)
			raw_tape[raw_position++]=SPEC_TAPE_LO;
}

void write_spec0()
{
//bit 0 at 2044Hz
	int f,g,h;
		for(g=0;g<DATA0_SPEC_SPEED ;g++)
			raw_tape[raw_position++]=SPEC_TAPE_HI;
		for(g=0;g<DATA0_SPEC_SPEED ;g++)
			raw_tape[raw_position++]=SPEC_TAPE_LO;
}

void convert_specbyte(unsigned char inbyte)
{
	int h;
	unsigned char shifter;
	for(h=0;h<8;h++)
	{
	//	shifter=(0x01<<h);
		shifter=(0x80>>h);
		if((inbyte & shifter)==0)
			write_spec0();
		else
			write_spec1();
	}
}

extern  int  _declspec(dllexport) load_speccy(char fnam[])
{
	int ret,errorr,g,h;
	int  handle,handle2;
	int  size_read,size_written;
	unsigned int cdd,f;
	char lbl[200];
	unsigned char specbuf[100000];
	unsigned int blockpos,blocksize;

	handle=open( fnam, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, specbuf,100000);
	  close( handle );
	  if( size_read == -1 )
	  {
				ret=MessageBox(NULL,":( Couldn't Read the Input file","PALE Load Speccy",MB_ICONERROR | MB_OK);
				return(1);
	  }
	}
	else
	{
		ret=MessageBox(NULL,":( Couldn't open the Input file","PALE Load Speccy",MB_ICONERROR | MB_OK);
		return(1);
	}

	if(size_read==100000)
		ret=MessageBox(NULL,"This file is too big for Speccy","PALE Load Speccy",MB_ICONERROR | MB_OK);
	
	//Copy the data directly into CPM TPA

	//convert TAP into raw pcm waveform file
	//and bung it into the tape recorder
	cdd=0;
	raw_position=0;

	blocksize=0;
	while(cdd<size_read)
	{
		//Get block size
		blocksize=(specbuf[cdd]+(specbuf[cdd+1]*0x100));

//sprintf(lbl,"Specbuf n=%2x   N+1=%2x,  BLocksize %2x",specbuf[cdd],specbuf[cdd+1],blocksize);
//ret=MessageBox(NULL,lbl,"PALE Load Speccy",MB_ICONERROR | MB_OK);
if(blocksize<65000 && blocksize!=0)
{

		//write a leader to the tape buffer
		write_speccyleader();
//		convert_specbyte(specbuf[cdd]);
//		convert_specbyte(specbuf[cdd+1]);

		blockpos=0;
		cdd+=2;
		
		while(blockpos<blocksize)
		{
			//Convert each byte into a pulse train
			convert_specbyte(specbuf[cdd]);
			cdd++;
			blockpos++;
		}
}
else goto break_out;

	}

break_out:

	raw_samples=raw_position;

	return(size_read);			
}



extern  int _stdcall load_lsf(unsigned char fn[])
{
	FILE *handle2;
	Z80_Regs i;
	unsigned int Addr,Count;
	unsigned char Chr,c;
    int len, eof,f;
	char lbl[100];
//sprintf(lbl,"GOT TO LOAD");
//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);

   handle2 = fopen((const char *)fn,"rb");
    if( handle2 != NULL )
	{
		i.AF.W.h=0x0;
		i.BC.W.h=0x0;
		i.DE.W.h=0x0;
		i.HL.W.h=0x0;
		i.IX.W.h=0x0;
		i.IY.W.h=0x0;
		i.PC.W.h=0x0;
		i.SP.W.h=0x0;
		i.AF2.W.h=0x0;
		i.BC2.W.h=0x0;
		i.DE2.W.h=0x0;
		i.HL2.W.h=0x0;
		i.IFF1=0x0;
		i.IFF2=0x0;
		i.I=0x0;
		i.R=0x0;
		i.IM=0x0;
		
		
		//Read in the registers
		i.AF.B.h=fgetc(handle2);
		i.AF.B.l=fgetc(handle2);
		i.BC.B.h=fgetc(handle2);
		i.BC.B.l=fgetc(handle2);
		i.DE.B.h=fgetc(handle2);
		i.DE.B.l=fgetc(handle2);
		i.HL.B.h=fgetc(handle2);
		i.HL.B.l=fgetc(handle2);
		i.IX.B.h=fgetc(handle2);
		i.IX.B.l=fgetc(handle2);
		i.IY.B.h=fgetc(handle2);
		i.IY.B.l=fgetc(handle2);
		i.PC.B.h=fgetc(handle2);
		i.PC.B.l=fgetc(handle2);
//sprintf(lbl,"IN LOAD PC is  %04X    PC h is %02X  l is %02X",i.PC  ,i.PC.B.h,i.PC.B.l);
//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
		i.SP.B.h=fgetc(handle2);
		i.SP.B.l=fgetc(handle2);
		i.AF2.B.h=fgetc(handle2);
		i.AF2.B.l=fgetc(handle2);
		i.BC2.B.h=fgetc(handle2);
		i.BC2.B.l=fgetc(handle2);
		i.DE2.B.h=fgetc(handle2);
		i.DE2.B.l=fgetc(handle2);
		i.HL2.B.h=fgetc(handle2);
		i.HL2.B.l=fgetc(handle2);
		i.IFF1=fgetc(handle2);
		i.IFF2=fgetc(handle2);
		i.I=fgetc(handle2);
		i.R=fgetc(handle2);
		i.IM=fgetc(handle2);
		
		
		/*		i.AF.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.BC.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.DE.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.HL.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.IX.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.IY.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.PC.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.SP.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.AF2.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.BC2.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.DE2.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.HL2.W.l=(fgetc(handle2)<<8)+fgetc(handle2);
		i.IFF1=fgetc(handle2);
		i.IFF2=fgetc(handle2);
		i.I=fgetc(handle2);
		i.R=fgetc(handle2);
		i.IM=fgetc(handle2);
*/

		start_im1_irq=fgetc(handle2);//IRQLine
		c=fgetc(handle2);//	IRQVector	-	Dummy not used here
		
		set_regs (i);
								 

		video_latch=fgetc(handle2);
		bank_latch=fgetc(handle2);

		for(f=0;f<18;f++)
			CRTC_reg[f]=fgetc(handle2);

        eof=0;
 

 		Addr=0;
        while(!eof && Addr<0x10000)
        {
                c=fgetc(handle2);
                if (c!=0xED) bank1[Addr++]=c;
                else
                {
                        len=fgetc(handle2);
                        if (!len) eof=1;
                        else
                        {
                                c=fgetc(handle2);
                                while(len--) bank1[Addr++]=c;
                        }
                }
                if (feof(handle2))	eof=1;
        }
//sprintf(lbl,"Bank1 Addr=%d",Addr);
//gui_error(lbl);

 		Addr=0;
        while(!eof && Addr<0x10000)
        {
                c=fgetc(handle2);
                if (c!=0xED) bank2[Addr++]=c;
                else
                {
                        len=fgetc(handle2);
                        if (!len) eof=1;
                        else
                        {
                                c=fgetc(handle2);
                                while(len--) bank2[Addr++]=c;
                        }
                }
                if (feof(handle2)) eof=1;
        }

 		Addr=0;
        while(!eof && Addr<0x10000)
        {
                c=fgetc(handle2);
                if (c!=0xED) bank3[Addr++]=c;
                else
                {
                        len=fgetc(handle2);
                        if (!len) eof=1;
                        else
                        {
                                c=fgetc(handle2);
                                while(len--) bank3[Addr++]=c;
                        }
                }
                if (feof(handle2)) eof=1;
        }

		fclose(handle2);
	}
	return(1);
}


//LYNX SNAP FORMAT FILES
//extern  int _stdcall load_lynx_tap(unsigned char fn[],unsigned char fn2[], unsigned char tape_type)

extern  int _stdcall save_lsf(unsigned char fn[])
{
	FILE *handle2;
	Z80_Regs i;
	char lbl[100];
	unsigned int Addr,Count,f;
	unsigned char Chr;

//sprintf(lbl,"GOT TO SAVE");
//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
    
	handle2 = fopen((const char *)fn,"wb");
    if( handle2 != NULL )
	{
//sprintf(lbl,"OPENED FILE");
//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);

		get_regs (&i);
		fputc(i.AF.B.h,handle2);
		fputc(i.AF.B.l,handle2);
		fputc(i.BC.B.h,handle2);
		fputc(i.BC.B.l,handle2);
//sprintf(lbl,"IN SAVE DE is  %04X    DE h is %02X  l is %02X",i.DE  ,i.DE.B.h,i.DE.B.l);
//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
		fputc(i.DE.B.h,handle2);
		fputc(i.DE.B.l,handle2);
		fputc(i.HL.B.h,handle2);
		fputc(i.HL.B.l,handle2);
		fputc(i.IX.B.h,handle2);
		fputc(i.IX.B.l,handle2);
		fputc(i.IY.B.h,handle2);
		fputc(i.IY.B.l,handle2);
//sprintf(lbl,"IN SAVE PC is  %04X    PC h is %02X  l is %02X",i.PC  ,i.PC.B.h,i.PC.B.l);
//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
		fputc(i.PC.B.h,handle2);
		fputc(i.PC.B.l,handle2);
		fputc(i.SP.B.h,handle2);
		fputc(i.SP.B.l,handle2);
		fputc(i.AF2.B.h,handle2);
		fputc(i.AF2.B.l,handle2);
		fputc(i.BC2.B.h,handle2);
		fputc(i.BC2.B.l,handle2);
		fputc(i.DE2.B.h,handle2);
		fputc(i.DE2.B.l,handle2);
		fputc(i.HL2.B.h,handle2);
		fputc(i.HL2.B.l,handle2);
		fputc(i.IFF1,handle2);

		fputc(i.IFF2,handle2);
		fputc(i.I,handle2);
		fputc(i.R,handle2);

		fputc(i.IM,handle2);

		fputc(i.I,handle2);//IRQVector  -   FOR RAZE  same as I register here

		if(start_im1_irq)
			fputc(0x00,handle2);//IRQLine	-possibly inverted of mine
		else
			fputc(0x01,handle2);//IRQLine	-possibly inverted of mine

		fputc(video_latch,handle2);
		fputc(bank_latch,handle2);

		for(f=0;f<18;f++)
			fputc(CRTC_reg[f],handle2);

                 

	//	    fputc(0xed,handle2);
	//    fputc(0x00,handle2);

	    Addr=0x00;
	    while(Addr<0x10000)
	    {
	            Chr=bank1[Addr];
	            Count=1;
	
	            while((bank1[Addr+Count]==Chr) && ((Addr+Count)<=0x10000))
	                    Count++;
	
	            if (Count>240) Count=240;
	
	            if ( Count>3 || Chr==0xed)
	            {
	                    fputc(0xed,handle2);
	                    fputc(Count,handle2);
	            }
	            else    Count=1;
	
	            fputc(Chr,handle2);
	            Addr+=Count;
	    }
	//    fputc(0xed,handle2);
	 //   fputc(0x00,handle2);

	    Addr=0x00;
	    while(Addr<0x10000)
	    {
	            Chr=bank2[Addr];
	            Count=1;
	
	            while((bank2[Addr+Count]==Chr) && ((Addr+Count)<=0x10000))
	                    Count++;
	
	            if (Count>240) Count=240;
	
	            if ( Count>3 || Chr==0xed)
	            {
	                    fputc(0xed,handle2);
	                    fputc(Count,handle2);
	            }
	            else    Count=1;
	
	            fputc(Chr,handle2);
	            Addr+=Count;
	    }
	  //  fputc(0xed,handle2);
	  //  fputc(0x00,handle2);

	    Addr=0x00;
	    while(Addr<0x10000)
	    {
	            Chr=bank3[Addr];
	            Count=1;
	
	            while((bank3[Addr+Count]==Chr) && ((Addr+Count)<=0x10000))
	                    Count++;
	
	            if (Count>240) Count=240;
	
	            if ( Count>3 || Chr==0xed)
	            {
	                    fputc(0xed,handle2);
	                    fputc(Count,handle2);
	            }
	            else    Count=1;
	
	            fputc(Chr,handle2);
	            Addr+=Count;
	    }
	    fputc(0xed,handle2);
	    fputc(0x00,handle2);
		fclose(handle2);
	}
	return(1);
}

