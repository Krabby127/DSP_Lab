function [ mfccList ] = mfccpList( tracks,folderNames )
%mfccpList Precomputes the mfcc for all 150 songs

% allows for easier indexing
folderNames=repmat(folderNames,[1,25]);
folderNames=folderNames';

fbank=melBank();
tracks=tracks';% allows us to keep songs within same genre close
numTracks=numel(tracks);


mfccList=cell(numTracks,1);
parfor i=1:numTracks
    filename=fullfile('..','data',folderNames{i},tracks{i});
    mfccList{i}=mfcc(fbank,freqDist(extractSound(filename)));
end
display('Finished with mfccList');

end