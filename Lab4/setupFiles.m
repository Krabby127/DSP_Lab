function [tracks] = setupFiles()

folderName='lab4-data';
% feed into array
trackTemp=ls(fullfile(folderName,'*'));

if (isunix==0)
    trackTemp(1:2,:)=[]; % first two will always be . and .. (in Windows)
end
[nSongs,~]=size(trackTemp);
if isunix
    trackTemp=strsplit(trackTemp);
    trackTemp(end)=[]; % last is always '' in unix
end

tracks=cellstr(trackTemp); % convert to cells

if(isunix==0)
    % Windows does not include the full file
    for i=1:nSongs
        tracks{i}=fullfile(folderName,tracks{i});
    end
end
end