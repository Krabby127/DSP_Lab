function [a] = bin2sdec(binStr)
%bin2sdec converts a signed binary stream to an int
if(binStr(1)=='1')
    a=bin2dec(binStr(2:end))-pow2(length(binStr)-1);
else
    a=bin2dec(binStr(2:end));
end
end