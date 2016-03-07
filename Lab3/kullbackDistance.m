function [ d ] = kullbackDistance( P,Q)
%kullbackDistance Computes the distance between two tracks
%   First computes the Kullback-Leibler divergence
%   Then the KL distance is rescaled using an exponential kernel

mu1 = mean(P,2,'omitnan');
Cov1=cov(P','omitrows');
mu2 = mean(Q,2,'omitnan');
Cov2=cov(Q','omitrows');

K=12;

KL=0.5*(trace(pinv(Cov2)*Cov1)+((mu2-mu1)')*pinv(Cov2)*(mu2-mu1)-K+ ...
    log((abs(det(Cov2)/det(Cov1)))));

gamma=0.005; % gamma should be very very small
d=min(max(abs(exp(-1*gamma*KL)),0),1); % clamped between 0 and 1
end