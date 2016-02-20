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

% pks=zeros(a,b);
locs=zeros(a,b);
for i=1:b
    len=length(findpeaks(s(:,i)));
    [~,locs(1:len,i)]=findpeaks(s(:,i));
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
sm=round(12*log2(freqVals/f0));
r=12*log2(freqVals/f0)-sm;
c=mod(sm,12);
% c=c+1;
[D,B]=size(c); % 257,1032
% w=zeros(D,12,B);

w=(cos(pi*r/2)).^2;

% 
% for k=1:B %1032
%     for n=1:D %257
%         if(isnan(c(n,k)+1)==0)
%             w(n,c(n,k)+1,k)=(cos(pi*r(n,k)/2)).^2;
%         end
%     end
% end

NumEl=numel(w);
for i=1:NumEl
    if(isnan(w(i)))
        w(i)=0;
    end
end

% k is the number of peaks
% c is the chroma (A,A#,B,etc.)
% n is the frame number
% Weighting function, w, needs to be k*n*c large
s=s.^2;
PCP=zeros(12,B);


% Pick out semitones
% Loop through each value of c (1,2,...,12)
% Find the corresponding rows to extract from w where semitone is 
% (1,2,...,12) multiply by Xn at that row at the corresponding row



s=s.^2;

for i=1:B %nFrames
    for j=0:11
        a=find(c(:,i)==j);
        PCP(12-j,i)=sum(w(a,i).*s(a,i));
        %PCP(i,j)=sum(w(i,:,:).*(
    end
    
end
PCP=bsxfun(@rdivide,PCP,sum(PCP));



if(nargin==2)
    h=figure;
    imagesc(PCP);
%     ylim([1,12]);
    ax=gca;
    ax.YTickLabel=fliplr({'A ','A#','B ','C ','C#','D ','D#','E ',...
        'F ','F#','G ','G#'});
    ax.YTick=linspace(1,12,12);
    colormap 'jet';
    title({'Chroma :'; filename});
    xlabel('frames');
    ylabel('Note');
    colorbar;
    saveas(gca,['NPCP' filename(6:end-4) '.png']);
    %     close(h);
end
end