function [ genreDistMatrix ] = genreDist(distMatrix,whichPlot,songTime)
%genreDist Computes 6x6 average distance matrix between the genres

genreDistMatrix=zeros(6,6);
[len,width]=size(distMatrix);
if(len~=width)
    error('Matrix must be square');
end
len=len/6; % saves extra divisions later
for i=1:6
    for j=1:6
        genreDistMatrix(i,j)=1/(len*len)*...
            sum(sum(distMatrix((1+(len*(i-1)):len+(len*(i-1))),...
            (1+(len*(j-1)):len+(len*(j-1))))));
    end
end
if(nargin>=2)
    songTime=num2str(songTime);
    h=figure;
    switch whichPlot
        case 0
            name='NPCP';
        case 1
            name='MFCC';
        case 2
            name='NPCP-Test';
        case 3
            name='MFCC-Test';
        otherwise
            name='';
    end
    imagesc(genreDistMatrix);
    ax=gca;
    colorbar;
    colormap 'jet';
    bottomTitle=[name '(' songTime ') seconds'];
    title({'Genre Distribution Matrix:'; bottomTitle});
    xlabel('Genre A');
    ylabel('Genre B');
    ax.XTickLabels={'Classical','Electronic','Jazz','Punk','Rock','World'};
    ax.YTickLabels={'Classical','Electronic','Jazz','Punk','Rock','World'};
    saveas(gca,['genreDistributionMatrix' name songTime '.png']);
    close(h);
end
end