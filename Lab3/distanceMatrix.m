function [ distMatrix ] = distanceMatrix( xList,whichPlot)
%distanceMatrix Computes the distance between every song
%   Uses a precomputed list of the mfcc/normPCP matrices to compute the
%

numTracks=length(xList);
distMatrix=zeros(numTracks,numTracks);

num2=numTracks*numTracks;
h=waitbar(0,'Please wait...');
for i=1:numTracks
    for j=1:numTracks
        waitbar(sub2ind([numTracks,numTracks],j,i)/num2);
        if(i==j)
            distMatrix(i,j)=1;
        else
            distMatrix(i,j)=kullbackDistance(xList{i},xList{j});
        end
    end
end

% for i=1:num2
%     [a,b]=ind2sub([numTracks,numTracks],i);
%     waitbar(i/num2);
%     if((a-b)==0)
%         distMatrix(i)=1;
%     else
%         mfccp1=mfccList{a};
%         mfccp2=mfccList{b};
%         distMatrix(i)=kullbackDistance(mfccp1,mfccp2);
%     end
% end
close(h); % close waitbar
if(nargin==2) %plot graph and save away
    h=figure;
    if(whichPlot==1)
        name='MFCC';
    else
        name='Chroma';
    end
    
    imagesc(distMatrix);
    colormap 'jet';
    colorbar;
    title({'Distance Matrix:';name});
    xlabel('Song A');
    ylabel('Song B');
    saveName=['distanceMatrix' name '.png'];
    saveas(gca,saveName);
    
    % close(h);
end
end