function [ npcpList ] = chromaList( tracks,folderNames )
%mfccpList Precomputes the mfcc for all 150 songs

% allows for easier indexing
folderNames=repmat(folderNames,[1,25]);
folderNames=folderNames';

tracks=tracks';% allows us to keep songs within same genre close together
numTracks=numel(tracks);


npcpList=cell(numTracks,1);
parfor i=1:numTracks
    filename=fullfile('..','data',folderNames{i},tracks{i});
    x=extractSound(filename);
    npcpList{i}=normPCP(filename,x);
end

end