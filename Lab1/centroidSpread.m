function [ centroid,sigmaK ] = centroidSpread( filename )
%centroid Summary of this function goes here
%   The spectral centroid can be used to quantify sound sharpness or
%   brightness. The spread quantifies the spread of the spectrum around
%   the centroid, and thus helps differentiate between tone-like and
%   noise-like sounds.
close all;
Xk=freqDist(filename);
[a,b]=size(Xk);
centroid=zeros(1,b);
sigmaK=zeros(1,b);
for n=1:b
    for k=1:a
        centroid(n)=centroid(n)+(k/a*Xk(k,n));
    end
end

for n=1:b
    for k=1:a
        sigmaK(n)=sigmaK(n)+(1/(a-1))*(Xk(k,n)-centroid(n))^2;        
    end
end
sigmaK=sqrt(sigmaK);
x=1:b;

figure
plot(x,sigmaK);
title(['Frequency Spread: "' filename '"']);
xlabel('Frame Number');
ylabel('Spread');
xlim([0,b]);
saveas(gca,['freqSpread' filename(1:end-4) '.png']);

figure
plot(x,centroid);
title(['Frequency Centroid: "' filename '"']);
xlabel('Frame Number');
ylabel('Centroid');
xlim([0,b]);
saveas(gca,['freqCent' filename(1:end-4) '.png']);
close all;
end