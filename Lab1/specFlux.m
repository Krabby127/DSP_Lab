function [ Fn] = specFlux( filename)
%specFlux Measures how quickly power spectrum is changing
%   The spectral flux is a global measure of the spectral changes between
%   two adjacent frames, n-1 and n
Xk=freqDist(filename);
Fn=sum(diff(Xk).^2);
end

