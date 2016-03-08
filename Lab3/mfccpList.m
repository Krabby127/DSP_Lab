function [ mfccList ] = mfccpList( tracks,folderNames,timeLength )
%mfccpList Precomputes the mfcc for all 150 songs

% allows for easier indexing
folderNames=repmat(folderNames,[1,25]);
folderNames=folderNames';

fbank=melBank();
tracks=tracks';% allows us to keep songs within same genre close together
numTracks=numel(tracks);


mfccList=cell(numTracks,1);
% h=waitbar(0,'Computing MFCC List...');
parfor i=1:numTracks
    % waitbar(i/numTracks);
    filename=fullfile('..','data',folderNames{i},tracks{i});
    mfccList{i}=mfcc(fbank,freqDist(extractSound(filename,timeLength)));
end
% close(h);
end