function [ mfccp ] = mfcc( filename )
%mfcc Compute the Mel frequency coeffecients
%   The mel-spectrum (MFCC) coefficient of the n-th frame is defined for 
%   p = 1,...,NB
fbank = melBank();
Xn = freqDist( filename );
[a,b]=size(fbank);
fbank=fbank./max(fbank,2);
mfccp=zeros(a,b);
for p=1:a
    for k=1:b
        mfccp(p)=mfccp(p)+(abs(fbank(p,k)*Xn(p,k)).^2);
    end
end