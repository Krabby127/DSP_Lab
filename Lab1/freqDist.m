function [ Xk ] = freqDist( filename )
%freqDist Computes the frequency distribution
info=audioinfo(filename);
x=extractSound(filename);
nsc = 512;
nov = floor(nsc/2);
nff = max(256,2^nextpow2(nsc));
s=spectrogram(x,hamming(nsc),nov,nff,info.SampleRate,'yaxis');
[a,b]=size(s);
Xk=zeros(a,b);
absVal=abs(s);
rowTotals=sum(absVal,1);
for n=1:b
    for k=1:a
        Xk(k,n)=absVal(k,n)/rowTotals(k);
    end
end
end