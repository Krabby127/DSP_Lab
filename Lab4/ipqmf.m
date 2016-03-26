function [ recons ] = ipqmf( coefficients,filename)
%ipqmf Reconstructs the audio data
%   "coefficients" is a buffer that contains the coefficients as computed
%   by pqmf. The output array "recons" has the same size as the buffer
%   "coefficients", and contains the reconstructed audio data.

narginchk(1,2);
frameSize=576;
if(mod(length(coefficients),frameSize)~=0)
    error('ipqmf:invalidInputSize',...
        ['Invalid size for ''coefficients''.'...
        ' Length must be multiple of %d.'],frameSize);
end
for i=1:length(coefficients)
    if(mod(i,2)==0)
        coefficients(i)=-coefficients(i);
    end
end
audioSampleSize=32;
Ns=length(coefficients)/audioSampleSize;
% Because multiple of 576, Ns will be an integer

[~,D] = loadwindow(); %C is the analysis window, but is not needed
%D is the synthesis window
processingSize=64;
N=zeros(processingSize,audioSampleSize);

for i=0:processingSize-1
    for k=0:audioSampleSize-1
        N(i+1,k+1)=cos(((2*k+1)*(16+i)*pi)/64);
    end
end

recons=zeros(size(coefficients));
bufferSize=1024;

for n = 1:Ns
    V=zeros(1,bufferSize);
    U=zeros(size(D));
    Sj=zeros(audioSampleSize,1);
    for index=1:16
        Sk=coefficients(((0:audioSampleSize-1)*Ns)+n); % New subband samples
        V(65:bufferSize)=V((65:bufferSize)-64); % Shifting
        V(1:64)=sum(N(1:64,1:audioSampleSize)*Sk); % Matrixing
        
        for i=0:7 % Build a 512 values vector U
            for j=0:audioSampleSize-1
                U(i*64+j+1)=V(i*128+j+1);
                U(i*64+32+j+1)=V(i*128+96+j+1);
            end % end i=0:7
        end % end j=0:audioSampleSize-1
        W=D.*U; % Windows by 512 coefficients
        
        for j=0:audioSampleSize-1 % Calculate 32 samples
            Sj(j+1)=sum(W(j+audioSampleSize*(0:15)+1));
        end
        % Output 32 reconstructed PCM samples
        recons(((0:audioSampleSize-1)*Ns)+n)=Sj;
    end
end
recons=recons/(max(recons)*0.9); % Normalize it
if(nargin==2)
    hold on;
    audio=audioread(filename);
    h=figure;
    [~,name,ext]=fileparts(filename);
    plot(recons);
    title([name, ext, ' ipqmf']);
    xlabel('Sample');
    ylabel('Amplitude');
    hold off;
end
end