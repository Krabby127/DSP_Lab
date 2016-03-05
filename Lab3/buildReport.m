%% Build everything necessary for report
%% Prepare environment
clear filename song Xk mfccp specHistogram sim ARm NPCP;
close all;
filepath = '../Tracks';

%% Load Genre Names
foldernames = sort(strsplit(ls(filepath)).'); % This is the line that loads the folder names
foldernames = foldernames(2:end); % get rid of the space
Ngenres = size(foldernames,1);
%% Load Audio Track Names
for genre = 1:Ngenres
    folderpath = char(strcat(filepath,'/',foldernames(genre))); % make path to each genre folder
    tracktemp = sort(strsplit(ls(folderpath)).'); % This is the line that loads the song names
    tracks(genre,:) = tracktemp(2:end); % get rid of the space
    savepath(genre)
end
Ntracks = numel(tracks);
genre = cellstr([
    'Classical '; ...
    'Electronic'; ...
    'Jazz      '; ...
    'Punk      '; ...
    'Rock      '; ...
    'World     ' ...
    ]);
d=randTest();
[a,b,c]=size(d);
fbank=melBank();
parfor i=1:1
    for j=1:1
        for k=1:1
            filename=tracks(k,d(k,j,i));
            song=extractSound(filename);
            Xk=freqDist(song);
            mfccp=mfcc(fbank,Xk);
            NPCP=normPCP(filename,song,genre{k},1);
            
        end
    end
end


% %% Run functions on all tracks
% fbank=melBank();
% parfor i=1:Ntracks
%     filename=tracks(i);
%     song=extractSound(filename);
%     Xk=freqDist(song);
%     mfccp=mfcc(fbank,Xk);
%     specHistogram=spectrumHistogram(filename,mfccp,1);
%     sim=simMatrix(mfccp,filename,1);
%     rhythmIndex(filename,1);
%     autoC(filename,sim,1);
%     ARm=rhythmVar( filename,sim,1);
%     NPCP=normPCP(filename,song,1);
% end