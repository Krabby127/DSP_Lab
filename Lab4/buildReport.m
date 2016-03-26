%build everything necessary for report
clear filename tracks;
close all;
tracks=setupFiles();
parfor i=1:length(tracks)
    filename=tracks{i};
    pqmf(filename,1);
end