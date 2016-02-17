function [ sim ] = simMatrix( filename,~)
%simMatrix displays the similarity matrix for the mel coefficients
%   The similarity matrix is defined as follows:
%   S(i,j) = sum_{k=1}^{nbanks}{
%   (mfcc(k,i)*mfcc(k,j))/(norm(mfcc(:,i)) * norm(mfcc(:,j)))
fbank=melBank();
mfccp=mfcc(fbank,filename);
[a,b]=size(mfccp);
% Preallocate matrix
sim=zeros(b,b);
% normI=sqrt(sum(abs(mfccp)
parfor i=1:b %frame i
        mfccNormI = sqrt(sum(mfccp(:,i).^2));
    for j=1:b %frame j
                mfccNormJ = sqrt(sum(mfccp(:,j).^2));
        for k=1:a %fbank k
            sim(i,j)=sim(i,j)+...
                (mfccp(k,i)*mfccp(k,j)/(mfccNormJ*mfccNormI));
        end
    end
end
% sim(:)=sim(:)/max(sim(:));
% ax=gca;
sim=(sim+1)/2;
if(nargin == 2)
    h=figure;
    imagesc(sim);
    xlabel('Frame Number');
    ylabel('Frame Number');
    title({'Similarity Matrix:'; filename});
    colorbar;
    colormap 'jet';
    saveas(gca,['SimMatrix' filename(6:end-4) '.png']);
%     close(h);
end
end