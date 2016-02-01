function [ SFn ] = specFlat( filename )
%specFlat Computes the spectral flatness of a signal
%   Spectral flatness is the ratio between the geometric and arithmetic
%   means of the magnitude of the Fourier transform
Xk=freqDist(filename);
SFn=(geomean(Xk)./mean(Xk));
end