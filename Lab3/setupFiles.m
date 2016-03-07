function [tracks,folderNames] = setupFiles()
folderNames=ls(fullfile('..','data')); % grab foldernames in "data" folder
if (isunix == 0)
    folderNames(1:2,:)=[]; % first two will always be . and .. (in Windows)
end
if isunix
    folderNames=strsplit(folderNames);
    folderNames(end)=[]; % Remove space
end
folderNames=cellstr(folderNames); % convert to cells
NGenres=length(folderNames); % count the number of genre folders
NSongs = 25; % assuming 25 songs per genre
tracks=cell(NGenres,NSongs); % crete an empty cell array
for i=1:NGenres
    % feed into array
    trackTemp=ls(fullfile('..','data', folderNames{i},'*') );
    
    if (isunix==0)
        trackTemp(1:2,:)=[]; % first two will always be . and .. (in Windows)
    end
    if isunix
        trackTemp=strsplit(trackTemp);
        trackTemp(end)=[];
    end
    
    trackTemp=cellstr(trackTemp); % convert to cells
    for j=1:NSongs
        tracks{i,j}=trackTemp{j}; % MATLAB doesn't like cell math
    end
end

if isunix
    numEL=numel(tracks);
    
    for i=1:numEL
        [~,name,ext]=fileparts(tracks{i});
        tracks{i}=[name ext];
    end
end
end