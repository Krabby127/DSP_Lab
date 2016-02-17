function [ SFn ] = specFlat( filename )
%specFlat Computes the spectral flatness of a signal
%   Spectral flatness is the ratio between the geometric and arithmetic
%   means of the magnitude of the Fourier transform
Xk=freqDist(filename);
SFn=(geomean(abs(Xk))./mean(abs(Xk)));

h=figure
plot(SFn);
title(['Spectral Flatness: "' filename '"']);
xlabel('Frame Number');
ylabel('Flatness');
xlim([0,length(SFn)]);
saveas(gca,['specFlat_' filename(1:end-4) '.png']);
close(h);
end