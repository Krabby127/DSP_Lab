function [ coefficients ] = pqmf( inputBuffer,~ )
%PQMF Implements the analysis filter bank
%   Takes an input "inputBuffers" that contains an integer number of frames
%   of audio data. The output array "coefficients" has the same size as the
%   buffer "inputBuffers", and contains the subband coefficients.
filenameFlag=0;
if(ischar(inputBuffer)) % I lied, it's actually the filename
    filenameFlag=1;
    filename=inputBuffer;
    info=audioinfo(filename);
    SampleTime=5;
    if(SampleTime>info.Duration)
        SampleTime=info.Duration;
    end
    inputBuffer=audioread(filename,[1,(info.SampleRate*SampleTime)]);
end
totalSamples=length(inputBuffer);
frameSize=576;
nFrame=floor(totalSamples/frameSize);
inputBuffer=inputBuffer(1:(nFrame*frameSize));
[C,~] = loadwindow(); %C is the analysis window
%D is the synthesis window, but is not needed

M=zeros(32,64);
for k=0:31
    for r=0:63
        M(k+1,r+1)=cos(((2*k+1)*(r-16)*pi)/64);
    end
end
Ns=18*nFrame;
bufferSize=512;
y=zeros(1,64);
S=zeros(32,1);

coefficients=zeros(size(inputBuffer));
packet=1; % counter for inner loop
for frame = 1:nFrame          % chunk the audio into blocks of 576 samples
    offset = (frame -1)*frameSize+1;  % absolute address of the frame
    frameTemp=inputBuffer(offset:(offset+frameSize-1));
    Buffer=zeros(size(C));
    for index = 1:18                % 18 non overlapping blocks of size 32
        Buffer(1:bufferSize-32)=Buffer(33:end);
        newBlock=frameTemp(((index-1)*32+1):index*32); % 32 new samples
        Buffer((bufferSize-31):end)=newBlock;
        % process a block of 32 new input samples
        % see flow chart in Fig. 2
        Z=C.*Buffer; % Window by 512 Coefficients to produce vector
        
        for i=0:63
            y(i+1)=sum(Z(i+64*(0:7)+1)); % Partial Calculation
        end
        
        for i=0:31
            S(i+1)=sum(M(i+1,:).*y); % Calculate 32 samples by matrixing
        end
        
        % Frequency inversion
        if(mod(index,2)==1)
            channel=1:2:32;
            S(channel)=-S(channel); % invert odd-numbered frequencies
        end
        % Spaced Ns apart
        coefficients(packet+(Ns*(0:31)))=S; % Assign coefficients
        
        packet=packet+1;
    end % end index=1:18
end % end frame=1:nFrame

coefficients=coefficients/max(coefficients); % Normalize



if(nargin==2 && filenameFlag)
    h=figure;
    [~,name,ext]=fileparts(filename);
    plot(coefficients);
    title([name, ext,' pqmf ', num2str(SampleTime) ' seconds']);
    xlabel('Coefficient');
    ylabel('Amplitude');
    saveas(gca,[name,'_',num2str(SampleTime),'sec.png']);
%     close(h);
end
end % end function