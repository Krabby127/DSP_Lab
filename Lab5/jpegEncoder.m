function [ symb ] = jpegEncoder( quant )
%dpegEncoder implements a variable length encoding scheme
%   nZeros is the number of zeros skipped since the last non zero
%   coefficient. We will modify the JPEG standard, and use 6 bits to
%   encode nZeros
%   nBits is the number of bits needed to encode the value of the
%   coefficient using two’s complement representation
%   Because the original image value f(x; y) is encoded using 8 bits,
%   we only need nBits = 11 to encode value.
%   The (0; 0) frequency (DC) coefficient is encoded differentially.
%   Because each DC coefficient can be as large as 2^11 - 2^3, each
%   difference is in the range [-2^11, 2^11-1], and thus we need as many
%   as nBits =12 bits to encode value.
%   value is the actual value of the coefficient encoded using two’s
%   complement representation in the range [-2^(nBits-1), 2^(nBits-1)-1]
%   If there will be no more non zero coefficients, then nZeros = 0, and
%   nBits = 0, and there is no value. This symbol is the EOB symbol.

if(numel(quant)~=64)
    warning('input must be 64 quantized coefficients');
end

% If the entire block is zero, simply output EOB
if(sum(quant)==0)
    symb=int16(0);
    return;
end

% The number of zeros since last nonzero coefficient
nZerosArray=diff(find([1;quant(:)]))-1;

% Indices of nonzero values
nonZeroVals=find(quant);
% The number of nonzero coefficients
num=numel(find(quant));


dcFlag=(quant(1)~=0);
% symStringSize has extra zeros
% symStringSize=ceil((num*21+dcFlag)/16)*16;
symStringSize=num*21+dcFlag;
symbString=repmat(char(0),1,symStringSize);
if(dcFlag)
    nZeros=bin(fi(nZerosArray(1),0,6,0));
    nBits=bin(fi(12,0,4,0));
    value=bin(fi(quant(1),1,12,0));
    component=[nZeros,nBits,value];
    symbString(1:22)=component;
end


nBits=bin(fi(11,0,4,0));

% Starts at 1 if quant(1)==0, starts at 2 otherwise
for i=(dcFlag)+1:num
    nZeros=bin(fi(nZerosArray(i),0,6,0));
    % Already have nBits
    value=bin(fi(quant(nonZeroVals(i)),1,11,0));
    component=[nZeros,nBits,value];
    startIndex=find(symbString,1,'last')+1;
    symbString(startIndex:(startIndex-1+21))=component;
end
%% Properly include EOB (End of Buffer)
% Check to see if padding is needed or if buffer will do that
% if mod>=4, then the buffer will automatically zero fill it
if(mod(symStringSize,16)<4)
    symbString(end:end+4) ='0';
end

% Zero pad "symbString"
% numInts=ceil(length(symbString)/16)*16+2;
debug=buffer(symbString(23:end),21);
temp=buffer(symbString,16);
temp=temp';
symb=zeros(1,length(temp),'int16');
for i=1:length(temp)
    symb(i)=int16(bin2sdec(temp(i,:)));
end
end