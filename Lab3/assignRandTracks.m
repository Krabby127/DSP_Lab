function [trackTest] = assignRandTracks(d,tracks)
[a,b,c]=size(d);
trackTest=cell(a,b,c);
for i=1:a %6
    for j=1:b %5
        for k=1:c %10
            % MATLAB really doesn't play well with cells
            trackTest{i,j,k}=tracks{i,d(i,j,k)};
        end
    end
end
end