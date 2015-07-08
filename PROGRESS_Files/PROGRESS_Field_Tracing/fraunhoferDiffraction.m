function [ Uout x2 y2 ] = fraunhoferDiffraction( Uin, wvl, d1, Dz )
%FRAUNHOFERDIFFRACTION 
% Ref: Schmidt Numerical simulation of optical wave propagation
% r1 = (x1; y1) source-plane coordinates
% r2 = (x2; y2) observation-plane coordinates
% wvl wavelength
% d1 grid spacing in source plane
% d2 grid spacing in observation plane
% Dz distance between source plane and observation plane

 N = size(Uin, 1); % assume square grid
 k = 2*pi / wvl; % optical wavevector
 fX = (-N/2 : N/2-1) / (N*d1);
 % observation-plane coordinates
 [x2 y2] = meshgrid(wvl * Dz * fX);
 clear('fX');
 Uout = exp(1i*k/(2*Dz)*(x2.^2+y2.^2)) ...
 / (1i*wvl*Dz) .* computeFFT2D(Uin, d1);
end

