function [ d ] = kullbackDistance( P,Q,checkSame)
%kullbackDistance Computes the distance between two tracks
%   First computes the Kullback-Leibler divergence
%   Then the KL distance is rescaled using an exponential kernel

% The program hangs if it tries to compute for the same two matrices
% Default is to check the two
if(nargin==2)
    checkSame=1;
end
% trace(s*pinv(s))=length(s)
% (mu1-mu1) = zeros(1,length(s))
% length(s)+0-K+0
% KL=12+0-12+0   =0
% d=e^0   =1

if(checkSame==1)
    if(isequal(P,Q))
        d=1;
        return;
    end
end

mu1 = mean(P,2);
Cov1=cov(P');
mu2 = mean(Q,2);
Cov2=cov(Q');

K=12;

KL=0.5*(trace(pinv(Cov2)*Cov1)+((mu2-mu1)')*pinv(Cov2)*(mu2-mu1)-K+ ...
    log(det(Cov2)/det(Cov1)));

lambda=0.000001; % Lambda should be very very small
d=exp(-lambda*KL);
end