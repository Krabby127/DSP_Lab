/*
 * main.c
 */
double a = .25;
int T = 22000; // fs*.5 secs
int buffer[22000];

#include "dsk6713.h"
#include "dsk6713_aic23.h"
#include "stdlib.h"
#include "math.h"


# if 0
// Codec configuration settings
DSK6713_AIC23_Config config = { \
    0x0017,  /* 0 DSK6713_AIC23_LEFTINVOL  Left line input channel volume: 0x0017 by default - 0db, 0x001F max - +12db */ \
    0x0017,  /* 1 DSK6713_AIC23_RIGHTINVOL Right line input channel volume: 0x0017 by default - 0db, 0x001F max - +12db */\
    0x01FF,  /* 2 DSK6713_AIC23_LEFTHPVOL  Left channel headphone volume: 0x01f9 by default - 0db , 0x01ff max - +6 db */  \
    0x01FF,  /* 3 DSK6713_AIC23_RIGHTHPVOL Right channel headphone volume: 0x01f9 by default - 0db , 0x01ff max - +6 db */ \
    0x0011,  /* 4 DSK6713_AIC23_ANAPATH    Analog audio path control */      \
    0x0000,  /* 5 DSK6713_AIC23_DIGPATH    Digital audio path control */     \
    0x0000,  /* 6 DSK6713_AIC23_POWERDOWN  Power down control */             \
    0x0043,  /* 7 DSK6713_AIC23_DIGIF      Digital audio interface format */ \
    0x0022,  /* 8 DSK6713_AIC23_SAMPLERATE Sample rate control, 0x0001 by default, 0x000d for 8khz,0x0099 for 16khz, 0x0019 for 32khz, 0x0022 for 44khz, 0x001c for 96khz */\
    0x0001   /* 9 DSK6713_AIC23_DIGACT     Digital interface activation */   \
};

#endif


# if 0
void main()
{
	DSK6713_AIC23_CodecHandle hCodec;
	Int16 OUT_L, OUT_R;
	Uint32 stereo;

	// Initialize BSL
	DSK6713_init();

	//Start codec
	hCodec = DSK6713_AIC23_openCodec(0, &config);

	// Set  frequency to 48KHz
	DSK6713_AIC23_setFreq(hCodec, DSK6713_AIC23_FREQ_48KHZ);
	while( i <=T ){
		buffer[i] = 0;
		i++;
	}
	i = 0;
	for(;;)
	{
		// Read sample from the left channel
		while (!DSK6713_AIC23_read(hCodec, &stereo));

		// Feeding the input directly to output you can add effects here
		OUT_L = (short) ((stereo >>16) & 0x0000FFFF) ;
		OUT_R = (short) (stereo             & 0X0000FFFF);

		// add echo
		short Output = OUT_R + a*buffer[i];

		// shift buffer
		buffer[i] = OUT_R;
		i++;
		if(i >= T) i = 0;


		//IN_L = (OUT_L << 16) | OUT_R;
		//IN_L = (Uint32) OUT_R;

		// Send sample, first left next right channel
		while (!DSK6713_AIC23_write(hCodec, Output));
	}

	//DSK6713_AIC23_closeCodec(hCodec); // Codec close is unreachable
}
# endif

