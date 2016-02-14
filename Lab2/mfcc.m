function [ mfccp ] = mfcc( fbank,Xn )
%mfcc Computes the Mel frequency coeffecients
%   The mel-spectrum (MFCC) coefficient of the n-th frame is defined for
%   p = 1,...,NB
% fbank=fbank/max(fbank);
[a,~]=size(fbank);
[c,d]=size(Xn);
% a should be 40
% c should be 257
% d should be num frames (1032)
mfccp=zeros(a,d);
for n=1:d % frames
    mfcc_val=0;
    for p=1:a % banks
        for k=1:c
            mfcc_val = mfcc_val + abs((fbank(p,k)*Xn(k,n))^2);
        end
        mfccp(p,n)=mfcc_val;
    end
end
mfccp=10*log(mfccp)/log(10);
end