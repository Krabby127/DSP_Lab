% Windows timing
fileArray=cellstr(['440Amp1.wav  '; '440Amp5.wav  ';'11025Amp1.wav';...
    '11025Amp5.wav'; '14080Amp1.wav'; '14080Amp5.wav']);
timings=zeros(1,length(fileArray)*3);
for i=1:length(fileArray)
    for j=1:3
        g=@()audioread(['' fileArray{i} '']);
        h=@()windows(['' fileArray{i} ''],j);
        timings((i-1)*3+j)=timeit(h)-timeit(g);
    end
end

bartTime=timings(1:3:end);bartTotal=sum(bartTime);
hannTime=timings(2:3:end);hannTotal=sum(hannTime);
kaiserTime=timings(3:3:end);kaiserTotal=sum(kaiserTime);
x=1:length(fileArray);
a=bar([bartTime;hannTime;kaiserTime],'stacked');
ax=gca;
ylim([min([bartTotal,hannTotal,kaiserTotal])*0.995,...
    max([bartTotal,hannTotal,kaiserTotal])*1.005]);
ylabel('Time (s)');
xlabel('Window method');
set(gca,'XTickLabel',['Bartman Window'; 'Hanning Window';...
    'Kaiser Window ' ]);
title('Window Performance');
saveas(gca,'windowsTiming.png');
close all;