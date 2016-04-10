%% Build everything necessary for report
clear filename images;
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
warning('off','MATLAB:Java:DuplicateClass');
pctRunOnAll javaaddpath java;
warning('on','MATLAB:Java:DuplicateClass');

tot=50*len;
ppm = ParforProgMon('JPEG Conversion: ', tot, 1, 500, 100);
parfor i=1:tot
    filename=imagesSlice{i};
    luminance=lumArray{i};
    lossFac=lossFactors(i);
    coeff=dctmgr(luminance,lossFac);
    luminance2=idctmgr(coeff,lossFac);
    % Plot the original image and idct image
    plot3Images(luminance,luminance2,filename,lossFac);
    ppm.increment(); %#ok<PFBNS>
end
ppm.delete();