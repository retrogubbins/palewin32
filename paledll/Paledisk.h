

//#define HEADS_PER_DISK 1		//change this to 2 FOR 400k DOUBLE SIDE DISK
//#define TRACKS_PER_DISK 40
//#define HEADS_PER_DISK 2
//#define TRACKS_PER_DISK 80
#define SECT_PER_TRACK 10
#define BYTES_PER_SECT 512
//#define BYTES_PER_TRACK BYTES_PER_SECT*SECT_PER_TRACK*2
#define BYTES_PER_TRACK 6040
//#define BYTES_PER_TRACK BYTES_PER_SECT*SECT_PER_TRACK


//There are 604 bytes in each (physical) sector - 512 data rest ID numbers
//A track is 6040 bytes long

//2x  to fit in DSK images

//#define LYNX_DISK_SIZE HEADS_PER_DISK*BYTES_PER_SECT*SECT_PER_TRACK*TRACKS_PER_DISK
//#define LYNX_MAX_DISK_SIZE 800*1024
#define LYNX_MAX_DISK_SIZE BYTES_PER_TRACK*80*2	//800k is 2 heads of 80 tracks

#define LYNX_FDD_RAW_IMAGE 0
#define LYNX_FDD_DSK_IMAGE 1
#define LYNX_FDD_REAL 2

#define BADDRIVE 0
#define DRIVE200K 40
#define DRIVE800K 80
#define NOOF_DRIVES 2

void reset_disk_stuff();
void kill_disk(int);

void clear_track_buf();
void clear_sect_buf();
void do_disk_command();
void init_diskstuff();
void open_working_disk(int);
//extern byte disk0[LYNX_DISK_SIZE];
extern int disk_options;
extern byte disk_comreg;	
extern char disk_trackreg[NOOF_DRIVES];	
extern byte disk_sectreg;	
extern byte disk_statusreg;	
extern byte disk_datareg;	
extern int disk_datap;
extern int disk_head;
extern byte disk_motor;
extern byte disk_precomp;
extern byte disk_step125;
extern byte disk_drive;
extern int disk_trace_on;
extern int disk_track_buf_ptr;
extern FILE *stream_disk_trace;
extern char disk_sect_buf[BYTES_PER_SECT];
extern char disk_track_buf[BYTES_PER_TRACK];

extern int disk_sect_buf_ptr;

//void setup_disk_geometry();
void setup_disk_geometry(int driveno,int dsize);

void	create_dummy_disk(int);
void	do_disk_updates();	//if a command is pending then do it

//extern DSK_PDRIVER *drives;
//extern DSK_PDRIVER phys_disk1;
extern DSK_GEOMETRY dgeom[NOOF_DRIVES];
//extern DSK_FORMAT disk_format;
extern char disk_drive_to_write;

extern char disk_sect_to_write;
extern char disk_head_to_write;
extern char disk_track_to_write;
extern  int  _declspec(dllexport) stop_disk_trace();
