function [ coeff ] = dctmgr( luminance )
%dctmgr Generates JPEG coefficients for given image
%   Takes a luminance (gray-level) image as an input, divides it into non
%   overlapping 8x8 blocks, and DCT transforms each block according to
%   F(u,v)=1/4*C_u*C_v sum(f(x,y)*Cos(((2x+1)*u*pi)/16) *
%   Cos(((2y+1)*v*pi)/16),  u,v=0,...,7
%   for a given block b, the coefficients of the column coeff(:,b) are
%   organized in a zig-zag pattern
%   The zero-frequency coefficients, F(1,1), for each block is encoded
%   using differential encoding:
%   coeff(1,1)=F_1(1,1); coeff(1,2)=F_2(1,1)-F_1(1,1);
%   where F_i(1,1) is the zero frequency DCT coefficient of block i

%% Validate input
[a,b]=size(luminance);
if(mod(a,8)||mod(b,8))
    error('Length and width of ''luminance'' must both be multiples of 8');
end
if(a~=b)
    error('''luminance'' must be a square matrix');
end

%% Process using "blockProc"

fun = @(block_struct) dct2(block_struct.data);
% Output is same size as input
temp = blockproc(luminance,[8,8],fun,'UseParallel',1);
% Divides into N_blocks cells of size [8x8]
temp2=mat2cell(temp,repmat(8,1,a/8),repmat(8,1,b/8));
% Creates a vector of N_blocks many cells of size [64x1]
y=cellfun(@toZigzag,temp2,'UniformOutput',false);
% F(a,:)=y{a}
F=cell2mat(y);
% Computes the DC component
coeff=diff([0,F(1,:)]);
end