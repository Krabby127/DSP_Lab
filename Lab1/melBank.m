function [ fbank ] = melBank(  )
%melBank Creates a set of mel filter banks
%   Implement the computation of the triangular filterbanks
%   Hp, p = 1,...,NB. Your function will return an array fbank of size
%   NB x K such that fbank(p,:) contains the filter bank Hp.
close all;
nbanks = 40; %% Number of Mel frequency bands
% linear frequencies
N=512;
K=N/2+1;
fbank=zeros(nbanks,K);
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
melTemp=zeros(nbanks,max(melIdx2Frq));
% Implement equation for mel filters
for i = 2:nbanks+1
    currMel = melIdx2Frq(i);
    nextMel = melIdx2Frq(i+1);
    lastMel = melIdx2Frq(i-1);
    A=(2/(nextMel-lastMel));
    melDex=lastMel:currMel;
    melTemp(i-1,melDex)=A.*(melDex-lastMel)./(currMel-lastMel);
    melDex=currMel:nextMel;
    melTemp(i-1,melDex)=A.*(nextMel-melDex)./(nextMel-currMel);
end

W = round(linspace(1,max(melIdx2Frq),K));
for i = 1:nbanks
    fbank(i,:) = melTemp(i,W);
end
figure
plot(melTemp.');
title('Mel Filter Bank');
xlabel('Frequency (Hz)');
ylabel('Filter Magnitude');
xlim([0,length(melTemp)]);
saveas(gca,'melFilterBank.png');
% for i = 1:nbanks
%     disp(['fbank(',num2str(i),') = ',num2str(sum(fbank(i,:)))]);
% end
% 
% for i = 1:nbanks
%     disp(['melTemp(',num2str(i),') = ',num2str(sum(melTemp(i,:)))]);
% end
% close all;
end