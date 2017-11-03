
//PALE.H


#define LYNX_48 0
#define LYNX_96 1
#define LYNX_128 2
#define LYNX_96_DISK 3
#define LYNX_128_DISK 4
#define LYNX_USER3 5
#define LYNX_USER4 6

#define LYNX_HARDWARE_48 0
#define LYNX_HARDWARE_96 1
#define LYNX_HARDWARE_128 2
#define LYNX_HARDWARE_192 3
#define LYNX_HARDWARE_256 4
#define LYNX_HARDWARE_HACKSPECCY 5
#define LYNX_HARDWARE_JASPER 6


#define LYNX_SPEED_START 14000  //00

#define TAP_BASIC	0x42
#define TAP_BINARY	0x4d   //Lynx Binary format
#define TAP_DATA	0x41 //Level 9 Data


extern unsigned char video_latch;//=0xff;
extern unsigned char port84;//=0x00;
int  load_lynx_sounds();

extern  unsigned char show_bank2;
extern  unsigned char show_bank3;
extern unsigned char show_alt_green;

extern boolean cursor_on;
extern int machine_type;
extern int hw_type;
extern int emu_speed;
extern  int  _stdcall  run_emulator();
void reset_puter();

extern unsigned int cpm_fix;

