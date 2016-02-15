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

%normalize the filter banks
for i = 1:nbank
    norm = sum(fbank(i,:));
    for j = 1:c
        fbank_norm(i,j) = fbank(i,j)/norm;
    end
end

%mel-spectrum coefficients
for n=1:d % frames
    mfcc_val=0;
    for p=1:nbank % banks
        for k=1:c
            mfcc_val = mfcc_val + abs((fbank_norm(p,k)*Xn(k,n))^2);
        end
        mfccp(p,n)=mfcc_val;
    end
end

% Lets us still use non-log mfcc
if(nargin~=3)
    mfccp=10*log(mfccp)/log(10);
    return;
end
for i=1:d
    mfccp(:,i)=mfccp(:,i)/sum(mfccp(:,i));
end

for i=1:1034
    if(round(sum(mfccp(:,i)),3)~= 1.000)
        disp(i);
        error('sum not 1');
    end
end
end