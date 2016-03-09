function [ npcpList ] = chromaList( tracks,folderNames,timeLength)
%chromaList Precomputes the npcp for all 150 songs

% allows for easier indexing
[~,b]=size(tracks);
folderNames=repmat(folderNames,[1,b]);
folderNames=folderNames';

tracks=tracks';% allows us to keep songs within same genre close together
numTracks=numel(tracks);


npcpList=cell(numTracks,1);
parfor i=1:numTracks
    filename=fullfile('..','data',folderNames{i},tracks{i});
    npcpList{i}=normPCP(filename,extractSound(filename,timeLength));
end
end