clear, clc, close all;

addpath("functions/")

%% System input parameterssssssssssssssssssssssss
fs = 4e9;           % [Hz] Sampling frequency
% Sensing
Tc = 1e-3;          % [s] Chirp time
Bc = 60e6;          % [Hz] Chirp bandwidth
Np = 2e3;           % # of chirps averaged per measurement (per frequency)
f1 = 167e9;         % [Hz] Off-line frequency
f2 = 174.8e9;       % [Hz] On-line frequency
% Communication
Ns = 100;           % # of symbols per chirp
alpha = 0.1;        % Symbol roll off factor (if symbols are pulse shaped)
M = 2;              % Modulation order
modScheme = 'QAM';  % Modulation scheme (PSK or QAM)

%% Calculated parameters
Ts = Tc/Ns;  % [s] Symbol period
Rs = 1/Ts;   % [Bd] Symbol rate
b = log2(M); % # bits per symbol

%% Bandwidth verification
if Rs > Bc/(1+alpha)
    throw(MException('Symbol bandwidth exceeds chirp bandwidth'))
end

%% Tx waveform
s = dar_modulation();   % Complex baseband samples without communication
% s = jcs_modulation();   % Complex baseband samples with DAR+CSS


% DAR Inputs
power_e = ones(520,2);  % [W] Power measurements, averaged across pulses
r = ones(520,1);  % [km] radar ranges for which the reflectivity 
                  % measurements at all frequencies have SNR greater than 1

