extern int snd_play;				//set from a trap within the z80 OUT routine
extern int soundmem_head;
extern int soundmem_tail;
extern byte sound_linbuf[];
extern byte soundmem[];//4 secs of sound !! overkill

#define LYNX_SNDMEM 22050 //1 sec sound buffer
//extern HWAVEOUT hWaveOut; // device handle 
//void writeAudio(HWAVEOUT , LPSTR , int );
void do_sound(byte snd[],unsigned int len);
void wait_sound_complete();