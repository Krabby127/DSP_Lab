function [ soundExtract,p ] = extractSound( filename, time)
%extractSound Extracts time (in seconds) from the middle of the song
%   Write a MATLAB function that extract T seconds of music from a
%   given track. You will use the MATLAB function audioread to
%   read a track and the function play to listen to the track.
narginchk(1, 2);
if(nargin == 1)
    time = 120; %default is to read 2 minutes
end
info = audioinfo(filename);
song=audioread(filename);
if time >= info.Duration
    soundExtract=song;
%     warning('Data may be less accurate with less than 2 minutes');
    if(nargout == 2)
        p=audioplayer(soundExtract,info.SampleRate);
    end
    return;
elseif time<= 1/info.SampleRate
    error('Too small of a time to sample');
end
samples=time*info.SampleRate;

soundExtract=song(floor(info.TotalSamples/2)-floor(samples/2):1: ...
    floor(info.TotalSamples/2)+floor(samples/2));
if(nargout == 2)
    p=audioplayer(soundExtract,info.SampleRate);
end
end