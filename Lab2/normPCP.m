function [PCP] = normPCP( filename,~)
%rhythmIndex Identifies rhythmic periods
%   B(l) is the sum of all the entries on the lth upper diagonal.
%   The index l associated with the largest value of B(l) corresponds to
%   the presence of a rhythmic period of l*K/f_s seconds
info=audioinfo(filename);
x=extractSound(filename);
[s,f,~]=spectrogram(x,kaiser(512),256,512,info.SampleRate,'yaxis');
s=abs(s);
[a,b]=size(s);

pks=zeros(a,b);
locs=zeros(a,b);
for i=1:b
    len=length(findpeaks(s(:,i)));
    [pks(1:len,i),locs(1:len,i)]=findpeaks(s(:,i));
end
freqVals=zeros(a,b);
for i=1:a
    for j=1:b
        if(locs(i,j)~=0)
            freqVals(i,j)=f(locs(i,j));
        end
    end
end
f0=27.5;
% sm=zeros(size(freqVals));
sm=round(12*log(freqVals/f0)/log(2));
c=mod(sm,12);


w=zeros(a,b,12);
% k is the number of peaks
% c is the chroma (A,A#,B,etc.)
% n is the frame number
% Weighting function, w, needs to be k*n*c large
% will be a*n*12 large
r=12*log2(freqVals/f0)-sm;
w=(cos(pi*r/2)).^2;

PCP=zeros(b,12);
c=c+1;
for j=1:b
    for i=1:12
        PCP(j,i)=sum(c(:,j)==i);
    end
end

for i=1:b
    PCP(i,:)=PCP(i,:)/sum(PCP(i,:));
end

if(nargin==2)
    h=figure;
    imagesc(PCP');
    ylim([1,12]);
    ax=gca;
    ax.YTickLabel=fliplr({'A ','A#','B ','C ','C#','D ','D#','E ',...
        'F ','F#','G ','G#'});
    colormap 'jet';
    title({'Chroma :'; filename});
    xlabel('frames');
    ylabel('Note');
    colorbar;
    saveas(gca,['NPCP' filename(6:end-4) '.png']);
%     close(h);
end
end