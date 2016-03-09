%% Build everything necessary for report
%% Prepare environment
% clear d a b c  trackTest trackTrain filename song Xk ...
%     mfccp specHistogram sim ARm NPCP;
% % clear tracks folderNames;
close all;

%% Generate random list from set of files
d=randTest(1); % generate the random numbers for testing and save to file
[a,b,c]=size(d);
[tracks,folderNames]=setupFiles();
[trackTest,trackTrain]=assignRandTracks(d,tracks);
% npcpLists=cell(4,1);
% mfccLists=cell(4,1);
%% Run functions on all tracks
timeLength=[30,60,120,240];
genreDistMatrix=zeros(6,6,4,2); % One for each time length and mfcc/chroma
h=waitbar(0,'This takes a while...');
for i=1:4
    %     mfccLists{i}=mfccpList(tracks,folderNames,timeLength(i));
    waitbar((4*i-1)/16);
    %     if(i~=4)
    %         npcpLists{i}=chromaList( tracks,folderNames,timeLength(i));
    %     end
    waitbar((4*i-2)/16);
    distMatrixM=distanceMatrix(mfccLists{i},1,timeLength(i));
    waitbar((4*i-3)/16);
    genreDistMatrix(:,:,i,1)=genreDist(distMatrixM,1,timeLength(i));
    %     if(i~=4)
    distMatrixC=distanceMatrix(npcpLists{i},0,timeLength(i));
    genreDistMatrix(:,:,i,2)=genreDist(distMatrixC,0,timeLength(i));
    %     end
    waitbar((4*i)/16);
end
close(h);