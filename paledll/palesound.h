//PALESOUND.H




void mySoundProc(void *pSoundBuffer,long bufferLen);
void update_sound();
void init_sound();
void kill_sound();
extern unsigned int sound_ptr_a;
extern unsigned int sound_ptr_b;
extern unsigned int sound_blen;
extern unsigned int backsnd_volume;
extern unsigned int back_sndlen;
extern unsigned char back_sound[65536];//lynxbackground sounds :)
extern  unsigned char ret_sound[65536];//lynx return key sounds :) loaded from RAW files
extern  unsigned int back_sndlen;
extern unsigned int ret_sndlen;
extern  unsigned int sound_div_in;
int load_lynx_sounds();
