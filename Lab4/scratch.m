% DEBUG=0;

filename=fullfile('lab4-data','sine1.wav');
info=audioinfo(filename);
% inputBuffer=audioread(filename,[1,info.SampleRate*5]);
[audio,fs]=audioread(filename,[1,info.SampleRate*5]);
frameSize=576;
% if(DEBUG)
%     firstNonZero=find(audio,1,'first'); % start at nonzero for debugging
%     audio=audio(firstNonZero:end);
% end

nFrame=floor(info.TotalSamples/frameSize);

[C,D] = loadwindow(); %C is the anforalysis window
%D is the synthesis window

M=zeros(32,64);
for k=0:31
    for r=0:63
        M(k+1,r+1)=cos(((2*k+1)*(r-16)*pi)/64);
    end
end

z=zeros(64*8,1);
y=zeros(1,64);
s=zeros(32,1);

% frameTemp=buffer(audio,576);
bufferSize=512;
% Buffer=zeros(size(C));
newBlock=zeros(32,1);
S=zeros(32,1);
coefficients=zeros(18*32,nFrame);
packet=0;
for frame = 1:nFrame          % chunk the audio into blocks of 576 samples
    offset = (frame -1)*frameSize+1;  % absolute address of the frame
    frameTemp=audio(offset:(offset+frameSize));
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
            S(channel)=-S(channel);
        end
        %         coefficients(packet+1;
        packet=packet+1; % counting inside double loop
    end % end index=1:18
    
end % end frame=1:nFrame