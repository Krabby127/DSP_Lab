%% Build everything necessary for report
clear filename tracks;
close all;
tracks=setupFiles();

%% Plot windows
[C,D] = loadwindow();
h=figure;
plot(C);
title('Analysis Window');
xlabel('Coefficient');
ylabel('Magnitude');
axis auto;
saveas(h,'analysisWindow.png');
close(h);

h=figure;
plot(D);
title('Synthesis Window');
xlabel('Coefficient');
ylabel('Magnitude');
axis auto;
saveas(h,'synthesisWindow.png');
close(h);


%% Runs through all the files
parfor i=1:length(tracks)
    filename=tracks{i};
    coefficients=pqmf(filename,1);
    ipqmf(coefficients,filename);
end


%% Just for testing
filename=fullfile('lab4-data','sine1.wav');
info=audioinfo(filename);