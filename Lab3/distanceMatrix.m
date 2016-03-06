function [ distMatrix ] = distanceMatrix( mfccList,~)
%distanceMatrix Summary of this function goes here
%   Detailed explanation goes here

numTracks=length(mfccList);
distMatrix=zeros(numTracks,numTracks);
% parfor i=1:numTracks
%     for j=1:numTracks
%         if(i==j)
%             distMatrix(i,j)=1;
%         else
%             distMatrix(i,j)=kullbackDistance(mfccList{i},mfccList{j});
%
%         end
%     end
% end

parfor i=1:(numTracks*numTracks)
    [a,b]=ind2sub([numTracks,numTracks],i);
    if((a-b)==0)
        distMatrix(i)=1;
    else
        distMatrix(i)=kullbackDistance(mfccList{a},mfccList{b});
    end
end

if(nargin==2) %plot graph and save away
    h=figure;
    imagesec(distMatrix);
    colormap 'jet';
    colorbar;
    title('Distance Matrix');
    xlabel('Song A');
    ylabel('Song B');
    saveas(gca,'distanceMatrix.png');
    
    close(h);
end
end