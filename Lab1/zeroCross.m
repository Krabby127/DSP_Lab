function [ ZCR_data ] = zeroCross( filename )
%zeroCross Computes the zero cross rate of the audio file
%   The Zero Crossing Rate is the average number of times the audio signal
%   crosses the zero amplitude line per time unit. The ZCR is related to...
%   the pitch height, and is also correlated to the noisiness of the...
%   signal.
frameSize=255;
time=24;
% info = audioinfo(filename);
[y,~]=extractSound( filename, time ); % Operate on middle 24 seconds
frames_data = buffer(y,frameSize,ceil(frameSize/2));
ZCR_data=zeros(1,length(frames_data));
ZCR_data(1:end)=sum(abs(diff(frames_data(1:end,:))))/length(frames_data);

p=plot(1:length(ZCR_data),ZCR_data(1,:));
title(['ZCR per frame: "' filename '"']);
xlim([0 length(ZCR_data)+1]);
xlabel('Frame Number');
ylabel('ZCR per frame');
saveas(p,['ZCR_' filename(1:end-4) '.png']);
end