%% Build everything necessary for report
%% Prepare environment
clear filename song Xk mfccp specHistogram sim ARm NPCP;
close all;

%% Generate random list of files
genre = cellstr([
    'Classical '; ...
    'Electronic'; ...
    'Jazz      '; ...
    'Punk      '; ...
    'Rock      '; ...
    'World     ' ...
    ]);

d=randTest(1); % generate the random numbers for testing and save to file
[a,b,c]=size(d);
tracks=setupFiles();
trackTest=assignRandTracks(d,tracks);

%% Run functions on all tracks
fbank=melBank();
parfor i=1:1
    for j=1:1
        for k=1:1
            filename=trackTest{i,j,k}
            song=extractSound(filename);
            Xk=freqDist(song);
            mfccp=mfcc(fbank,Xk);
            NPCP=normPCP(filename,song,genre{i},1);
        end
    end
end