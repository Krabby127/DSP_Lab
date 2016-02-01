%windows freq plot
close all;
filename='440Amp1.wav';
[x,~]=audioread(filename);
info=audioinfo(filename);
nsc = 512;
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
figure
spectrogram(x,bartlett(nsc),nov,nff,info.SampleRate,'yaxis');
title('Bartlett Window');
ax=gca;
saveas(ax,'BartlettWindow.png');
figure
spectrogram(x,hamming(nsc),nov,nff,info.SampleRate,'yaxis');
title('Hamming Window');
ax=gca;
saveas(ax,'HammingWindow.png');
figure
spectrogram(x,kaiser(nsc),nov,nff,info.SampleRate,'yaxis');
title('Kaiser Window');
ax=gca;
saveas(ax,'KaiserWindow.png');
close all;