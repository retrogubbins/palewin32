
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
#include "SoundServer.h"

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

#define LYNX_SNDMEM 4000
signed short sound_linbuf[LYNX_SNDMEM];
signed short sound_linbuf2[LYNX_SNDMEM];
unsigned long soundtim_last=0;	//used to count cpu cycles for sound delays
unsigned char enable_soundstream=1;			//enables the regularly flushed type of sound ie: non basic
unsigned int sound_length=0;

unsigned char back_sound[65536];//lynxbackground sounds :)
unsigned char ret_sound[65536];//lynx return key sounds :) loaded from RAW files
unsigned int back_sndlen=0;
unsigned int ret_sndlen=0;
unsigned int sound_div_in=16;
unsigned int back_snd_ptr=0;
unsigned int backsnd_volume=0;
unsigned int sound_ptr_a=0;
unsigned int sound_ptr_b=0;

unsigned int sound_blen=0;

static CSoundServer *pServer = new CSoundServer;


void	mySoundProc(void *pSoundBuffer,long bufferLen)
{
		// Convert params, assuming we create a 16bits, mono waveform.
		signed short *pSample = (signed short*)pSoundBuffer;
		long	nbSample = bufferLen / sizeof(signed short);

		sound_blen=nbSample;
		
	//	if(sound_blen<100)return;

		for (int i=0;i<nbSample;i++)
		{
		//	for(int j=0;j<SND_EXPANDER_OUT;j++)
				*pSample++ = sound_linbuf[sound_ptr_b]*512;

			sound_ptr_b=(sound_ptr_b+1)%LYNX_SNDMEM;
			if(sound_ptr_b==sound_ptr_a)					//'STOP THE CIRC BUFFER IF SOUND OUT TOO SLOW
				sound_ptr_b=(sound_ptr_b-1)%LYNX_SNDMEM;	//'CHECK THIS
			//				else
			//					sound_linbuf[i]=0;
		}
		//sound_ptr=0;
}



 
void update_sound()
{
	static unsigned int divi=0;
	static unsigned int divi2=0;
	static unsigned int i;
	unsigned char hum=0;
	//6MHz / 22050 samples/sec = approx 272

		//	if(emu_running==0)return;
		//	if ((video_latch & 0x01)==0x01)
		//	else
	//		sound_linbuf[sound_ptr]=32;
	if (backsnd_volume>0 && (video_latch & 0x01)==0x00)
	{
		if(back_sndlen>0)
		{
			if((video_latch & 0x20)==0x20)//arbitrary choice, adds a bit of excitement :)
			{
				hum=ret_sound[back_snd_ptr]*backsnd_volume;
				if (divi2++==sound_div_in)
				{
					divi2=0;
					back_snd_ptr++;
					if(back_snd_ptr>back_sndlen)
						back_snd_ptr=0;
				}
			}
			else
			{
				//introduce some background noise into the equation heh
				hum=back_sound[back_snd_ptr]*backsnd_volume;
				if (divi2++==sound_div_in)
				{
					divi2=0;
					back_snd_ptr++;
					if(back_snd_ptr>back_sndlen)
						back_snd_ptr=0;
				}
			}
		}
	}

	sound_linbuf[sound_ptr_a]=port84+hum;//+tape_level;

	if(hw_type==LYNX_HARDWARE_HACKSPECCY) //if(speccy==1)
//		sound_linbuf[sound_ptr_a]=(speccy_port_in & 0x10)*2+(speccy_port_out & 0x20)*2+hum;//+tape_level;
		sound_linbuf[sound_ptr_a]=speccy_port_out+hum;
	



	//		sound_linbuf[sound_ptr]=0;
	if (divi++==sound_div_in)
	{
		divi=0;
		sound_ptr_a=(sound_ptr_a+1)%LYNX_SNDMEM;
		if(sound_ptr_a==sound_ptr_b)					//'STOP THE CIRC BUFFER IF SOUND OUT TOO SLOW
			sound_ptr_a=(sound_ptr_a-1)%LYNX_SNDMEM;	//'CHECK THIS
		//		if(sound_ptr>LYNX_SNDMEM)
//			sound_ptr=0;
	}
	
	//			sound_linbuf[sound_ptr++]=sound_ptr;
//				if(sound_ptr>LYNX_SNDMEM)
	
}

extern  int  _stdcall  flush_sound()
{
//	int f;
return(1);
	//NEEDS LOCKING
//		for(f=0;f<sound_ptr;f++)
//			sound_linbuf2[f]=sound_linbuf[f];
//		sound_ptr2=sound_ptr;
//		sound_ptr=0;
//	return(1);
}


void init_sound()
{
	unsigned int t=0;
	unsigned int divi2,f;

	//NOTE MUST HAVE lOADEd DeFAlTs AND SOUND RAWS B4 HERE

	sound_ptr_a=0;
	sound_ptr_b=0;

	t=pServer->open(mySoundProc);
	set_sound_running(t);
	load_lynx_sounds();

	//Preload the linear buffer with some suitable sound
	if (backsnd_volume>0)
	{
		if(back_sndlen>0)
		{
			back_snd_ptr=0;
			divi2=0;
			for(f=0;f<LYNX_SNDMEM;f++)
			{
				sound_linbuf[f]=back_sound[back_snd_ptr]*backsnd_volume;
				if (divi2++==sound_div_in)
				{
					divi2=0;
					back_snd_ptr++;
					if(back_snd_ptr>back_sndlen)
						back_snd_ptr=0;
				}
			}
		}
		else
		{
			for(f=0;f<LYNX_SNDMEM;f++)
				sound_linbuf[f]=0;
		}
	}
	else
	{
		for(f=0;f<LYNX_SNDMEM;f++)
			sound_linbuf[f]=0;
	}
//	sound_ptr=0;
}

void kill_sound()
{
	if(get_sound_running()==1)
	{
	//	pServer->close();
	//	delete pServer;
	}
}


extern  int  _stdcall  query_sound(unsigned char emu_query[],unsigned char emu_query2[],unsigned char emu_query3[],unsigned char emu_query4[])
{
	int ret,f,g;

	//Query the Sound Driver
	sprintf((char*)emu_query3,"SPTRA: %d SPTRB: %d BLEN: %d",
		sound_ptr_a,
		sound_ptr_b,
		sound_blen);
	return(0);
}
extern  int _stdcall  set_hum(byte  frf)
{
	backsnd_volume=frf;
	return(0);
}

int load_lynx_sounds()
{
	int  handle,handle2;
	int  size_read,ret;
	int cdd,f;
	static char soundpath[_MAX_PATH];
	static int first_time=0;

   /* Get the current working directory: */
	if(first_time==0)
	{
		first_time=1;
		_getcwd( soundpath, _MAX_PATH );//save the workign diretory first time as the ROM path
	}
		_chdir(soundpath);   

	back_sndlen=0;

	handle=open( "lynxback.raw", O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, back_sound,
			sizeof( back_sound ) );
	  close( handle );
	  if( size_read == -1 )
	  {
//				ret=MessageBox(NULL,":( Couldn't open the sound files","PALE LynxSounds Load",MB_YESNO | MB_DEFBUTTON1);
				return(0);
	  }
	}
	else
	{
//		ret=MessageBox(NULL,":( Couldn't open the sound files","PALE LynxSOundsLoad",MB_YESNO | MB_DEFBUTTON1);
		return(0);
	}
	back_sndlen=size_read;
	handle=open( "lynxret.raw", O_RDONLY | O_BINARY );
	if( handle != -1 )
	{
	  size_read = read( handle, ret_sound,
			sizeof( ret_sound ) );
	  close( handle );
	  if( size_read == -1 )
	  {
//				ret=MessageBox(NULL,":( Couldn't open the RET sound files","PALE LynxSounds Load",MB_YESNO | MB_DEFBUTTON1);
				return(0);
	  }
	}
	else
	{
//		ret=MessageBox(NULL,":( Couldn't open the RET sound file","PALE LynxSOundsLoad",MB_YESNO | MB_DEFBUTTON1);
		return(0);
	}
	ret_sndlen=size_read;
	return(1);
}


/*

//-----------------------------------------------------------------------------
// Your sound server call back !
// Call what you want here !! An MP3 decoder, a classic MOD player
// or the YM-Engine lirary ! :-)
//
// For that test purpose, our rout computes a classic 440Hz sin wave.
//-----------------------------------------------------------------------------
void	mySoundProc(void *pSoundBuffer,long bufferLen)
{

		// Convert params, assuming we create a 16bits, mono waveform.
		signed short *pSample = (signed short*)pSoundBuffer;
		long	nbSample = bufferLen / sizeof(signed short);

		for (int i=0;i<nbSample;i++)
		{
			*pSample++ = (signed short)(16384.f));
//			*pSample++ = (signed short)(16384.f * sin(sinPos));
//			sinPos += SIN_STEP;
		}
//		if (sinPos >= TWO_PI) sinPos -= TWO_PI;
}



LRESULT CALLBACK WndProc(HWND hWnd, UINT message, WPARAM wParam, LPARAM lParam)
{

	switch (message) 
	{
		case WM_DESTROY:
			PostQuitMessage(0);
			break;

		default:
			return DefWindowProc(hWnd, message, wParam, lParam);
   }
   return 0;
}


void Init_sound()
{
		// Init our SoundServer
//#if USE_DIRECTSOUND
//			CDXSoundServer *pServer = new CDXSoundServer(hWnd);
//#else
			CSoundServer *pServer = new CSoundServer;
//#endif
}



void kill_sound()
{
			delete pServer;


}




*/



