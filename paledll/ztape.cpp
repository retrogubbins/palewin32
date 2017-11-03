//PALETAPE Lynx Tape Reader
//PALETAPE Lynx Tape Reader
//PALETAPE Lynx Tape Reader
//PALETAPE Lynx Tape Reader
//	Pete Todd 2003
//PALETAPE Lynx Tape Reader
//PALETAPE Lynx Tape Reader
//PALETAPE Lynx Tape Reader
//PALETAPE Lynx Tape Reader
//PALETAPE Lynx Tape Reader
//PALETAPE Lynx Tape Reader


#include <stdio.h>


//#include <conio.h>
#include <stdlib.h>
//#include <process.h>
//#include <dos.h>
#include <string.h>

#include <fcntl.h>
//#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <io.h>
#include <windows.h>

static unsigned char t_thresh;
static unsigned int tape_speed;
static unsigned int speed_width;
static unsigned int skipbits;
static unsigned int synced;
static unsigned int raw_tape;	// just grab the bytes - dont asume any structure
static unsigned long cur_tape;
static unsigned long cur_byte;
static unsigned char buffer[65536];//leave room for big proggy ;)
static unsigned char tape[10000000];//leave room for big proggy ;)
static char lbl[400];
//#define RESULTS_LENGTH 2000000
//static unsigned char results[RESULTS_LENGTH];//results text

static int verb=0;

#define TAP_BASIC	0x42
#define TAP_BINARY	0x4d   //Lynx Binary format
#define TAP_DATA	0x41 //Level 9 Data


//void rprintf(char *append_txt)
//{
//	strcat((char *)results,append_txt);
//}

void skip_bit(int sync,unsigned char outext[])
{
	unsigned int g;
//		if(verb && !sync){sprintf(lbl,"Skipping a Bit\x0d\x0a");
//							strcat((char*)outext,lbl);}

		//Skip a BIT
		while(tape[cur_tape]>t_thresh)//==1)	
		{
//		if(verb && !sync){sprintf(lbl,"Searching - while tape=%02x > 0x81\x0d\x0a",tape[cur_tape]);
//								strcat((char*)outext,lbl);}
			cur_tape++;
		}

		do
		{
//		if(verb && !sync){sprintf(lbl,"Getting Bit Length - while tape=%02x <= 0x88\x0d\x0a",tape[cur_tape]);
//								strcat((char*)outext,lbl);}
		}
		while(tape[cur_tape++]<=t_thresh);//!=1 );  //get length of lo
}


unsigned char read_byte(int sync,unsigned char outext2[])
{
	unsigned int g;
	unsigned long bitlen;
	unsigned int final_byte;
	final_byte=0;
	if(verb && !sync){sprintf(lbl,"Reading a Byte\x0d\x0a");
								strcat((char*)outext2,lbl);}
					
	for(g=0;g<8;g++)
	{
		if(verb && !sync){sprintf(lbl,"Reading Bit %d\x0d\x0a",g);
								strcat((char*)outext2,lbl);}
		
//do_it_again:
		
		//Read a BIT
		while(tape[cur_tape]>t_thresh)//==1)	
		{
//			if(verb && !sync){sprintf(lbl,"Searching - while tape=%02x > 0x81\x0d\x0a",tape[cur_tape]);
//								strcat((char*)outext2,lbl);}
			cur_tape++;
		}

		bitlen=0;
		do
		{
//			if(verb && !sync){sprintf(lbl,"Getting Bit Length - while tape=%02x <= 0x88\x0d\x0a",tape[cur_tape]);
//									strcat((char*)outext2,lbl);}
			bitlen++;
		}
		while(tape[cur_tape++]<=t_thresh);//!=1 );  //get length of lo
		

		//Compare width with baud rate width
		//if longer then 1  :)

//		if(bitlen<5)
//			goto do_it_again;		

		
		
		if(bitlen>speed_width)
				final_byte=(final_byte | 0x01) << 1;
		else
				final_byte=final_byte<< 1;
		if(verb){sprintf(lbl,"Byte No: %02x (Bit %d), CurTape %u, Bitlen %d Byte - %02x\x0d\x0a",cur_byte,g,cur_tape,bitlen,final_byte);
					strcat((char*)outext2,lbl);}
	}
	
	final_byte=(final_byte>>1) & 0x00ff;
	
	return(final_byte);
}

unsigned char read_sync(unsigned char outext3[])
{
	int ret,b,f;
	//Got the Tape, now process
	//get sync
	ret=0;

	for(f=0;f<skipbits;f++)
		skip_bit(1,outext3);

	do
	{
		if(ret=0)b=0x28;
		ret=read_byte(1,outext3);
	}
	while(ret==0 && b-- >0);
return(ret);
}

//load_lynx_tap(unsigned char fn[],unsigned char fn2[], unsigned char tape_type)

extern  int _stdcall paletape(unsigned char ifil[],unsigned char ofil[],unsigned char vr,unsigned char vb,unsigned char vuu,unsigned char vuku,unsigned char t_th,unsigned char  t_s,unsigned char  r_t,unsigned char otex[],unsigned char vtex[],int &readin,int &readreq)
{
	int  handle,handle2;
	unsigned char file_id=0,sync_marker=0xa5;	//default sync marker 
	unsigned int b,f,prog_header;
	unsigned int bytes_readin,bytes_fromheader;
	unsigned long prog_sync_savedpos;
	unsigned long  size_written,size_read,last_byte_pos;
	unsigned char ret,csum,csum_read;
	unsigned char quiet=0;
	unsigned char scan_csums=0;
	unsigned char fna[1000];
	unsigned char no_writes=0;
	unsigned char only_good_lengths=0;
	unsigned char c3=0,b1=0,b2=0;
	unsigned char show_linenos=0;
	
	tape_speed=t_s;
	raw_tape=r_t;
	quiet=vb;
	t_thresh=t_th;
	no_writes=vuu;
	only_good_lengths=vuku;
	show_linenos=vr;
	//return(0);


	/* open a file for input		  */
	switch(tape_speed)
	{
//		case 0:	speed_width=16; break;
		case 0:	speed_width=17; break;
//		case 1:	speed_width=2; break;  //guess
		case 1:	speed_width=15; break;  //guess
		case 2:	speed_width=13; break;  //guess
		case 3: speed_width=12; break;  //guess
		case 4:	speed_width=10; break;  //guess
		case 5: speed_width=8; break;
	}

	sprintf((char *)otex,"...");
	sprintf(lbl,"Reading Input RAW File\x0d\x0a");
	if(!quiet)strcat((char *)otex,lbl);
//sprintf(lbl,"fname is %s",ifil);
//MessageBox(NULL,lbl,"PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);
	handle = open((char*) ifil, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, tape,
			sizeof( tape ) );
	  if( size_read == -1 ) {
//			sprintf("Error reading input RAW file\x0d\x0a");
	  }
	  /* close the file 		    */
	  close( handle );
	  if( size_read == -1 )
				return(1);
	}
	else
	{
	//	sprintf("Couldnt open file for reading\x0d\x0a");
		return(2);
	}

	
			
			
	sprintf(lbl,"Tape Size Read was %d raw bytes\x0d\x0a",size_read);
	if(!quiet)strcat((char *)otex,lbl);
	cur_tape=0;
	cur_byte=0;
	prog_header=0;

	if(raw_tape==0)
	{
		sprintf(lbl,"Reading the Name Sync\x0d\x0a");
		if(!quiet)strcat((char *)otex,lbl);

		synced=skipbits=0;
		do{
			cur_tape=0; //reset to start of tape
			synced=read_sync(otex);
			if(synced!=sync_marker) synced=0;
			skipbits++;
		}while(!synced && skipbits<9);

		if(skipbits==9)
		{
//			sprintf((char *)otex,(" *****   Couldn't Find the %02x Marker, try removing the sync zeroes   *******\n",sync_marker);
//			exit(-1);
			return(3);
		}
		sprintf(lbl,"Sync Ended at %u, Bitshift was %d, byte was %02x\x0d\x0a",cur_tape,skipbits-1,synced);
		if(!quiet)strcat((char *)otex,lbl);
				
		//	buffer[cur_byte++]=ret;  //No, Mr. Bond, thow away this identify marker of a5 at start of tape
		ret=read_byte(0,otex);
		buffer[cur_byte++]=ret;//Should be a ", but we'll check for the end one ;)
		
		//Read Filename
		sprintf(lbl,"\x0d\x0a\x0d\x0a");
		if(!quiet)strcat((char *)otex,lbl);
		sprintf(lbl,"Filename: %c",ret);
		if(!quiet)strcat((char *)otex,lbl);
	//	sprintf((char*)fna,"Filename: %c",ret);
		sprintf((char*)fna,"%c",ret);
		
		do
		{
			ret=read_byte(0,otex);
			buffer[cur_byte++]=ret;
			sprintf(lbl,"%c",ret);
			strcat((char *)otex,lbl);
			if(ret>32 && ret<128)strcat((char*)fna,lbl);
			else strcat((char*)fna,"?");
		}
		while(ret!='"' && cur_byte<30);
		if(quiet)
		{		
				sprintf(lbl,"\x00");
				strcat((char*)fna,lbl);
				strcpy((char*)vtex,(char*)fna);
//				return(0);	
		}

		sprintf(lbl,"\x0d\x0a\x0d\x0a");
		if(!quiet)strcat((char *)otex,lbl);


		if (cur_byte==30)
		{
//			sprintf(lbl,(" *****   Couldn't Get Recognizable Filename   *******\n");
			return(4);
		}
	}	
	sprintf(lbl,"Reading the Program Sync\x0d\x0a");
if(!quiet)	strcat((char *)otex,lbl);
	prog_sync_savedpos=cur_tape;
	skipbits=skipbits=0;
	do{
		cur_tape=prog_sync_savedpos; //reset to start of sync
		synced=read_sync(otex);
		if(synced!=sync_marker) synced=0;
		skipbits++;
	}while(!synced && skipbits<9);
	
	if(skipbits==9)
	{
//		sprintf(lbl,(" *****   Couldn't Find the %02x Marker, try removing the sync zeroes   *******\n",sync_marker);
//		exit(-1);
		return(5);
	}
	if(verb){sprintf(lbl,"Sync Ended at %u, Bitshift was %d, byte was %02x\x0d\x0a",cur_tape,skipbits-1,synced);
if(!quiet)				strcat((char *)otex,lbl);}
	prog_header=cur_byte;


//	buffer[cur_byte++]=ret; //First byte of the program :))
	prog_header=cur_byte;
	//Read Program
	while(cur_tape<size_read)
	{
		ret=read_byte(0,otex);
		buffer[cur_byte++]=ret;

		
		if(c3==1)
		{
			c3=2;
			b1=ret;
		}
		else
		if(c3==2)
		{
			c3=0;
			b2=ret;
			if(show_linenos==1)
			{
				sprintf(lbl,"Line %2X %2X, Sample %d\x0d\x0a",b1,b2,cur_tape);
				strcat((char *)otex,lbl);
			}
		}

		if(ret==0xc3)
		{
			c3=1;
		}
		
		
		
		last_byte_pos=cur_tape;
		if(cur_byte %1000==0)
		{
			sprintf(lbl,".");
if(!quiet)			strcat((char *)otex,lbl);
		}
	}
	sprintf(lbl,"\x0d\x0a");
if(!quiet)	strcat((char *)otex,lbl);


	file_id=buffer[prog_header];
	if(file_id==TAP_BASIC)
		sprintf(lbl,"BASIC Program Found");
	else if(file_id==TAP_BINARY)
		sprintf(lbl,"Binary MLOAD Program Found");
	else if(file_id==TAP_DATA)
		sprintf(lbl,"Level9 Data Found");
if(!quiet)	strcat((char *)otex,lbl);
	sprintf(lbl,"\x0d\x0a\x0d\x0a");
if(!quiet)	strcat((char *)otex,lbl);


	//WHAT IS THIS EXTRA number in the header of power blaster
	//ITS A CRC checksum - ya fule
	//	if(buffer[cur_byte-1]==0xa5)
//		prog_header++;

//	cur_byte=buffer[prog_header+1]+256*buffer[prog_header+2];//tap length
	cur_byte--;

	if(verb){sprintf(lbl,"\x0d\x0aGot %u Bytes, last byte at position %u\x0d\x0a",cur_byte,last_byte_pos);
		if(!quiet)			strcat((char *)otex,lbl);}
	

//	if(raw_tape<2)
//	{
		sprintf(lbl,"Header Bytes:\x0d\x0a");
if(!quiet)		strcat((char *)otex,lbl);
		for(f=0;f<10;f++)
		{
			sprintf(lbl,"%02x ",buffer[prog_header+f]);
			strcat((char *)otex,lbl);
		}
		sprintf(lbl,"\x0d\x0a");
if(!quiet)		strcat((char *)otex,lbl);
		sprintf(lbl,"Final Bytes:\x0d\x0a");
if(!quiet)		strcat((char *)otex,lbl);
		for(f=0;f<10;f++)
		{
			sprintf(lbl,"%02x ",buffer[cur_byte-10+f]);
if(!quiet)			strcat((char *)otex,lbl);
		}
		sprintf(lbl,"\x0d\x0a");
if(!quiet)		strcat((char *)otex,lbl);
		if(file_id==TAP_BINARY)
		{
			//find program header info - for Level 9 header - a5 41 <DEST> <LENGTH> xx ...
			sprintf(lbl,"Binary Start = %d (%04x)\x0d\x0a",buffer[prog_header+3]+256*buffer[prog_header+4],
				buffer[prog_header+3]+256*buffer[prog_header+4]);
if(!quiet)			strcat((char *)otex,lbl);
			sprintf(lbl,"Binary Length = %d (%04x)\x0d\x0a",buffer[prog_header+1]+256*buffer[prog_header+2],
				buffer[prog_header+1]+256*buffer[prog_header+2]);
if(!quiet)			strcat((char *)otex,lbl);
			sprintf(lbl,"Binary Execute = %d (%04x)\x0d\x0a",buffer[cur_byte-3]+256*buffer[cur_byte-2],
				buffer[cur_byte-3]+256*buffer[cur_byte-2]);
if(!quiet)			strcat((char *)otex,lbl);
		}
		else if(file_id==TAP_DATA)
		{
			//find program header info - for Level 9 header - a5 41 <DEST> <LENGTH> xx ...
			sprintf(lbl,"Binary Start = %d (%04x)\x0d\x0a",buffer[prog_header+1]+256*buffer[prog_header+2],
				buffer[prog_header+1]+256*buffer[prog_header+2]);
if(!quiet)			strcat((char *)otex,lbl);
			sprintf(lbl,"Binary Length = %d (%04x)\x0d\x0a",buffer[prog_header+3]+256*buffer[prog_header+4],
				buffer[prog_header+3]+256*buffer[prog_header+4]);
if(!quiet)			strcat((char *)otex,lbl);
			sprintf(lbl,"Binary End = %d (%04x)\x0d\x0a",buffer[prog_header+1]+256*buffer[prog_header+2]+buffer[prog_header+3]+256*buffer[prog_header+4],
				buffer[prog_header+1]+256*buffer[prog_header+2]+buffer[prog_header+3]+256*buffer[prog_header+4]);
if(!quiet)			strcat((char *)otex,lbl);
		}
		else
		{
			//find program header info
			sprintf(lbl,"Program Length = %d (%04x)\x0d\x0a",buffer[prog_header+1]+256*buffer[prog_header+2],
				buffer[prog_header+1]+256*buffer[prog_header+2]);
if(!quiet)			strcat((char *)otex,lbl);
			sprintf(lbl,"Program End = %d (%04x)\x0d\x0a",0x649d+buffer[prog_header+1]+256*buffer[prog_header+2],
				0x649d+buffer[prog_header+1]+256*buffer[prog_header+2]);
if(!quiet)			strcat((char *)otex,lbl);
			sprintf(lbl,"Program Execute = %d (%04x)\x0d\x0a",buffer[cur_byte-3]+256*buffer[cur_byte-2],
				buffer[cur_byte-3]+256*buffer[cur_byte-2]);
if(!quiet)			strcat((char *)otex,lbl);
		}
//	}

//	cur_byte++;//get back to noof bytes again, not pointer

	//got the bytes so save them to disk :)
    /* open a file for output		  */
//	sprintf(lbl,("Writing TAP file\n");

	handle2=0;
	if(no_writes==0)handle2 = open((char*) ofil,O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
		if(no_writes==0)size_written = write( handle2, buffer, cur_byte );
		if(no_writes==0)close( handle2 );
		if(verb)
		{
			sprintf(lbl,"Okay. %u bytes written\x0d\x0a",size_written);
			if(!quiet)strcat((char *)otex,lbl);
		}



		//Test the legnth of Bytes received vs that read ffrom the header
		if(file_id==TAP_BINARY)
		{	
			bytes_readin=(cur_byte-prog_header)-10;//one extra for the csum
			readin=bytes_readin;
			bytes_fromheader=buffer[prog_header+1]+256*buffer[prog_header+2];
			readreq=bytes_fromheader;
			if(bytes_readin!=bytes_fromheader)
			{
					sprintf(lbl,"Wrong Length, Read %u Actual %u\x0d\x0a",bytes_fromheader,bytes_readin);
					if(!quiet)strcat((char *)otex,lbl);
					if(quiet && only_good_lengths==1)return(8);
			}
			else
			{
					sprintf(lbl,"Correct Length, Read %u Actual %u\x0d\x0a",bytes_fromheader,bytes_readin);
					if(!quiet)strcat((char *)otex,lbl);

			}
		}
		else if(file_id!=TAP_DATA)  //then it must be a BASI proggy
		{
			bytes_readin=(cur_byte-prog_header)-6;
			readin=bytes_readin;
			bytes_fromheader=buffer[prog_header+1]+256*buffer[prog_header+2];
			readreq=bytes_fromheader;
			if(bytes_readin!=bytes_fromheader)
			{
					sprintf(lbl,"Wrong Length, Read %u Actual %u\x0d\x0a",bytes_fromheader,bytes_readin);
					if(!quiet)strcat((char *)otex,lbl);
					if(quiet && only_good_lengths==1)return(8);
			}
			else
			{
					sprintf(lbl,"Correct Length, Read %u Actual %u\x0d\x0a",bytes_fromheader,bytes_readin);
					if(!quiet)strcat((char *)otex,lbl);

			}
		}

		sprintf(lbl,"Not Checksummed\x0d\x0a");
		if(file_id==TAP_BINARY || file_id==TAP_DATA)
		{
//	MessageBox(NULL,"saving","PALE ",MB_YESNOCANCEL | MB_DEFBUTTON1);

			//Get Prog CHecksum
			csum=0;
			for(f=0;f<buffer[prog_header+1]+256*buffer[prog_header+2];f++)
			{
				csum+=buffer[prog_header+5+f];//only used for binary MLOADed progs & Level 9 Data
			}
			csum_read=buffer[prog_header+5+buffer[prog_header+1]+256*buffer[prog_header+2]];
			if(csum!=csum_read)
			{
					sprintf(lbl,"Checksum BAD, Read %u Actual %u\x0d\x0a",csum_read,csum);
					if(!quiet)strcat((char *)otex,lbl);
					return(7);
			}
			else
			{
					sprintf(lbl,"Checksum GOOD - Value %u\x0d\x0a",csum_read,csum);
			}
		}
		if(!quiet)strcat((char *)otex,lbl);
		//Copy output results into vtex
		//	for(f=0;f<RESULTS_LENGTH;f++)
		//			vtex[f]=results[f];
		return(0);
	}
	else
	{

		//		sprintf(lbl,(" :( Couldnt open TAP file for writing - dugh!\n");
		return(6);
	}
}
