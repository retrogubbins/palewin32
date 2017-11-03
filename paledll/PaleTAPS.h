

extern int file_id; //type offile loaded
extern int level9;
void save_lynx_tap();
extern unsigned char tape_level;
void set_t_mode(int ff);
void update_tape();

extern unsigned int tape_spd;
extern int tape_spd_adjust;
extern unsigned char tape_operation;
 
extern unsigned char raw_threshold;

#define LYNX_MAX_RAW 32000000

#define TAP_TAPES 0
#define RAW_TAPES 1

//extern unsigned char raw_tape[LYNX_MAX_RAW];
extern unsigned char *raw_tape;
extern unsigned int raw_position;
extern unsigned int raw_play;
extern unsigned int raw_rec;
extern unsigned int raw_samples;
extern unsigned int raw_motor;
extern unsigned int tape_mode;
extern void start_tape_record();
extern void start_tape_play();
extern void stop_tape();
extern void init_tapestuff();
#define TAPE_STOPPED 0
#define TAPE_PLAY 1
#define TAPE_RECORD 2