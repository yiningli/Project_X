function [ complexFFT2DofE ] = computeFFT2D( complexE ,delta)
%COMPUTEFFT2D returns the FFT2 of complex E
% Ref: Schmidt Numerical simulation of optical wave propagation

complexFFT2DofE = fftshift(fft2(fftshift(complexE)))*delta.^2;
end

