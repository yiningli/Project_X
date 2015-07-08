
% %% computeLinePlaneIntersection
% linePoint = [0,0,-2]';lineVector=[0,cosd(45),cosd(45)]';planePoint=[0,0,0]';planeNormalVector=[0,0,1]';
% [linePlaneIntersection,distance] = computeLinePlaneIntersection(linePoint,lineVector,planePoint,planeNormalVector)
%%
c = 299792458;
% fOpticalSystemName = which ('TestGratingPair.mat');  
% fOpticalSystemName = which ('SingleSurface.mat'); 

fOpticalSystemName = which ('GratingStrecherImportedFromZMX.mat');  
% fOpticalSystemName = which ('GratingCompressorImportedFromZMX.mat'); 


optSystem = OpticalSystem(fOpticalSystemName);

fieldIndex = 1;
delta_wav = 10*10^-9;
wav0 = optSystem.getPrimaryWavelength;
wavelengthVectorInM = [wav0, wav0 + delta_wav];
[ geometricalOpticalGroupPathLength ] = ...
    computePathLengths( optSystem, fieldIndex, wavelengthVectorInM)

deltaTfromPath = -(geometricalOpticalGroupPathLength(1,2)-geometricalOpticalGroupPathLength(2,2))/(c);

delta_x0 = 0;
delta_y0 = 0;
delta_dx0 = 0;
delta_dy0 = 0;
delta_t0 = 0;
delta_f0 = -(c/wav0^2)*delta_wav;
[ delta_x,delta_y, delta_dx,delta_dy,delta_t,delta_f ] = ...
    compute3DRayPulseVector(optSystem,delta_x0,delta_y0,delta_dx0,delta_dy0,...
    delta_t0,delta_f0);
deltaTfromPath
delta_t
delta_f0
gdd1 = deltaTfromPath/(2*pi*delta_f0)
gdd2 = delta_t/(2*pi*delta_f0)