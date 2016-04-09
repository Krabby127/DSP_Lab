function [ luminance,F,temp,temp2 ] = idctmgr( coeff )
%idctmgr Performs the inverse discrete cosine transform and reconstructs

%% Validate inputs
[a,NBlocks]=size(coeff);
if(a~=64)
    error('''coeff'' must have 64 rows');
end

NLength=round(sqrt(NBlocks));
if NLength*NLength~=NBlocks
    error('number of columns must be a perfect square');
end

%% Allow multiple outputs for testing purposes
nargoutchk(1,4);

%% Reverse DC Coefficients
coeff(1,:)=cumsum(coeff(1,:));

%% Reconstruct original matrix shape
F=cell(sqrt(NBlocks));
for i=1:NBlocks
    % This is simply easier for me to visualize
    F(i)=num2cell(invZigzag(coeff(:,i)),[1,2]);
end
% Temp should be equal to the original image after dct2
temp=cell2mat(F);
temp2=temp;
% Reverse the DC calculation
% for i=1:8:64
%     temp(i,:)=cumsum(temp(i,:));
% end
%% Process using "blockProc"
fun = @(block_struct) idct2(block_struct.data);
luminance=blockproc(temp,[8,8],fun,'UseParallel',1);
% Convert to 8 bit unsigned integer
luminance=typecast(luminance,'uint8');
end