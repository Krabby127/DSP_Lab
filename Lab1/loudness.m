function [ loudness_data ] = loudness( filename,varargin )
%loudness Computes the standard deviation of the original audio divided
%into frames of size 255 loudness(filename,[franeSize,time,plotBool])
%   The standard deviation of the original audio signal x[n] computed over
%   a frame of size N provides a sense of the loudness
% 
%   frameSize = size of frame to compute loudness over; defaults to 255
%   time = duration of song to analyze; defaults to 24 seconds
%   plotBool = whether or not to plot results; default is true
switch nargin
    case 1
        frameSize=512;
        time=24;
        plotBool=1;
    case 2
        frameSize=varargin{1};
        time=24;
        plotBool=1;
    case 3
        frameSize=varargin{1};
        time=varargin{2};
        plotBool=1;
    case 4
        frameSize=varargin{1};
        time=varargin{2};
        plotBool=varargin{3};
    otherwise
        error('loudness:argChk', 'Wrong number of input arguments');
end
[y,~]=extractSound( filename, time );
frames_data = buffer(y,frameSize,ceil(frameSize/2));
loudness_data=std(frames_data,0,1);
if plotBool==1
    p=plot(1:length(loudness_data),loudness_data(1,:));
    title(['Loudness per frame: "' filename '"']);
    xlim([0 length(loudness_data)+1]);
    xlabel('Frame Number');
    ylabel('Loudness');
    saveas(p,['Loudness_' filename(1:end-4) '.png']);
end
end

