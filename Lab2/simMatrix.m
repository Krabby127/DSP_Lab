function [ sim ] = simMatrix(mfccp,filename,~)
%simMatrix displays the similarity matrix for the mel coefficients
%   The similarity matrix is defined as follows:
%   S(i,j) = sum_{k=1}^{nbanks}{
%   (mfcc(k,i)*mfcc(k,j))/(norm(mfcc(:,i)) * norm(mfcc(:,j)))
% fbank=melBank();
% mfccp=mfcc(fbank,filename);
[a,b]=size(mfccp);
% Preallocate matrix
sim=zeros(b,b);
normI=sqrt(sum(abs(mfccp).^2,1));
parfor i=1:b %frame i
    for j=1:b %frame j
        for k=1:a %fbank k
            sim(i,j)=sim(i,j)+...
                (mfccp(k,i)*mfccp(k,j)/(normI(j).*normI(i)));
        end
    end
end

if(nargin == 3)
    h=figure;
    imagesc(sim);
    xlabel('Frame Number');
    ylabel('Frame Number');
    title({'Similarity Matrix:'; filename});
    colorbar;
    colormap 'jet';
    saveas(gca,['SimMatrix' filename(6:end-4) '.png']);
    close(h);
end
end