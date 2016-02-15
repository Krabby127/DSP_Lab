%build everything necessary for report
clear Xk fbank filename mfccp specHistogram mfcc;
close all;
fileArray = cellstr([
    'track201-classical.wav '; ...
    'track204-classical.wav '; ...
    'track370-electronic.wav'; ...
    'track396-electronic.wav'; ...
    'track437-jazz.wav      '; ...
    'track439-jazz.wav      '; ...
    'track463-metal.wav     '; ...
    'track492-metal.wav     '; ...
    'track547-rock.wav      '; ...
    'track550-rock.wav      '; ...
    'track707-world.wav     '; ...
    'track729-world.wav     '
    ]);
fbank=melBank(1);
parfor i=1:12
    filename=['' fileArray{i} '']
    Xk=freqDist(filename);
    mfccp=mfcc(fbank, filename);
    specHistogram=spectrumHistogram(filename,1);
    sim=simMatrix(filename,1);
    rhythmIndex(filename,1);
    autoC(filename,1);
end