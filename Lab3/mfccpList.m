function [ mfccList ] = mfccpList( tracks,folderNames,timeLength )
%mfccpList Precomputes the mfcc for all 150 songs

% allows for easier indexing
[~,b]=size(tracks);
folderNames=repmat(folderNames,[1,b]);
folderNames=folderNames';

fbank=melBank();
tracks=tracks';% allows us to keep songs within same genre close together
numTracks=numel(tracks);


mfccList=cell(numTracks,1);
parfor i=1:numTracks
    filename=fullfile('..','data',folderNames{i},tracks{i});
    mfccList{i}=mfcc(fbank,freqDist(extractSound(filename,timeLength)));
end
end