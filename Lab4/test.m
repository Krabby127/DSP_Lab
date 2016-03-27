filename=fullfile('lab4-data','sine1.wav');
info=audioinfo(filename);
coefficients=pqmf(filename);
[ recons ] = ipqmf( coefficients,filename);