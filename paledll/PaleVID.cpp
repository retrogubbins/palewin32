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

byte CRTC_reg[18];
 int vid_mode=0;

 int this_clock_time=0;
 int last_clock_time=0;
 int last_clock_time_diff=0;
 int clock_time_diff=0;
int show_bank3_video=0;

int fix_cpm=1;


void clearcrtc()
{

	for(int f=0;f<18;f++)
		CRTC_reg[f]=0;

	if(hw_type==LYNX_HARDWARE_HACKSPECCY)  //if(speccy==1)
	{
		CRTC_reg[0]=31;//horiz tot & disp
		CRTC_reg[1]=32;
		CRTC_reg[4]=0x40;//vert tot & disp
		CRTC_reg[6]=40;
		CRTC_reg[4]=191;//vert tot & disp
//		CRTC_reg[6]=192;
		CRTC_reg[6]=0x80;

//		CRTC_reg[9]=4;
		CRTC_reg[9]=1;
	}

}


//	unsigned char pixmap[32][192];
//	unsigned char attrmap[32][24];

/* Calculate Y coordinate (0-192) from Spectrum screen memory location */
int calcY(int offset){
	return ((offset>>11)<<6)				// sector start
	     +((offset%2048)>>8)				// pixel rows
	     +((((offset%2048)>>5)-((offset%2048)>>8<<3))<<3);	// character rows
}

/* Calculate X coordinate (0-255) from Spectrum screen memory location */
int calcX(int offset){
	return (offset%32)<<3;
//	return (offset%32)<<3;
}


int calcOffset(int x,int y){
		//speccy screen made up of three blocks of 2048 bytes plus 768 bytes for the colour attrib
	//screen starts at 16384 (4000h) and attributes ?
	//within each block memory layout is 
	//0-31 bytes = top line of top char row
	//32-63   = top line of 2nd char row
	//etc.
	//until 8*32=256bytes
	//256-?  = 2nd line of top char row
	//etc.
	//so start  of 1st block is at 16384 4000h
	//2nd blok at 4800h
	//3rd blok at 5000h
	//attribs? at 5800h ???
	int base;
	if(y<64)
	{
		base=0x0;


	}
	else
	if(y<128)
	{
		base=0x800;

	}
	else
	{
		base=0x1000;



	}


	return (44);
}



extern  int  _stdcall  get_video_scanvers(void *winhdc,
										  int dest_width,
										  int dest_height,
										  tagBITMAPINFO *bmibuf,
										  char fix_6845,
										  unsigned char vbcrtc_regs[])
{
	unsigned int bbase,f,ff,g,h,i,j,byte_offset,start_offset,y_position_pixels,source_width;
	unsigned char b1,b2,b3,b1s,b2s,b3s,shifter;
	unsigned int vidsize,vid_start,v2;
	int ret,hor_disp_pix,hor_disp_bytes,vrt_disp_pix,line,vrt_disp_6845pixperchar,vrt_disp_chars;
	static int do_it=0;
	static int drawn,goat=0;
	static int line_required=0,sync_width,vert_sync_pos;
	float dest_1pix_height;
	unsigned char color_attrib,pixel_map,zx_fore_color,zx_back_color;
	int zx_vidcalc;
	//If in CPU access then dont update the screen
	//EXCEPT when Line blanking Monostabe is on (to fix Level 9) (unfortunately tyhis breaks the rest with flickering !gnaaar
	//if((video_latch & 0x60)==0x20) return(0);//	If we're in CPU access then dont update the screen
	//	if((video_latch & 0x20)==0x20) return(0);//	If we're in CPU access then dont update the screen
	//BIG BODGE FOR LEVEL9
	//test if both CASette bits are high - symptomatic of level 9 command mode IF SO THEN UPDATE THE SCREEN
	//	if((video_latch & 0x23)==0x20) return(0);//	If we're in CPU access then dont update the screen
	//standard
	
	
	
	drawn=0;
	
	//Copy CRTC regs to VB application
	for(f=0;f<18;f++)
		vbcrtc_regs[f]=CRTC_reg[f];


//	if(vid_mode==0 || line_required==0)
//	{
		//get the time taken for the loop here
//		this_clock_time=clock();
//		clock_time_diff=this_clock_time-last_clock_time;
//		if (clock_time_diff>10000)//we've rolled over on the clock counter
//			clock_time_diff=last_clock_time_diff;//just use the previous value
//		last_clock_time_diff=clock_time_diff;
//		last_clock_time=this_clock_time;
		//Ok, we've got a measure of the time for the loop in milliseconds
		//now delay here until the correct noof miliisecs per frame is correct
		//for 50hz update rate each frame should take
		//20ms
//		if (clock_time_diff<15)
//			sleep(15-clock_time_diff);	
//			sleep(10-clock_time_diff);	
//		if (clock_time_diff>20)
//		{
//			sleep(200);
//			goto skip_vid;
//		}
//	}

//if((video_latch & 0x20)==0x20) goto skip_vid;//	If we're in CPU access then dont update the screen

	
	if((vid_mode==0) && ((video_latch & 0x22)==0x20)) goto skip_vid;//	If we're in CPU access then dont update the screen

//if(speccy==1)CRTC_reg[1]=26+bank0[0];//horiz tot & disp

	hor_disp_bytes=CRTC_reg[1];
	if(hor_disp_bytes>64)hor_disp_bytes=64;
	if(hor_disp_bytes<2)hor_disp_bytes=2;
	hor_disp_pix=hor_disp_bytes*8;
	//32*8 = 256 for 4896   512 for 128
	vrt_disp_6845pixperchar=CRTC_reg[9]+1;	//usually 3+1 = 4
	vrt_disp_chars=CRTC_reg[6];  //usually 3f, 40 in Pengo
	vrt_disp_pix=vrt_disp_chars*vrt_disp_6845pixperchar;
	//4000h for 128, 2000h for 48/96
	vidsize=hor_disp_bytes*vrt_disp_pix; //0x4000; horiz tot * (vert total*(char rast count +1))
	vid_start=(CRTC_reg[12]*256+CRTC_reg[13])*4 ;//0000 for 48/96  4000h for 128

	if(hw_type==LYNX_HARDWARE_HACKSPECCY)  //speccy==1)
	{
		for(g=0;g<192;g++)
		{
			for(ff=0;ff<32;ff++)	//foreach byte in line
			{
				byte_offset=g*32+ff;//*2+1;
				//spectrum attributes
				//bit	7	6		5	4	3		2	1	0
				//		F	B		P	A	P		I	N	K
				color_attrib=bank0[0x5800+(calcY(byte_offset)/8)*32+ff];//get 1 of 768 attrib values
				pixel_map=bank0[0x4000+byte_offset];
				zx_fore_color=color_attrib & 0x07;
				zx_back_color=(color_attrib & 0x38)>>3;

				for(i=0;i<8;i++)	//foreach pixel within a byte
				{
						zx_vidcalc=calcY(byte_offset)*256+ff*8+i;
						if((pixel_map & (0x80>>i))!=0)
							vid_mem[zx_vidcalc]=zx_fore_color;
						else
							vid_mem[zx_vidcalc]=zx_back_color;
							
				}
			}
		}
		ret=StretchDIBits (winhdc,
				0,
				dest_height ,
				dest_width,
				-dest_height ,
				0,
				0,
				256,
				192,
				vid_mem,
				bmibuf,
				DIB_RGB_COLORS, SRCCOPY);
	}

	else
	
	if(vid_mode==0)		//Fast video mode - one whole screen blit
	{
		vid_start=(CRTC_reg[12]*256+CRTC_reg[13])*4 ;//0000 for 48/96  4000h for 128
		g=0;
		for(f=0;f<vidsize;f++)
		{
			if(hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
			{
				byte_offset=vid_start+f;							//128 192 256  WHOLE SCREEN
				
				//important for CPM
				byte_offset=byte_offset%0x4000;
				
				//quick HACK
				if(show_bank3_video==1)
				{
					b1=bank3[0x4000+byte_offset];  //blue		256K mode
					b2=bank3[byte_offset]; //red
				}
				else
				if(show_bank2==1 || fix_6845)
		//		if(1)
				{
					b1=bank2[0x4000+byte_offset];  //blue		128K mode
					b2=bank2[0x0000+byte_offset]; //red
				}
				else
					b1=b2=0;
				if(show_bank3==1 || fix_6845)	//NOTE BANK3 here
		//		if(show_bank3==1 || fix_6845)
		//		if(1)
				{
					if(show_alt_green==1)
						b3=bank2[0xc000+byte_offset];
					else
//						b3=bank2[0x8000+byte_offset]; //green
						b3=bank2[0x8000+byte_offset]; //green
				}
				else
					b3=0;

//				if((fix_cpm==1) && (vid_start>0x00))
//				{
//					b1=b2=0;
//					b3=bank2[0x4000+byte_offset] | bank2[0x8000+byte_offset]; //get green from blue bank
//				}

			}
			else
			{
				//Need to now map the mirrors in for the 48/96 video
				//memory, its already done in WR & RD MEM but also needs to be done here to emu the 6845 corectly ;)
				vid_start=vid_start%0x2000;
				byte_offset=vid_start+f;
				if(show_bank2==1 || fix_6845)						// 48  96 WHOLE SCREEN
				{
					if (byte_offset>0x1fff)
					{
						b1=bank2[0x8000+byte_offset];  //blue mirror
						b2=bank2[0xa000+byte_offset];  //red mirror
					}
					else
					{
						b1=bank2[0xa000+byte_offset];  //blue
						b2=bank2[0xc000+byte_offset]; //red
					}
				}
				else
					b1=b2=0;
				if(show_bank3==1 || fix_6845)
				{
					if (byte_offset>0x1fff)
					{
						if(show_alt_green==1)
							b3=bank3[0x8000+byte_offset];	//alt green mirror
						else
							b3=bank3[0xa000+byte_offset];  //green mirror
					}
					else
					{
						if(show_alt_green==1)
							b3=bank3[0xa000+byte_offset]; //alt green
						else
							b3=bank3[0xc000+byte_offset];	//green
					}
				}
				else
					b3=0;

			
			}


			for(h=0;h<8;h++)
			{
				b1s=b2s=b3s=0;
				shifter=(0x80>>h);
				if((b1 & shifter) !=0)b1s=1;
				if((b2 & shifter) !=0)b2s=1;
				if((b3 & shifter) !=0)b3s=1;
				//if((video_latch & 0x20)!=0x20) 

				//Orig
				vid_mem[g++]=(b3s<<2) + (b2s<<1) + b1s;
				//vid_mem[(f*8)+h]=(b3s<<2) + (b2s<<1) + b1s;
			}
		}

		
		
		
		ret=StretchDIBits (winhdc,
				0,
				dest_height ,
				dest_width,
				-dest_height ,
				0,
				0,
				hor_disp_pix,
				vrt_disp_pix,
				vid_mem,
				bmibuf,
				DIB_RGB_COLORS, SRCCOPY);


	}
	else
	{
		// SCANLINE PERFECT
		// SCANLINE PERFECT
		// SCANLINE PERFECT
		// SCANLINE PERFECT
		if (vrt_disp_pix<10)vrt_disp_pix=10;
		if(dest_height<vrt_disp_pix)dest_height=vrt_disp_pix+1;
		dest_1pix_height=(float) dest_height /(float)vrt_disp_pix;
		//256 for 4896   512 for 128
		y_position_pixels=0;
		line=line_required; //-1;
		if(hw_type==LYNX_HARDWARE_128 || hw_type==LYNX_HARDWARE_192 || hw_type==LYNX_HARDWARE_256)
		{
			start_offset=vid_start+(line*hor_disp_bytes);	//this is a CRTC register pete
			start_offset=start_offset%0x4000;
			for(f=0;f<hor_disp_bytes;f++)
			{
				if(show_bank2==1 || fix_6845)					//128 192 256  SCANLINE
				{
					b1=bank2[0x4000+start_offset+f];  //blue
					b2=bank2[start_offset+f]; //red
				}
				else
					b1=b2=0;
				if(show_bank3==1 || fix_6845)
				{
					if(show_alt_green==1)
						b3=bank2[0xc000+start_offset+f];
					else
						b3=bank2[0x8000+start_offset+f]; //green
				}
				else
					b3=0;
				for(h=0;h<8;h++)
				{
					b1s=b2s=b3s=0;
					shifter=(0x80>>h);
					if((b1 & shifter) !=0)b1s=1;
					if((b2 & shifter) !=0)b2s=1;
					if((b3 & shifter) !=0)b3s=1;
					//vid_mem[g++]=(b3s<<2) + (b2s<<1) + b1s;
					vid_mem[(f*8)+h]=(b3s<<2) + (b2s<<1) + b1s;
				}
				//				return(1);
			}		
			//ret=StretchDIBits (hdc, 0, (hw / (CRTC_reg(6) * (CRTC_reg(9) + 1))) * line_req, w, (hw / (CRTC_reg(6) * (CRTC_reg(9) + 1))), 0, 0, CRTC_reg(1) * 8, 1, gcBufferBits(0), bmiBuffer, DIB_RGB_COLORS, SRCCOPY);
			y_position_pixels=(dest_1pix_height*((float)line));
			if (CRTC_reg[3]>0x37)
				sync_width=(CRTC_reg[3]-0x37)/4;
			else
				sync_width=0;
			if (CRTC_reg[6]>0x3f)
				vert_sync_pos=(CRTC_reg[6]-0x3f)/4;
			else
				vert_sync_pos=0;
			do 
			{
				ret=StretchDIBits (winhdc,
							sync_width,
							y_position_pixels+vert_sync_pos ,
							dest_width,
							-dest_1pix_height ,
							0,
							0,
							hor_disp_pix,
							1,
							vid_mem,
							bmibuf,
							DIB_RGB_COLORS, SRCCOPY);
				y_position_pixels+=dest_1pix_height;
			}while( y_position_pixels<(dest_1pix_height*((float)line+1)));
		}
		else
		{
			//Need to now map the mirrors in for the 48/96 video
			//memory, its already done in WR & RD MEM but also needs to be done here to emu the 6845 corectly ;)
			vid_start=vid_start%0x2000;
			//	start_offset=vid_start+(line_req*32);
			start_offset=vid_start+(line*hor_disp_bytes);			//  48 96  SCANLINE
			for(f=0;f<hor_disp_bytes;f++)
			{
				if(show_bank2==1 || fix_6845)
				{
					if (start_offset+f>0x1fff)
					{
						b1=bank2[0x8000+start_offset+f];  //blue mirror
						b2=bank2[0xa000+start_offset+f];  //red mirror
					}
					else
					{
						b1=bank2[0xa000+start_offset+f];  //blue
						b2=bank2[0xc000+start_offset+f]; //red
					}
				}
				else
					b1=b2=0;
				if(show_bank3==1 || fix_6845)
				{
					if (start_offset+f>0x1fff)
					{
						if(show_alt_green==1)
							b3=bank3[0x8000+start_offset+f];	//alt green mirror
						else
							b3=bank3[0xa000+start_offset+f];  //green mirror
					}
					else
					{
						if(show_alt_green==1)
							b3=bank3[0xa000+start_offset+f]; //alt green
						else
							b3=bank3[0xc000+start_offset+f];	//green
					}
				}
				else
					b3=0;
				for(h=0;h<8;h++)
				{
					b1s=b2s=b3s=0;
					shifter=(0x80>>h);
					if((b1 & shifter) !=0)b1s=1;
					if((b2 & shifter) !=0)b2s=1;
					if((b3 & shifter) !=0)b3s=1;
					vid_mem[(f*8)+h]=(b3s<<2) + (b2s<<1) + b1s;
				}
			}
			y_position_pixels=(dest_1pix_height*((float)line));
			if (CRTC_reg[3]>0x33)
				sync_width=(CRTC_reg[3]-0x33)/4;
			else
				sync_width=0;

			if (CRTC_reg[6]>0x3f)
				vert_sync_pos=(CRTC_reg[6]-0x3f)/4;
			else
				vert_sync_pos=0;
			do 
			{
				ret=StretchDIBits (winhdc,
						sync_width,
						y_position_pixels+vert_sync_pos ,
						dest_width,
						-dest_1pix_height ,
						0,
						0,
						hor_disp_pix,
						1,
						vid_mem,
						bmibuf,
						DIB_RGB_COLORS, SRCCOPY);
				y_position_pixels+=dest_1pix_height;
			}while( y_position_pixels<(dest_1pix_height*((float)line+1)));
		}
	}

drawn=1;  //tells VB that we arent in vert blank time




skip_vid:

	
	line_required++;
	if(line_required>=vrt_disp_pix)
	{
		line_required=0; //(line_required+1);
		if((vid_mode==1)) start_im1_irq=1;
	}


//	if(cursor_on==1 && (vid_mode==0 || line_required==0))
//	if(vid_mode==1 && cursor_on==1 && line_required==0)

//if(hw_type==LYNX_HARDWARE_HACKSPECCY)  //speccy==1)
//{	
//	if((vid_mode==1) && (line_required==0))
//	{
	if((vid_mode==0))
		start_im1_irq=1;
			//	start_ss_nmi=1;
			//now run z80 cycles for the frame blank period
			//230us vertical retrace period
			//at 6MHZ = 1380 approox
			//lets say that equates to 1000 instructions for now
			//which at 100% speed is IPeirod 50K
			//so just run it once more here
			//but in Accurate mode which is what thi s is
			//Iperiod ilekly to be 200 or so  (on mine its 317)
			//hence...
//			ret=run_emulator();
//			start_im1_irq=0;
//	start_ss_nmi=0;
//	}
//}



	return(drawn);
}




extern  int  _stdcall  crtc_change()
{
	static unsigned char crtc_last[18];
	int f,change;
	// check crtc against last time this function was called, if there's a diff then return 1
	change=0;
	for(f=0;f<18;f++)
		if(CRTC_reg[f]!=crtc_last[f])change=1;
	return(change);
}



extern int _stdcall get_sysclock()
{
//   clock_t goal;
  // goal = wait + clock();
  // while( goal > clock() )
    //  ;

return(clock());
}

extern int _stdcall get_clock_time_diff()
{
//   clock_t goal;
  // goal = wait + clock();
  // while( goal > clock() )
    //  ;

return(clock_time_diff);
}



extern  int  _stdcall  query_6845(unsigned char emu_query[],unsigned char emu_query2[],unsigned char emu_query3[],unsigned char emu_query4[])
{
	int ret,f,g;

	//Query the CRTC registers
	sprintf((char*)emu_query3,"H TOT: %02x H DISP: %02x HS Pos: %02x HS Wid: %02x V TOT: %02x VT Adj: %02x V Disp: %02x VS Pos: %02x",
		CRTC_reg[0],
		CRTC_reg[1],
		CRTC_reg[2],
		CRTC_reg[3],
		CRTC_reg[4],
		CRTC_reg[5],
		CRTC_reg[6],
		CRTC_reg[7]);
		sprintf((char*)emu_query4,"IntSkew: %02x MRastAddr: %02x CRS Start: %02x CRS End: %02x START: %04x CRS Addr: %04x LightP: %04x",
		CRTC_reg[8],
		CRTC_reg[9],
		CRTC_reg[10],
		CRTC_reg[11],
		CRTC_reg[12]*256+CRTC_reg[13],
		CRTC_reg[14]*256+CRTC_reg[15],
		CRTC_reg[16]*256+CRTC_reg[17]);
	return(0);
}


/*
int StretchDIBits(
  

    HDC  hdc,	// handle of device context 
    int  XDest,	// x-coordinate of upper-left corner of dest. rect. 
    int  YDest,	// y-coordinate of upper-left corner of dest. rect. 
    int  nDestWidth,	// width of destination rectangle 
    int  nDestHeight,	// height of destination rectangle 
    int  XSrc,	// x-coordinate of upper-left corner of source rect. 
    int  YSrc,	// y-coordinate of upper-left corner of source rect. 
    int  nSrcWidth,	// width of source rectangle 
    int  nSrcHeight,	// height of source rectangle 
    CONST VOID * lpBits,	// address of bitmap bits 
    CONST BITMAPINFO *  lpBitsInfo,	// address of bitmap data 
    UINT  iUsage,	// usage 
    DWORD  dwRop 	// raster operation code 
   );
*/

//

/*
extern  int  _stdcall  get_video_scanvers(unsigned char vid_mem[],
										  HDC winhdc,
										  unsigned int dest_width,
										  unsigned int dest_height,
										  unsigned int line_req,
										  tagBITMAPINFO *bmibuf,
										  unsigned int fix_6845,
										  unsigned char vbcrtc_regs[])
*/

//extern  int  _stdcall  run_C_emu(void *anhdc,int  w,int  h, tagBITMAPINFO *bmiBuffer)
//{
//roms should be loaded by now

//}





