function [ confusionMatrix] = confuseMatrix( genreGuess,~ )
%confuseMatrix Computes a confusion matrix from the genre guesses

confusionMatrix=zeros(6,6)-1;% helpful for debugging
A=reshape(genreGuess,[length(genreGuess)/6,6]);
for i=1:6
    for j=1:6
        confusionMatrix(j,i)=sum(numel(find(A(:,i)==j)));
    end
end
if nargin==2
    h=figure;
    confuseString=num2str(confusionMatrix(:));
    textStrings = strtrim(cellstr(confuseString));
    imagesc(confusionMatrix./25);
    ax=gca;
    for i=1:6
        for j=1:6
            text(j,i,textStrings{sub2ind([6,6],i,j)});
        end
    end
    colorbar;
    % colormap jet; % can't see numbers with "jet"
    title({'Confusion Matrix'});
    xlabel('Genre A');
    ylabel('Genre B');
    ax.XTickLabels={'Classical','Electronic','Jazz','Punk','Rock','World'};
    ax.YTickLabels={'Classical','Electronic','Jazz','Punk','Rock','World'};
    saveas(ax,'confusionMatrix.png');
    close(h);
end
end