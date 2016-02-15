function [ specHistogram ] = spectrumHistogram(filename,~)
%SpectrumHistogram Constructs a 40x50 spectrum histogram
%   Construct a two-dimensional spectrum histogram (a matrix of counts),
%   with 40 columns - one for each mfcc index, and 50 rows - one for each
%   amplitude level, measured in dB, from -20 to 60 dB. You will normalize
%   the histogram, such that the sum along each column (for each "note")
%   is one.
fbank=melBank();
mfccp=mfcc(fbank,filename);
[a,b]=size(mfccp);
if(a ~= 40)
    errorStruct.message = 'mfccp should have 40 rows';
    errorStruct.identifier = 'SpectrumHistogram:WrongSize';
    error(errorStruct);
end

specHistogram = zeros(50,40);
dbSlots = linspace(-20,60,50);
% Find closest dbSlots index
for i = 1:a
    for j=1:b
        val = mfccp(i,j);
        tmp=abs(dbSlots-val);
        [~,index]=min(tmp);
        specHistogram(index,i)=specHistogram(index,i)+1;
    end
end

% Normalize function between 0 and 1
for i=1:a
    specHistogram(:,i)=specHistogram(:,i)/sum(specHistogram(:,i));
end

% Option to plot and save figure
if(nargin == 2)
    h=figure;
    imagesc(flipud(specHistogram));
    ax=gca;
    xlabel('MFCC index');
    ylabel('Amplitude level (dB)');
    title({'Spectrum Histogram:'; filename});
    ax.YTick = flipud(linspace(0,50,11));
    ax.YTickLabel = fliplr({'-20 dB' '-12 dB' '-4 dB' '4 dB' '12 dB'...
        '20 dB' '28 dB' '36 dB' '44 dB' '52 dB' '60 dB'});
    c=colorbar;
    colormap 'jet';
    c.Label.String = 'Percent Occurrences of each MFCC coeff.';
    saveas(gca,['SpecHistogram' filename(6:end-4) '.png']);
    close(h);
end
end