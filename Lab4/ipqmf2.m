function [ recons ] = ipqmf2( coefficients )
%% Reconstructs audio sample from a subband coefficent vector
% Reconstructs audio sample (recons)
% (coefficents) subband coefficent vector
% Coefficents are sorted into bands ordered by the packet

%% Setup
[~,D] = loadwindow; % Load Window
Npackets = length(coefficients)/32; % Number of packets in coefficents
coefficients = buffer(coefficients,Npackets); % Reshape coefficent vector into a matrix
Nk = zeros(64,32);
for i = 0:63
    Nk(i+1,:) = cos((2*(0:31)+1)*(16+i)*pi/64); % Produce Modulation Matrix
end
%% Initialize
recons = zeros(32,Npackets); % Initialize reconstruction matrix
Buffer = zeros(1024,1); % Initialize Buffer variable
%% Loop through each packet to calculate 32 reconstructed audio samples
for packet = 1:Npackets
    S = coefficients(packet,:); % get subband coefficents for the current packet
    %% Frequency inversion
    if (mod(packet,2) == 1) % Act on every other packet
        channel = 1:2:32; % Invert every other coefficent
        S(channel) = -S(channel); % Invert coefficent
    end
    %% Shift Buffer
    Buffer(65:1024) = Buffer(1:960); % Shift buffer to the right
    for i = 0:63
        Buffer(i+1) = sum(Nk(i+1,:).*S); % Add new data to Buffer
    end
    %% Calculation
    j = 0:31;
    for i = 0:7
        U(i*64+(j+1)) = Buffer(i*128+(j+1)); % Produce Values Vector
        U(i*64+32+(j+1)) = Buffer((i*128)+96+(j+1)); % Produce Values Vector
    end
    W = U.*D; % Window Values Vector
    for j = 0:31
        recons(j+1,packet) = sum(W((j+1) + 32*(0:15))); % Construct Reconstruction Matrix
    end
end
recons = recons(:); % Reshape Reconstruction matrix into vector
end

