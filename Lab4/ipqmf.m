function [ recons ] = ipqmf( coefficients,filename,~)
%ipqmf Reconstructs the audio data
%   "coefficients" is a buffer that contains the coefficients as computed
%   by pqmf. The output array "recons" has the same size as the buffer
%   "coefficients", and contains the reconstructed audio data.

%% Validate input
narginchk(1,3);
frameSize=576;
if(mod(length(coefficients),frameSize)~=0)
    error('ipqmf:invalidInputSize',...
        ['Invalid size for ''coefficients''.'...
        ' Length must be multiple of %d.'],frameSize);
end
%% Setup
audioSampleSize=32;
processingSize=64;
bufferSize=1024;
Ns=length(coefficients)/audioSampleSize;
% Because multiple of 576, Ns will be an integer
N=zeros(processingSize,audioSampleSize);
for i=0:processingSize-1
    for k=0:audioSampleSize-1
        N(i+1,k+1)=cos(((2*k+1)*(16+i)*pi)/64);
    end
end

coefficients=buffer(coefficients,Ns); % Matrix is easier
[~,D] = loadwindow(); %C is the analysis window, but is not needed
%D is the synthesis window

%% Init vars
recons=zeros(audioSampleSize,Ns);
Buffer=zeros(bufferSize,1);

%% Do the magic
for packet = 1:Ns
    U=zeros(size(D));
    S=coefficients(packet,:); % extract subband
    if (mod(packet,2) == 1) % Act on every other packet
        channel = 1:2:32; % Invert every other coefficent
        S(channel) = -S(channel); % Invert coefficent
    end
    %% Shift Buffer
    Buffer((processingSize+1):bufferSize)=...
        Buffer(1:(bufferSize-processingSize));
    for i=0:processingSize-1
        Buffer(i+1) = sum(N(i+1,:).*S);
    end
    %% DSP Magic
    j=0:(audioSampleSize-1);
    for i=0:7
        U(i*64+j+1) = Buffer(i*128+j+1); % DSP magic
        U(i*64+32+j+1) = Buffer(i*128+96+j+1); % DSP magic
    end
    W=U.*D; % Windows by 512 coefficients
    
    for j=0:audioSampleSize-1 % Calculate 32 samples
        recons(j+1,packet) = sum(W((j+1) + audioSampleSize*(0:15)));
    end
end
% Output 32 reconstructed PCM samples
recons=recons(:); % Change back to vector
recons=recons/max(recons); % Normalize it

%% Plot the magic
if(nargin > 1)
    h=figure;
    hold on;
    audio=audioread(filename);
    plot(audio(1:length(recons)));
    xlabel('Samples');
    ylabel('Amplitude');
    [~,name,ext]=fileparts(filename);
    if(nargin == 2)
        plot(recons);
        title([name, ext, ' ipqmf Reconstruction']);
        legend('True audio','Reconstructed');
        saveas(h,[name,'_ipqmf.png']);
    end
    if(nargin == 3)
        plot(recons(489:end));
        title({[name, ext, ' ipqmf Reconstruction'],'Delay Fixed'});
        legend('True audio','Reconstructed (Fixed for delay)');
        saveas(h,[name,'_D_ipqmf.png']);
    end
    hold off;
    %     close(h);
end
end