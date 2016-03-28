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
len=length(tracks);
totalError=zeros(len,1);
totalError1=zeros(len,1);
subbands=zeros(1,32);
subbands(1:6)=1; % As can be seen in the Pan95-mpega.pdf
parfor i=1:len
    filename=tracks{i};
    coefficients=pqmf(filename,1);
    [~,totalError1(i)]=ipqmf(coefficients,subbands,filename,1);
    [~,totalError(i)]=ipqmf(coefficients,filename,1);
    
end

songNames='';
for i=1:len
    [~,name,~]=fileparts(tracks{i});
    songNames=[songNames ' ' name];
end
songNames(1)=[]; % Remove extra space

h=figure;
bar(totalError);
title('Total Error');
xlabel('Track');
ylabel('Error Difference');
ax=gca;
axis([-inf inf 0 max(totalError)*1.025]);
ax.XTickLabel=strsplit(songNames);
saveas(h,'totalError.png');
close(h);

h=figure;
bar(totalError1);
title({'Total Error','Specialized Subbands'});
xlabel('Track');
ylabel('Error Difference');
ax=gca;
axis([-inf inf 0 max(totalError)*1.025]);
ax.XTickLabel=strsplit(songNames);
saveas(h,'totalError1.png');
close(h);