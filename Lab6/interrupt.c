// loop_intr.c loop program using interrupts
#include "DSK6713_AIC23.h"	        // codec support
#include "math.h"
#define DSK6713_AIC23_INPUT_MIC  0x0015
#define DSK6713_AIC23_INPUT_LINE 0x0011
#define PI 3.141592653589793


Uint16 inputsource=DSK6713_AIC23_INPUT_LINE; //  select input
Uint32 fs=DSK6713_AIC23_FREQ_8KHZ;	// set sampling rate
Uint32 Fs = 8000;
volatile Uint32 time = 0;

extern Uint32  fetchAIC23(void);
extern void    pushAIC23 (int);
extern void    initIRQ(void);

#define buffSize 5  // delay length
short bufferLeft  [buffSize]; //left delay line
short bufferRight [buffSize]; // right delay line
double h[5] = {-.125,.25,.75,.25,-.125};


int count = 0;

Uint32 stereo_tone(double fl, double fr){
	time++; //increment time
	Uint16 Out_L = (Uint16)((double)0x0FFF*(sin((double)time*fl/Fs*2*PI)+1)); //compute left output sine wave magnitude
	Uint16 Out_R = (Uint16)((double)0x0FFF*(sin((double)time*fr/Fs*2*PI)+1)); //compute right output sine wave magnitude
	Uint32 Out = (Out_L<<16)|(Out_R); //put left and right channel together
	return(Out);
}

interrupt void c_int11()         // interrupt service routine
{
	short	left, right;

	float	outputLeft  = 0.0,
			outputRight = 0.0;

	Uint32	stereo,
			stereoin,
			stereoout,
			stereoLeft,
			stereoRight;
	int i;

#if 0 // Problem 9 Simple Audio Loop
	stereoin = (Uint32) fetchAIC23(); // input data
	stereoout = stereoin; // set input data as output data
#endif

#if 0 // Problem 10  Sine Wave
	stereoout = stereo_tone(440,880); // generate sine wave
#endif

#if 1 // Problem 11 Prototypical Low pass filter
	stereoin = (Uint32) fetchAIC23(); // input data
	stereo   = stereoin;
	// pull left and right channel out of input data
	right    = (short) (stereo & 0X0000FFFF);
	stereo   = (Uint32) stereo >> 16;
	left     = (short) (stereo & 0x0000FFFF) ;

	// shift left and right buffers by 1
	for(i = 4;i>0;i--){
		bufferLeft[i] = bufferLeft[i-1];
		bufferRight[i] = bufferRight[i-1];
	}
	// add new sample to left and right buffers
	bufferLeft[0] = left;
	bufferRight[0] = right;

	// filter data
	for(i = 0;i<buffSize;i++){
		outputLeft = outputLeft + h[i]*bufferLeft[i];
		outputRight = outputRight + h[i]*bufferRight[i];
	}

	// output data
	stereoLeft  = (Uint32) outputLeft;
	stereoRight = (Uint32) outputRight;

	stereoLeft = (Uint32) (stereoLeft << 16);
	stereoLeft = (Uint32)  stereoLeft;
	stereoout = 0;
	stereoout = (Uint32) (stereoLeft & 0xFFFF0000)| (stereoRight & 0x0000FFFF);
#endif
	pushAIC23 (stereoout);   // output data

	return;
}


void main()
{
	int i;

	for (i=0;i<buffSize;i++)
	{
		bufferLeft [i] = 0;
		bufferRight [i] = 0;
	}

	initIRQ();                 // init DSK, codec, McBSP
	while(1);                	   // infinite loop
}

