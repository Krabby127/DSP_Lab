function [ mfccp ] = mfcc( fbank,filename,~)
%mfcc Computes the Mel frequency coeffecients
%   The mel-spectrum (MFCC) coefficient of the n-th frame is defined for
%   p = 1,...,NB
narginchk(2, 3);
Xn=freqDist(filename);
[nbank,~]=size(fbank);
[c,d]=size(Xn);
% a should be 40
% c should be 257
% d should be num frames (1034)
mfccp=zeros(nbank,d);

fbank_norm=zeros(nbank,c);
mfccp=(fbank*abs(freqDist(filename))).^2;
%normalize the filter banks
for i = 1:nbank
    norm = sum(fbank(i,:));
    for j = 1:c
        fbank_norm(i,j) = fbank(i,j)/norm;
    end
end


% Lets us still use non-log mfcc
if(nargin==3)
    mfccp=10*log10(mfccp);
    return;
end

% for i=1:1034
%     if(round(sum(mfccp(:,i)),3)~= 1.000)
%         disp(i);
%         error('sum not 1');
%     end
% end
end