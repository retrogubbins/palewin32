




extern  int  _stdcall  build_rom(unsigned char r0[],unsigned char r1[],unsigned char r2[],
								 unsigned char r3[],unsigned char r4[],unsigned char r5[],
								 unsigned char r6[],unsigned char r7[],unsigned char ropth[]);
int load_lynx_rom();
void patch_lynx_rom();

void create_dummy_rom();

extern unsigned char rompath[200];
