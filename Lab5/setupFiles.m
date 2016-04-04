function [images] = setupFiles()

folderName='images';
% feed into array
imageTemp=ls(fullfile(folderName,'*'));

if (isunix==0)
    imageTemp(1:2,:)=[]; % first two will always be . and .. (in Windows)
end
[nImages,~]=size(imageTemp);
if isunix
    imageTemp=strsplit(imageTemp);
    imageTemp(end)=[]; % last is always '' (in unix)
end

images=cellstr(imageTemp); % convert to cells

if(isunix==0)
    % Windows does not include the full file
    for i=1:nImages
        images{i}=fullfile(folderName,images{i});
    end
end
end