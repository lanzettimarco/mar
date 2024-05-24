function [Px,f] = frequency_domain(x,Fs,type)
%FREQUENCY_DOMAIN calculates the power spectrum.
%
% -- Inputs:
%            - x: Time domain signal
%            - Fs: [Sa/s] Sampling frequency
%            - type: 'single' (single-sided power) or 'double' (double-sided power)
%
% -- Outputs:
%            - Px: Power spectrum
%            - f: [Hz] Frequency vector

L = length(x);
NFFT = 2^nextpow2(L);
X = fft(x,NFFT)/L;

if strcmp(type,'double')
    f = Fs/2*linspace(-1,1,NFFT);
    Px = fftshift(abs(X).^2);
elseif strcmp(type,'single')
    f = Fs/2*linspace(0,1,NFFT/2+1);
    Px = abs(X(1:NFFT/2+1)).^2;
    Px(2:end-1) = 2*Px(2:end-1);
else
    error('Error in type.');
end
end
