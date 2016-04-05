Cu=[(1/sqrt(2)),1,1,1,1,1,1,1];
Cv=Cu;
filename='images/barbara.pgm';
F=zeros(8,8);
f=imread(filename);
f=f(1:8,1:8);
for u=0:7
    for v=0:7
        for x=0:7
            for y=0:7
                F(u+1,v+1)=F(u+1,v+1)+(f(x+1,y+1)*cos((2*x+1)*u*pi/16)*...
                    cos((2*y+1)*v*pi/16));
            end
        end
        F(u+1,v+1)=F(u+1,v+1)*(0.25*Cu(u+1)*Cv(v+1));
    end
end

ind = reshape(1:numel(M), size(M));         %# indices of elements
ind = fliplr( spdiags( fliplr(ind) ) );     %# get the anti-diagonals
ind(:,1:2:end) = flipud( ind(:,1:2:end) );  %# reverse order of odd columns
ind(ind==0) = [];                           %# keep non-zero indices

M(ind)                                      %# get elements in zigzag order