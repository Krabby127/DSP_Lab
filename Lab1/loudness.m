function [ loudness_data ] = loudness( filename,frameSize )
%loudness Computes the standard deviation of the original audio divided
%into fromes of size 255
%   The standard deviation of the original audio signal x[n] computed over
%   a frame of size N provides a sense of the loudness
[y,~]=audioread(filename);
info=audioinfo(filename);
frames_data = buffer(y,frameSize,floor(frameSize/2));
% loudness_date=zeros(1,ceil(info.TotalSamples/frameSize));
loudness_data=std(frames_data);
end

