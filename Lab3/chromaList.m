function [ npcpList ] = chromaList( tracks,folderNames,timeLength)
%mfccpList Precomputes the mfcc for all 150 songs

if(nargin==2)
    timeLength=120;
end
% allows for easier indexing
folderNames=repmat(folderNames,[1,25]);
folderNames=folderNames';

tracks=tracks';% allows us to keep songs within same genre close together
numTracks=numel(tracks);


npcpList=cell(numTracks,1);
% h=waitbar(0,'Computing Chroma List...');
parfor i=1:numTracks
    % waitbar(i/numTracks);
    filename=fullfile('..','data',folderNames{i},tracks{i});
    x=extractSound(filename,timeLength);
    npcpList{i}=normPCP(filename,x);
end
% close(h);
end