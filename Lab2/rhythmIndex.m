function [ B ] = rhythmIndex( filename,~)
%rhythmIndex Identifies rhythmic periods
%   B(l) is the sum of all the entries on the lth upper diagonal.
%   The index l associated with the largest value of B(l) corresponds to
%   the presence of a rhythmic period of l*K/f_s seconds
sim = simMatrix( filename);
[len,~]=size(sim);
B=zeros(1,len);

parfor l=0:len-1
    B(l+1)=(1/(len-l))*sum(diag(sim,l));
end

if(nargin==2)
    h=figure;
    plot(B);
    xlim([0,len]);
    title({'Rhythm Index B(l):'; filename});
    xlabel('lag (frames)');
    ylabel('Presence of rhythmic period');
    saveas(gca,['RhythmIndex' filename(6:end-4) '.png']);
    close(h);
end
end

