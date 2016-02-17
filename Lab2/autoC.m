function [ AR ] = autoC( filename,~ )
%autoC Computes the autocorrelation of a song
%   In general, if two frames i and j are similar, we can find out
%   if they are repeated later in the segment, at time j+l
info = audioinfo(filename);
sim = simMatrix( filename);
[len,~]=size(sim);
AR=zeros(1,len);

parfor l=0:len-1
    for i=1:len
        for j=1:len-l
            AR(l+1)=AR(l+1)+(sim(i,j)*sim(i,j+l));
        end
    end
    AR(l+1)=AR(l+1)*(1/(len*(len-l)));
end

if(nargin==2)
    h=figure;
    xAxis=linspace(0,len/info.SampleRate,len);
    plot(xAxis,AR);
    xlim([0,len/info.SampleRate]);
    title({'Autocorrelation AR(l):'; filename});
    xlabel('Lag (secs)');
    ylabel('Autocorrelation');
    saveas(gca,['AutoC' filename(6:end-4) '.png']);
%     close(h);
end

end