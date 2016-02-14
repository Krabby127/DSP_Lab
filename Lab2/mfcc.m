function [ mfccp ] = mfcc( fbank,Xn )
%mfcc Compute the Mel frequency coeffecients
%   The mel-spectrum (MFCC) coefficient of the n-th frame is defined for
%   p = 1,...,NB
[b,~]=size(fbank);
[~,d]=size(Xn);
mfccp=zeros(b,d);
for i=1:d % frames
    for j=1:b % banks
        mfccp(j,i)=sum(abs(fbank(j,:).*(Xn(:,i))').^2);
    end
end
mfccp=10*log(mfccp)/mfccp(10);
end