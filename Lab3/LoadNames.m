filepath = '../data'; 

Fs = 22050;
T = 120; % 120 seconds, 2 mins

%% Load Genre Names
foldernames = sort(strsplit(ls(filepath)).'); % This is the line that loads the folder names 
foldernames = foldernames(2:end); % get rid of the space
Ngenres = size(foldernames,1);

%% Load Audio Track Names
for genre = 1:Ngenres
    folderpath = char(strcat(filepath,'/',foldernames(genre))); % make path to each genre folder
    tracktemp = sort(strsplit(ls(folderpath)).'); % This is the line that loads the song names
    tracks(genre,:) = tracktemp(2:end); % get rid of the space
end
Ntracks = numel(tracks);
% extractSound(GetFullPath(tracks(1)));