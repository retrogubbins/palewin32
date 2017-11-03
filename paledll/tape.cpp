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
#include <fcntl.h>
//#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <io.h>

static unsigned char t_thresh;
static unsigned int tape_speed;
static unsigned int speed_width;
static unsigned int skipbits;
static unsigned int synced;
static unsigned int raw_tape;	// just grab the bytes - dont asume any structure
static unsigned long cur_tape;
static unsigned long cur_byte;
static unsigned char buffer[65536];//leave room for big proggy ;)
static unsigned char tape[5000000];//leave room for big proggy ;)

static int verb=1;

#define TAP_BASIC	0x42
#define TAP_BINARY	0x4d   //Lynx Binary format
#define TAP_DATA	0x41 //Level 9 Data


void skip_bit(int sync)
{
	unsigned int g;
//		if(verb && !sync)printf("Skipping a Bit\n");
		//Skip a BIT
		while(tape[cur_tape]>t_thresh)//==1)	
		{
//		if(verb && !sync)	printf("Searching - while tape=%02x > 0x81\n",tape[cur_tape]);
			cur_tape++;
		}

		do
		{
//		if(verb && !sync)	printf("Getting Bit Length - while tape=%02x <= 0x88\n",tape[cur_tape]);
		}
		while(tape[cur_tape++]<=t_thresh);//!=1 );  //get length of lo
}


unsigned char read_byte(int sync)
{
	unsigned int g;
	unsigned long bitlen;
	unsigned int final_byte;
	final_byte=0;
//if(verb && !sync)printf("Reading a Byte\n");
	for(g=0;g<8;g++)
	{
//if(verb && !sync)printf("Reading Bit %d\n",g);
		//Read a BIT
		while(tape[cur_tape]>t_thresh)//==1)	
		{
//		if(verb && !sync)	printf("Searching - while tape=%02x > 0x81\n",tape[cur_tape]);
			cur_tape++;
		}

		bitlen=0;
		do
		{
//		if(verb && !sync)	printf("Getting Bit Length - while tape=%02x <= 0x88\n",tape[cur_tape]);
			bitlen++;
		}
		while(tape[cur_tape++]<=t_thresh);//!=1 );  //get length of lo
		

		//Compare width with baud rate width
		//if longer then 1  :)
		if(bitlen>speed_width)
				final_byte=(final_byte | 0x01) << 1;
		else
				final_byte=final_byte<< 1;
//	if(verb)printf("Byte No: %02x (Bit %d), CurTape %u, Bitlen %d Byte - %02x\n",cur_byte,g,cur_tape,bitlen,final_byte);
	}
	
	final_byte=(final_byte>>1) & 0x00ff;
	
	return(final_byte);
}

unsigned char read_sync()
{
	int ret,b,f;
	//Got the Tape, now process
	//get sync
	ret=0;

	for(f=0;f<skipbits;f++)
		skip_bit(1);

	do
	{
		if(ret=0)b=0x28;
		ret=read_byte(1);
	}
	while(ret==0 && b-- >0);
return(ret);
}

//load_lynx_tap(unsigned char fn[],unsigned char fn2[], unsigned char tape_type)

extern  int _stdcall paletape(unsigned char ifil[],unsigned char ofil[],unsigned char verb ,unsigned char t_thresh,unsigned char  tape_speed,unsigned char  raw_tape)
{
	int  handle,handle2;
	unsigned char file_id=0,sync_marker=0xa5;	//default sync marker
	unsigned int b,f,prog_header;
	unsigned long prog_sync_savedpos;
	unsigned long  size_written,size_read,last_byte_pos;
	char lbl[100];
	unsigned char ret;


return(0);


	/* open a file for input		  */
	switch(tape_speed)
	{
		case 0:	speed_width=16; break;
		case 3: speed_width=8; break;  //guess
		case 5: speed_width=6; break;
	}

	

//	printf("Reading Input RAW File\n");
	handle = open((char*) ifil, O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, tape,
			sizeof( tape ) );
	  if( size_read == -1 ) {
//	  printf( "Error reading input RAW file\n" );
	  }
	  /* close the file 		    */
	  close( handle );
	  if( size_read == -1 )
				return(1);
	}
	else
	{
//		printf("Couldnt open file for reading\n");
		return(2);
	}
//	printf("Tape Size Read was %d raw bytes\n",size_read);

	cur_tape=0;
	cur_byte=0;
	prog_header=0;

	if(raw_tape==0)
	{
//		printf("Reading the Name Sync\n");
		synced=skipbits=0;
		do{
			cur_tape=0; //reset to start of tape
			synced=read_sync();
			if(synced!=sync_marker) synced=0;
			skipbits++;
		}while(!synced && skipbits<9);

		if(skipbits==9)
		{
//			printf(" *****   Couldn't Find the %02x Marker, try removing the sync zeroes   *******\n",sync_marker);
//			exit(-1);
			return(3);
		}
//		printf("Sync Ended at %u, Bitshift was %d, byte was %02x\n",cur_tape,skipbits-1,synced);
		
		//	buffer[cur_byte++]=ret;  //No, Mr. Bond, thow away this identify marker of a5 at start of tape
		ret=read_byte(0);
		buffer[cur_byte++]=ret;//Should be a ", but we'll check for the end one ;)
		
		//Read Filename
//		printf("\n\n");
//		printf("Filename: %c",ret);
		do
		{
			ret=read_byte(0);
			buffer[cur_byte++]=ret;
//			printf("%c",ret);
		}
		while(ret!='"' && cur_byte<30);
//		printf("\n\n");
		if (cur_byte==30)
		{
//			printf(" *****   Couldn't Get Recognizable Filename   *******\n");
			return(4);
		}
	}	
//	printf("Reading the Program Sync\n");
	prog_sync_savedpos=cur_tape;
	skipbits=skipbits=0;
	do{
		cur_tape=prog_sync_savedpos; //reset to start of sync
		synced=read_sync();
		if(synced!=sync_marker) synced=0;
		skipbits++;
	}while(!synced && skipbits<9);
	
	if(skipbits==9)
	{
//		printf(" *****   Couldn't Find the %02x Marker, try removing the sync zeroes   *******\n",sync_marker);
//		exit(-1);
		return(5);
	}
//	printf("Sync Ended at %u, Bitshift was %d, byte was %02x\n",cur_tape,skipbits-1,synced);

	prog_header=cur_byte;

//	buffer[cur_byte++]=ret; //First byte of the program :))
	prog_header=cur_byte;
	//Read Program
	while(cur_tape<size_read)
	{
		ret=read_byte(0);
		buffer[cur_byte++]=ret;
		last_byte_pos=cur_tape;
		if(cur_byte %1000==0)printf(".");
	}


	file_id=buffer[prog_header];
//	if(file_id==TAP_BASIC)
//		printf("BASIC Program Found\n");
//	else if(file_id==TAP_BINARY)
//		printf("Binary MLOAD Program Found\n");
//	else if(file_id==TAP_DATA)
//		printf("Level9 Data Found\n");


	//WHAT IS THIS EXTRA number in the header of power blaster
	//ITS A CRC checksum - ya fule
	//	if(buffer[cur_byte-1]==0xa5)
//		prog_header++;

//	cur_byte=buffer[prog_header+1]+256*buffer[prog_header+2];//tap length
	cur_byte--;

//	printf("\nGot %u Bytes, last byte at position %u\n",cur_byte,last_byte_pos);

	

//	if(raw_tape<2)
//	{
//		printf("Header Bytes:");
//		for(f=0;f<10;f++)
//			printf("%02x ",buffer[prog_header+f]);
//		printf("\n");
//		printf("Final Bytes:");
//		for(f=0;f<10;f++)
//			printf("%02x ",buffer[cur_byte-10+f]);
//		printf("\n");
		if(file_id==TAP_BINARY)
		{
			//find program header info - for Level 9 header - a5 41 <DEST> <LENGTH> xx ...
//			printf("Binary Start = %d (%04x)\n",buffer[prog_header+3]+256*buffer[prog_header+4],
//				buffer[prog_header+3]+256*buffer[prog_header+4]);
//			printf("Binary Length = %d (%04x)\n",buffer[prog_header+1]+256*buffer[prog_header+2],
//				buffer[prog_header+1]+256*buffer[prog_header+2]);
//			printf("Binary Execute = %d (%04x)\n",buffer[cur_byte-3]+256*buffer[cur_byte-2],
//				buffer[cur_byte-3]+256*buffer[cur_byte-2]);
		}
		else if(file_id==TAP_DATA)
		{
			//find program header info - for Level 9 header - a5 41 <DEST> <LENGTH> xx ...
//			printf("Binary Start = %d (%04x)\n",buffer[prog_header+1]+256*buffer[prog_header+2],
//				buffer[prog_header+1]+256*buffer[prog_header+2]);
//			printf("Binary Length = %d (%04x)\n",buffer[prog_header+3]+256*buffer[prog_header+4],
//				buffer[prog_header+3]+256*buffer[prog_header+4]);
//			printf("Binary End = %d (%04x)\n",buffer[prog_header+1]+256*buffer[prog_header+2]+buffer[prog_header+3]+256*buffer[prog_header+4],
//				buffer[prog_header+1]+256*buffer[prog_header+2]+buffer[prog_header+3]+256*buffer[prog_header+4]);
		}
		else
		{
			//find program header info
//			printf("Program Length = %d (%04x)\n",buffer[prog_header+1]+256*buffer[prog_header+2],
//				buffer[prog_header+1]+256*buffer[prog_header+2]);
//			printf("Program End = %d (%04x)\n",0x649d+buffer[prog_header+1]+256*buffer[prog_header+2],
//				0x649d+buffer[prog_header+1]+256*buffer[prog_header+2]);
//			printf("Program Execute = %d (%04x)\n",buffer[cur_byte-3]+256*buffer[cur_byte-2],
//				buffer[cur_byte-3]+256*buffer[cur_byte-2]);
		}
//	}

//	cur_byte++;//get back to noof bytes again, not pointer

	//got the bytes so save them to disk :)
    /* open a file for output		  */
//	printf("Writing TAP file\n");
    handle2 = open((char*) ofil,O_WRONLY | O_CREAT | O_TRUNC | O_BINARY,_S_IWRITE);
    if( handle2 != -1 )
	{
      size_written = write( handle2, buffer, cur_byte );
	  close( handle2 );
//		printf("Okay. %u bytes written\n",size_written);
	  return(0);
	}
	else
	{
//		printf(" :( Couldnt open TAP file for writing - dugh!\n");
		return(6);
	}
}
