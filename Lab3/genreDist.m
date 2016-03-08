function [ genreDistMatrix ] = genreDist( distMatrix)
%genreDist Computes 6x6 average distance matrix between the genres

genreDistMatrix=zeros(6,6);

for i=1:6
    for j=1:6
        genreDistMatrix(i,j)=1/(25*25)*...
            sum(sum(distMatrix((1+(25*(i-1)):25+(25*(i-1))),...
            (1+(25*(j-1)):25+(25*(j-1))))));
    end
end
end