function [ ARm ] = rhythmVar( filename,~ )
%autoC Computes the autocorrelation of a song
%   In general, if two frames i and j are similar, we can find out
%   if they are repeated later in the segment, at time j+l
info = audioinfo(filename);
sim = simMatrix( filename);
[len,~]=size(sim);
ARm=zeros(1,len);

for l=0:19
    for m=0:len/20-1
        for i=1:len
            for j=1:len-l
                ARm(l+1)=ARm(l+1)+(sim(i,j)*sim(i,j+l));
            end
        end
        ARm(l+1)=ARm(l+1)*(1/(len*(len-l)));
    end
end

if(nargin==2)
    h=figure;
    xAxis=linspace(0,len/info.SampleRate,len);
    plot(xAxis,ARm);
    xlim([0,len/info.SampleRate]);
    title({'Autocorrelation AR(l,m):'; filename});
    xlabel('Time (secs)');
    ylabel('Lag (secs)');
    saveas(gca,['RhythmVar' filename(6:end-4) '.png']);
    close(h);
end

end