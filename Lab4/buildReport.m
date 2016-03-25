%build everything necessary for report
clear filename song Xk mfccp specHistogram sim ARm NPCP;
close all;
tracks=setupFiles();
parfor i=1:length(tracks)
    filename=tracks{i};
    pqmf(filename,1);
end