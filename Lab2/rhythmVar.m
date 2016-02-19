function [ ARm ] = rhythmVar( filename,~ )
%autoC Computes the autocorrelation of a song
%   In general, if two frames i and j are similar, we can find out
%   if they are repeated later in the segment, at time j+l
%   For the sake of this lab, we will be processing 20 frames (~1 second)
sim = simMatrix( filename);
[len,~]=size(sim);
ARm=zeros(20,floor(len/20));

for m=0:floor(len/20-1)
    Window = sim(20*m+1:20*(m+1),20*m+1:20*(m+1));
    for l=0:19
        temp=Window.*circshift(Window,[0,-l]);
        ARm(l+1,m+1) = sum(sum(temp(1:20-l,:)))/((20-l));
    end
end


ARm=ARm/20;

% for i=1:20
%     ARm(i,:)=ARm(i,:)/(max(ARm(i,:)));
% end

if(nargin==2)
    h=figure;
    imagesc(ARm);
    ax=gca;
    %ax.YTickLabel=flipud(['0.0'; '0.1'; '0.2' ;'0.3'; '0.4'; '0.5'; ...
    %   '0.6'; '0.7'; '0.8'; '0.9'; '1.0']);
    title({'Autocorrelation AR(l,m):'; filename});
    xlabel('Time (secs)');
    ylabel('Lag (secs)');
    colormap 'jet';
    colorbar;
    saveas(gca,['RhythmVar' filename(6:end-4) '.png']);
    %     close(h);
end
end