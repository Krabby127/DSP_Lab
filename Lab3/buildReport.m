%% Build everything necessary for report
%% Prepare environment
clear d a b c tracks folderNames trackTest trackTrain filename song Xk ...
    mfccp specHistogram sim ARm NPCP;
close all;

%% Generate random list from set of files
d=randTest(1); % generate the random numbers for testing and save to file
[a,b,c]=size(d);
[tracks,folderNames]=setupFiles();
[trackTest,trackTrain]=assignRandTracks(d,tracks);

%% Run functions on all tracks
fbank=melBank();
parfor i=1:1
    for j=1:1
        for k=1:1
            filename=fullfile('..','data',folderNames{i},trackTest{i,j,k});
            song=extractSound(filename);
%             Xk=freqDist(song);
%             mfccp=mfcc(fbank,Xk);
            NPCP=normPCP(filename,song,1);
        end
    end
end