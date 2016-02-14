function [Xn] = windows( filename, window )
%windows Implement the computation of the windowed Fourier transform of y
frameSize=512;
if(nargin == 1)
    window = 3;
end
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
xn=buffer(x,frameSize,frameSize/2);
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