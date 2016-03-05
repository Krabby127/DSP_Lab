function [PCP] = normPCP( filename,x,~)
%rhythmIndex Identifies rhythmic periods
%   B(l) is the sum of all the entries on the lth upper diagonal.
%   The index l associated with the largest value of B(l) corresponds to
%   the presence of a rhythmic period of l*K/f_s seconds
info=audioinfo(filename);
% x=extractSound(filename);
[s,~,~]=spectrogram(x,kaiser(512),256,512,info.SampleRate,'yaxis');
s=abs(s);
[a,b]=size(s);

% pks=zeros(a,b);
locs=zeros(a,b);
peaks=zeros(a,b);
for i=1:b
    len=length(findpeaks(s(:,i)));
    [peaks(1:len,i),locs(1:len,i)]=findpeaks(s(:,i));
end
freqVals=(5512/257)*locs;
f0=27.5;
sm=round(12*log2(freqVals/f0));
r=12*log2(freqVals/f0)-sm;
c=mod(sm,12);
[~,B]=size(c); % 257,1032

w=(cos(pi*r/2)).^2;
w(isnan(w))=0;

% k is the number of peaks
% c is the chroma (A,A#,B,etc.)
% n is the frame number
% Weighting function, w, needs to be k*n*c large

PCP=zeros(12,B);


% Pick out semitones
% Loop through each value of c (1,2,...,12)
% Find the corresponding rows to extract from w where semitone is
% (1,2,...,12) multiply by Xn at that row at the corresponding row



peaks=peaks.^2;

for i=1:B %nFrames
    for j=0:11
        a=find(c(:,i)==j);
        PCP(12-j,i)=sum(w(a,i).*peaks(a,i));
    end
end
PCP=bsxfun(@rdivide,PCP,sum(PCP));

[pathstr,name,ext] = fileparts(filename) ;

if(nargin==3)
    h=figure;
    genre=pathstr(find(pathstr==filesep,1,'last')+1:end);
    imagesc(PCP);
    ax=gca;
    ax.YTickLabel=fliplr({'A ','A#','B ','C ','C#','D ','D#','E ',...
        'F ','F#','G ','G#'});
    ax.YTick=linspace(1,12,12);
    colormap 'jet';
    title({'Chroma :';genre ' ' name ext  });
    xlabel('frames');
    ylabel('Note');
    colorbar;
    saveas(gca,['NPCP' genre name '.png']);
    close(h);
end
end