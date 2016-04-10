%% Build everything necessary for report
clear filename images luminance luminance 2 lossFactors lumArray coeff ...
    tot len lossFac;
close all;
images=setupFiles();

%% Slice filenames for parallelization
imagesSlice=repmat(images,[1,50]);
len=length(images);

%% Slice luminance for parallelization
lumArray=cell(1,len);
for i=1:len
    lumArray{i}=imread(images{i});
end
lumArray=repmat(lumArray,[1,50]);

%% Slice lossFactors for parallelization
lossFactors=1:50;
lossFactors=repmat(lossFactors,[len,1]);

%% Runs through all the files at all loss-factors
try
    parpool;
catch e
end
warning('off','MATLAB:Java:DuplicateClass');
pctRunOnAll javaaddpath java;
warning('on','MATLAB:Java:DuplicateClass');
tot=50*len;
ppm = ParforProgMon('JPEG Conversion: ', tot, 1, 500, 100);
peaksnr=zeros(len,50);
parfor i=1:tot
    filename=imagesSlice{i};
    luminance=lumArray{i};
    lossFac=lossFactors(i);
    coeff=dctmgr(luminance,lossFac);
    luminance2=idctmgr(coeff,lossFac);
    if((lossFac==1)||(lossFac==10)||(lossFac==20))
        % Plot the original image and idct image
        plot3Images(luminance,luminance2,filename,lossFac);
    end
    ppm.increment(); %#ok<PFBNS>
    a=mod(i,len)+1;
    peaksnr(i)=psnr(luminance2,luminance);
end
ppm.delete();

%% Plots the PSNR
h=figure;
hold on;
for i=1:len
    plot(peaksnr(i,:));
end
legend(images,'Interpreter','none')
title('Peak Signal Noise Ratio');
xlabel('Loss Factor');
ylabel('PSNR (dB)');
saveas(h,'psnr.png');
hold off
close(h);