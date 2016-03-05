function [ specHistogram ] = spectrumHistogram(filename,mfccp,genre, ~)
%SpectrumHistogram Constructs a 40x50 spectrum histogram
%   Construct a two-dimensional spectrum histogram (a matrix of counts),
%   with 40 columns - one for each mfcc index, and 50 rows - one for each
%   amplitude level, measured in dB, from -20 to 60 dB. You will normalize
%   the histogram, such that the sum along each column (for each "note")
%   is one.
mfccp=10*log10(mfccp);
[a,~]=size(mfccp);
if(a ~= 40)
    errorStruct.message = 'mfccp should have 40 rows';
    errorStruct.identifier = 'SpectrumHistogram:WrongSize';
    error(errorStruct);
end
bottom=min(min(mfccp));
top=max(max(mfccp));
specHistogram = zeros(50,40);
dbSlots = linspace(bottom,top,51);

for i=1:50 %50
    
    for j=1:a % 40 (numBanks)
        specHistogram(i,j)=numel(find(mfccp(j,:)>dbSlots(i)...
            & mfccp(j,:)<dbSlots(i+1)));
        
    end
end

% Normalize function between 0 and 1
colTotal=sum(specHistogram);
for i=1:a %40
    specHistogram(:,i)=specHistogram(:,i)/colTotal(i);
end
[~,name,ext] = fileparts(filename);
% Option to plot and save figure
if(nargin == 4)
    h=figure;
    imagesc(specHistogram);
    ax=gca;
    xlabel('MFCC index');
    ylabel('Amplitude level (dB)');
    title({'Spectrum Histogram:';genre ' ' name ext});
    ax.YTick = flipud(linspace(0,50,11));
    ax.YTickLabel = fliplr({'-20 dB' '-12 dB' '-4 dB' '4 dB' '12 dB'...
        '20 dB' '28 dB' '36 dB' '44 dB' '52 dB' '60 dB'});
    c=colorbar;
    colormap 'jet';
    c.Label.String = 'Percent Occurrences of each MFCC coeff.';
    saveas(gca,['specHistogram' genre name '.png']);
    close(h);
end
end