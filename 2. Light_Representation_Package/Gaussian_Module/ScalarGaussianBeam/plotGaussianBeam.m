function [ plotted ] = plotGaussianBeam( gaussianBeamArray,plotType,nPoints1,nPoints2,axesHandle )
%PLOTGAUSSIANBEAM plots the amplitude, phase and intensity of a given
%gaussian beam or superposition of gaussian beam arrays
% plotType = 1(Amplitude),2(Intensity),3(Phase)
% medium: for computation of mediumImpedence: Intrinsic impedence of the 
% medium for intensity calculation = ratio |E|/|H|
% = 376.7 Ohms for free space

if nargin == 0
    disp('Error: The function plotGaussianBeam requires gaussian beam object.');
    plotted = NaN;
    return;
elseif nargin == 1 
    plotType = 1;
    nPoints1 = 50;
    nPoints2 = 64;
    figure;
    axesHandle = axes;
elseif nargin == 2 
    nPoints1 = 50;
    nPoints2 = 64;
    figure;
    axesHandle = axes;    
elseif nargin == 3 
    nPoints2 = 64;
    figure;
    axesHandle = axes;     
elseif nargin == 4
    figure;
    axesHandle = axes; 
end

mediumImpedence = 376.7;
% Compute the plotting range (3*standard deviation covers area > 99%)
E0 = [gaussianBeamArray.PeakAmplitude];
w0x = [gaussianBeamArray.WaistRadiusInX];
w0y = [gaussianBeamArray.WaistRadiusInY];
zx = [gaussianBeamArray.DistanceFromWaistInX];
zy = [gaussianBeamArray.DistanceFromWaistInY];
wavLen = [gaussianBeamArray.CentralRay.Wavelength];

[ wx,wy ] = getSpotRadius(gaussianBeamArray);
[ Rx,Ry ] = getRadiusOfCurvature(gaussianBeamArray);
[ guoyPhaseX,guoyPhaseY ] = getGuoyPhaseShift(gaussianBeamArray); 

xMax = 3*wx/sqrt(2);
yMax = 3*wy/sqrt(2);

maxR = max([xMax,yMax]);
r = (linspace(-maxR,maxR,nPoints1))';
phi = (linspace(0,2*pi,nPoints2));

x = r*cos(phi);
y = r*sin(phi);
    
%     
% xlin = linspace(-xMax,xMax,gridSize);
% ylin = linspace(-yMax,yMax,gridSize);
% [x,y] = meshgrid(xlin,ylin);


switch plotType
    case 1 % Amplitude
        amplitude = E0*((w0x/wx)*exp(-x.^2/wx^2)).*((w0y/wy)*exp(-y.^2/wy^2));
        output = amplitude;
    case 2 % Intensity
        intensity = ((E0*((w0x/wx)*exp(-x.^2/wx^2)).*((w0y/wy)*exp(-y.^2/wy^2))).^2)/mediumImpedence^2;
        output = intensity;
    case 3 % Phase
        phase = ((2*pi/wavLen)*zx + guoyPhaseX + (pi/wavLen)*(x.^2)/Rx)+...
            ((2*pi/wavLen)*zy + guoyPhaseY + (pi/wavLen)*(y.^2)/Ry);
        output = phase;
end
surf(axesHandle,x,y,output,'facecolor','interp',...
             'edgecolor','none',...
             'facelighting','phong');
view(2);
axis equal;
plotted = 1;
end

