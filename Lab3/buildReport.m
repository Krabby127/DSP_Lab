%% Build everything necessary for report
%% Prepare environment
clear d a b c  trackTest trackTrain filename song Xk ...
    mfccp specHistogram sim ARm NPCP;
% clear tracks folderNames;
close all;

%% Generate random list from set of files
d=randTest(1); % generate the random numbers for testing and save to file
[a,b,c]=size(d);
[tracks,folderNames]=setupFiles();
% [trackTest,trackTrain]=assignRandTracks(d,tracks);

%% Run functions on all tracks
timeLength=[30,60,120,240];
genreDistMatrix=zeros(6,6,4); % One for each time length and mfcc/chroma
h=waitbar(0,'This takes a while...');
for i=1:4
    
    mfccList=mfccpList(tracks,folderNames,timeLength(i));
    waitbar((2*i-1)/8);
    %     waitbar((4*i-2)/16);
    %     npcpList=chromaList( tracks,folderNames,timeLength(i));
    
    distMatrixM=distanceMatrix(mfccList,1,timeLength(i));
    waitbar((2*i)/8);
    genreDistMatrix(:,:,i)=genreDist(distMatrixM);
    %     waitbar((4*i)/16);
    %     distMatrixC=distanceMatrix(npcpList,0,timeLength(i));
    %     genreDistMatrix(i,2,:,:)=genreDist(distMatrixC);
end
close(h);