#define LYNX_MAXPORTS 65536


extern byte z80ports_in[LYNX_MAXPORTS];
extern byte z80ports_out[LYNX_MAXPORTS];
extern int ip_port;
extern unsigned char bank_latch;//=0xff;
extern unsigned char video_latch;//=0xff;
extern unsigned char port84;//=0x00;

extern byte speccy_port_in;
extern byte speccy_port_out;

extern int start_im1_irq;
extern int start_ss_nmi;
extern int break_nmi;
extern unsigned char show_bank2;
extern unsigned char show_bank3;
extern unsigned char show_alt_green;

void Z80_Patch (Z80_Regs *Regs);
int Z80_Interrupt(void);
void Z80_Reti (void);
void Z80_Retn (void);


void Z80_Out (dword Port,byte Value);
byte Z80_In (dword Port);
void clearports();
void set_banklatch(unsigned char yg);

