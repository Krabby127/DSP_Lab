function [ B ] = zigzag( M )
%zigzag Transforms the array to a vector in zig zag order
%  From stack overflow (https://goo.gl/9sqGkg)

a=numel(M);

ind = reshape(1:a, size(M));                % indices of elements
ind = fliplr( spdiags( fliplr(ind) ) );     % get the anti-diagonals
ind(:,1:2:end) = flipud( ind(:,1:2:end) );  % reverse order of odd columns
ind(ind==0) = [];                           %# keep non-zero indices

B=M(ind);                                   % get elements in zigzag order
end