function [ ARm ] = rhythmVar( filename,~ )
%autoC Computes the autocorrelation of a song
%   In general, if two frames i and j are similar, we can find out
%   if they are repeated later in the segment, at time j+l
sim = simMatrix( filename);
[len,~]=size(sim);
ARm=zeros(20,floor(len/20));

for l=0:19
    for m=0:floor(len/20-1)
        for j=1:20-l
            for i=1:20
                ARm(l+1,m+1)=ARm(l+1,m+1)+(sim(i+(m)*20,j+(m)*20)*...
                    sim(i+(m)*20,j+(m)*20+l));
            end
            ARm(l+1,m+1)=ARm(l+1,m+1)*(1/(20*(20-l)));
        end
        
    end
end

if(nargin==2)
    h=figure;
    yAxis=linspace(0,1,11);
    xAxis=linspace(0,15,len);
    imagesc(xAxis,yAxis,ARm);
    ax=gca;
    ax.YTickLabel=flipud(['0.0'; '0.1'; '0.2' ;'0.3'; '0.4'; '0.5'; '0.6'; '0.7'; '0.8'; ...
        '0.9'; '1.0']);
    title({'Autocorrelation AR(l,m):'; filename});
    xlabel('Time (secs)');
    ylabel('Lag (secs)');
    colormap 'jet';
    saveas(gca,['RhythmVar' filename(6:end-4) '.png']);
    close(h);
end
end