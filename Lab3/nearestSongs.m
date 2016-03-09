function [ genreGuess ] = nearestSongs( distMatrixTest,folderNames )
%nearestSongs Finds the genre from the 5 nearest songs

genreLen=length(folderNames); % How many genres
[a,b]=size(distMatrixTest);
distMatrixTest(logical(eye(a,b))) = 0; % set diag to 0
genreGuess=zeros(1,a);
for i=1:a
    [~,index]=sort(distMatrixTest(i,:),'descend');
    
    genrePicks=floor(index(1:5)/(a/genreLen))+1;
    if(length(unique(genrePicks))==5)
        genreGuess(i)=genrePicks(1);
    else
        genreGuess(i)=mode(genrePicks);
    end
end
end

