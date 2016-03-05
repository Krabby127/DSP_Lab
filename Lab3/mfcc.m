function [ mfccp ] = mfcc( fbank,Xn,~)
%mfcc Computes the Mel frequency coeffecients
%   The mel-spectrum (MFCC) coefficient of the n-th frame is defined for
%   p = 1,...,NB
narginchk(2, 3);
% Xn=freqDist(filename);
mfccp=(fbank*abs(Xn)).^2;
% Lets us still use non-log mfcc (if needed)
if(nargin==3)
    mfccp=10*log10(mfccp);
    return;
end
end