function [ mfccp ] = mfcc( fbank,Xn,~)
%mfcc Computes the Mel frequency coeffecients
%   The mel-spectrum (MFCC) coefficient of the n-th frame is defined for
%   p = 1,...,NB
narginchk(2, 3);
% Xn=freqDist(filename);
mfccp=(fbank*abs(Xn)).^2;

% Convert to only using 12 banks
t = zeros(1,36);
t(1) =1;t(7:8)=5;t(15:18)= 9;
t(2) = 2; t( 9:10) = 6; t(19:23) = 10;
t(3:4) = 3; t(11:12) = 7; t(24:29) = 11;
t(5:6) = 4; t(13:14) = 8; t(30:36) = 12;
mel2 = zeros(12,size(mfccp,2));
for i=1:12,
    mel2(i,:) = sum(mfccp(t==i,:),1);
end
mfccp=mel2;
% Lets us still use non-log mfcc (if needed)
if(nargin==3)
    mfccp=10*log10(mfccp);
    return;
end
end