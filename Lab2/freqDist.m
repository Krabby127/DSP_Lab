function [ Xk ] = freqDist( filename )
%freqDist Computes the frequency distribution
Xn=windows(filename, 1);
Xk=zeros(size(Xn));
for n=1:length(Xn)
    for k=1:min(size(Xk))
        Xk(k,n)=abs(Xn(k,n))./sum(abs(Xn(1:k,n)));
    end
end
end