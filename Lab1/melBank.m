function [ fbank ] = melBank(~)
%melBank Creates a set of mel filter banks
%   Implement the computation of the triangular filterbanks
%   Hp, p = 1,...,NB. Your function will return an array fbank of size
%   NB x K such that fbank(p,:) contains the filter bank Hp.

nbanks = 40; % Number of Mel frequency bands
% linear frequencies
N=512;
K=N/2+1;
% fbank=zeros(nbanks,K);
fs=11025;
linFrq = 20:fs/2;
% mel frequencies
melFrq = log ( 1 + linFrq/700) *1127.01048;
% equispaced mel indices
melIdx = linspace(1,max(melFrq),nbanks+2);
% From mel index to linear frequency
melIdx2Frq = zeros (1,nbanks+2);
% melIdx2Frq (p) = \Omega_p
for i=1:nbanks+2
    [~, indx] = min(abs(melFrq - melIdx(i)));
    melIdx2Frq(i) = linFrq(indx);
end

% map frequency banks
fbank_freq = linspace(0,floor(fs/2),K);

fbank=zeros(nbanks,K);
% Implement equation for mel filters
for i = 2:nbanks+1
    range=2/(melIdx2Frq(i+1)-melIdx2Frq(i-1));
    for j=1:K
        filt_val=range;
        if(fbank_freq(j) <= melIdx2Frq(i)) ...
                && (fbank_freq(j) > melIdx2Frq(i-1))
            filt_val = filt_val*((fbank_freq(j) -melIdx2Frq(i-1)) ...
                /(melIdx2Frq(i) - melIdx2Frq(i-1)));
            fbank(i-1,j) = filt_val;
            
        elseif(fbank_freq(j) < melIdx2Frq(i+1)) ...
                && (fbank_freq(j) >= melIdx2Frq(i))
            filt_val = filt_val*((melIdx2Frq(i+1) - fbank_freq(j))...
                /(melIdx2Frq(i+1) - melIdx2Frq(i)));
            fbank(i-1,j) = filt_val;
        else
            fbank(i-1,j)=0;
        end
    end
end

for i=1:nbanks
    norm=sum(fbank(i,:));
    for j=1:K
        fbank(i,j)=fbank(i,j)/norm;
    end
end

if(nargin)
    close all;
    figure
    plot(fbank.');
    title('Mel Filter Bank');
    xlabel('Frequency (Hz)');
    ylabel('Filter Magnitude');
    xlim([0,length(fbank)]);
    saveas(gca,'melFilterBank.png');
    close all;
end
end