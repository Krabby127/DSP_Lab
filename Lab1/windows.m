function [Xn] = windows( filename, window )
%windows Implement the computation of the windowed Fourier transform of y
% start=cputime;
frameSize=512;
switch window
    case 1
        w=bartlett(frameSize); % Bartlett window
    case 2
        w=hann(frameSize); % Hann (Hanning) window
    case 3
        w=kaiser(frameSize,0.5); % Kaiser window
    otherwise
        w=kaiser(frameSize,0.5); % defaults to Kaiser window
end
[x,~]=extractSound(filename,24);
xn=buffer(x,frameSize);
Y=zeros(size(xn));
for i=1:length(xn)
    Y(:,i)=fft(xn(:,i).*w);
end
K=frameSize/2+1;
Xn=size(Y);
for i=1:length(xn)
   Xn(1:K,i)=Y(1:K,i);
end
end