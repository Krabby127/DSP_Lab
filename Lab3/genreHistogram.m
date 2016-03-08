function [ genreHisto ] = genreHistogram( xList,~ )
%genreHistogram generates histograms for all 6 genres from distance matrix


a=combnk(1:25,2);
len=nchoosek(25,2);
genreHisto=zeros(25,25,6)-1; % Sanity check for debugging
for j=1:6
    for i=1:len
        ind=a(i,:);
        temp=kullbackDistance(...
            xList{ind(1)+(25*(j-1))},xList{ind(2)+(25*(j-1))});
        genreHisto(ind(1),ind(2),j)=temp;
        genreHisto(ind(2),ind(1),j)=temp; % mirror across diagonol
    end
    for i=1:25
        genreHisto(i,i,j)=1;
    end
end

if(nargin==2)
    h=figure;
    
    subplot(2,3,1);
    h1=histogram(genreHisto(:,:,1));
    h1.Normalization='probability';
    h1.BinWidth=0.1;
    h1.FaceColor='red';
    title('Classical');
    
    subplot(2,3,2);
    h2=histogram(genreHisto(:,:,2));
    h2.Normalization='probability';
    h2.BinWidth=0.1;
    h2.FaceColor='green';
    title('Electronic');
    
    subplot(2,3,3);
    h3=histogram(genreHisto(:,:,3));
    h3.Normalization='probability';
    h3.BinWidth=0.1;
    h3.FaceColor='blue';
    title('Jazz');
    
    subplot(2,3,4);
    h4=histogram(genreHisto(:,:,4));
    h4.Normalization='probability';
    h4.BinWidth=0.1;
    h4.FaceColor='cyan';
    title('Punk');
    
    subplot(2,3,5);
    h5=histogram(genreHisto(:,:,5));
    h5.Normalization='probability';
    h5.BinWidth=0.1;
    h5.FaceColor='magenta';
    title('Rock');
    
    subplot(2,3,6);
    h6=histogram(genreHisto(:,:,6));
    h6.Normalization='probability';
    h6.BinWidth=0.1;
    h6.FaceColor='yellow';
    title('World');
    saveas(gca,'genreHistogram.png');
    close(h);
end
end