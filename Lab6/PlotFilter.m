%% Coefficients from Assignment 11 (Lab 6)
b=[-1,1,3,1,-1];
a=[8,4,4,4,8];

h=fvtool(b,a);
h.Fs=8000;
h.NormalizeMagnitudeto1='on';
h.Legend='on';
h.Analysis='freq';