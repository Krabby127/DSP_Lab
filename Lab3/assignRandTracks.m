function [trackTest,trackTrain] = assignRandTracks(d,tracks)
[a,b,c]=size(d); % 6,5,10
trackTest=cell(a,b,c); %6,5,10
[e,f]=size(tracks); %6,25
if(e ~=a)
    error('mismatching input sizes');
end
A=1:f;
A=repmat(A,[f,1,c]);
newA=zeros(a,f-b,c); %6, 20
for i=1:a
    for j=1:c
        newA(i,:,j)=setdiff(A(i,:),d(i,:,j));
    end
end

trackTrain=cell(size(newA));
% trackTrain=tracks;
% % trackTrain=repmat(tracks,[1,1,c]);
for i=1:a %6 genres
    for j=1:(f-b) % all 25 possible songs
        for k=1:c %10 itterations
            % MATLAB really doesn't play well with cells
            if(j<=b)
                trackTest{i,j,k}=tracks{i,d(i,j,k)};
            end
            trackTrain{i,j,k}=tracks{i,newA(i,j,k)};
        end
    end
end



end