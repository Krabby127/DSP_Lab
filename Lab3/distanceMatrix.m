function [ distMatrix ] = distanceMatrix( xList,whichPlot,timeLength)
%distanceMatrix Computes the distance between every song
%   Uses a precomputed list of the mfcc/normPCP matrices to compute the
%   distance matrix

numTracks=length(xList);
distMatrix=zeros(numTracks,numTracks);

h=waitbar(0,'Computing Distance Matrix...');
for i=1:numTracks
    for j=1:numTracks
        if(i==j)
            distMatrix(i,j)=1;
        else
            distMatrix(i,j)=kullbackDistance(xList{i},xList{j});
        end
    end
    waitbar(i/numTracks)
end

close(h); % close waitbar
if(nargin>=2) %plot graph and save away
    h=figure;
    switch whichPlot
        case 0
            name='Chroma';
        case 1
            name='MFCC';
        case 2
            name='Chroma-Test';
        case 3
            name='MFCC-Test';
        case 4
            name='Chroma-Train';
        case 5
            name='MFCC-Train';
        otherwise
            name='';
    end
    timeLength=num2str(timeLength);
    imagesc(distMatrix);
    colormap 'jet';
    colorbar;
    title({'Distance Matrix:';[name '(' timeLength 'seconds)']});
    xlabel('Song A');
    ylabel('Song B');
    saveName=['distanceMatrix' name timeLength '.png'];
    saveas(gca,saveName);
    
%     close(h);
end
end