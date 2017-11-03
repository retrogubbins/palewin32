
#define PRINTER_BUFLEN 2048
extern byte printer_buffer[PRINTER_BUFLEN];
extern  int printer_tail;
extern  int printer_head;
extern  unsigned char printer_status;
extern   unsigned char printer_data;
extern unsigned int printer_type;
extern unsigned int printer_current_oport;
extern unsigned int printer_current_iport;
extern unsigned int printer_current_cport;

void init_the_printer();
void reset_printer();

#define PRINTER_TEXT 0
#define PRINTER_GRAFIX	1
#define PRINTER_REAL	2

#define PORT_LPT1 0x378
#define PORT_LPT2 0x278

extern int printer_locked;