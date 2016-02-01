function [ Fn] = specFlux( filename)
%specFlux Measures how quickly power spectrum is changing
%   The spectral flux is a global measure of the spectral changes between
%   two adjacent frames, n-1 and n
Xk=freqDist(filename);
Fn=sum(diff(Xk).^2);

close all;
figure
plot(Fn);
title(['Spectral Flux: "' filename '"']);
xlabel('Frame Number');
ylabel('Flux');
xlim([0,length(Fn)]);
saveas(gca,['specFlux' filename(1:end-4) '.png']);
close all;
end