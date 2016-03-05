function [tracks,folderNames] = setupFiles()
folderNames=ls(fullfile('..','data')); % grab foldernames in "data" folder
folderNames(1:2,:)=[]; % first two will always be . and ..
folderNames=cellstr(folderNames); % convert to cells
NGenres=length(folderNames); % count the number of genre folders
NSongs = 25; % assuming 25 songs per genre
tracks=cell(NGenres,NSongs); % crete an empty cell array
for i=1:NGenres
    % feed into array
    trackTemp=ls(fullfile('..','data', folderNames{i},'*') );
    trackTemp(1:2,:)=[]; % first two will always be . and ..
    trackTemp=cellstr(trackTemp); % convert to cells
    for j=1:NSongs
        tracks{i,j}=trackTemp{j}; % MATLAB doesn't like cell math
    end
end