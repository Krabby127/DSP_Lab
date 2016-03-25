function [tracks] = setupFiles()

folderName='lab4-data';
% feed into array
trackTemp=ls(fullfile(folderName,'*'));

if (isunix==0)
    trackTemp=strsplit(trackTemp);
    trackTemp(1:2,:)=[]; % first two will always be . and .. (in Windows)
end

if isunix
    trackTemp=strsplit(trackTemp);
    trackTemp(end)=[]; % last is always '' in unix
end

tracks=cellstr(trackTemp); % convert to cells
end