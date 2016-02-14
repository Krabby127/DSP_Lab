function [ Xk ] = freqDist( filename )
%freqDist Computes the frequency distribution
% info=audioinfo(filename);
song=extractSound(filename);
frames_overlap = buffer(song,512,256);
w=kaiser(512);
N=512;
Y=fft(w.*frames_overlap(:,2));
Xk=Y(1:256);
K=N/2+1;

for i = 1:length(frames_overlap)
    Y=fft(w.*frames_overlap(:,i));
    Xk(1:K,i)=Y(1:K);
end
end