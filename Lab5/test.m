images=setupFiles();
filename=images{1};
luminance=imread(filename);
f=luminance;

try
    parpool;
catch e
end