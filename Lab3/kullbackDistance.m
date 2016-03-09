function [ d ] = kullbackDistance( P,Q)
%kullbackDistance Computes the distance between two tracks
%   First computes the Kullback-Leibler divergence
%   Then the KL distance is rescaled using an exponential kernel

mu1 = mean(P,2,'omitnan');
Cov1=cov(P','omitrows');
mu2 = mean(Q,2,'omitnan');
Cov2=cov(Q','omitrows');

K=12;

KL=(0.5*trace(pinv(Cov2)*Cov1+(pinv(Cov1)*Cov2)))-K+...
    (0.5*(mu1-mu2)')*(pinv(Cov2)+pinv(Cov1))*(mu1-mu2);

gamma=0.002; % gamma should be very very small
d=exp(-1*gamma*KL);% Apply weighting kernel
end