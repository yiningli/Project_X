optSystem = OpticalSystem;
optSystem.SurfaceArray(1).Glass = Glass('BK7');
optSystem.SurfaceArray(2) = [];
optSystem.SurfaceArray(1).Stop = 1;

wavLenInWavUnit = getPrimaryWavelength(optSystem);
fieldPointmatrix = optSystem.FieldPointMatrix;
fieldPointXYInLensUnit = (fieldPointmatrix(1,1:2))';
%nRay1 = 1129; nRay2 = 1130; % 1 001 043 rays
nRay1 = 1800; nRay2 = 1800;

pupSamplingType = 'Rectangular';
considerPolarization = 0;
considerSurfAperture = 1;
recordIntermediateResults = 1;
computeGroupPathLength = 0;
endSurface = getNumberOfSurfaces(optSystem);
tic
multipleRayTracer(optSystem,wavLenInWavUnit,fieldPointXYInLensUnit,...
        nRay1,nRay2,pupSamplingType,considerPolarization,...
        considerSurfAperture,recordIntermediateResults,computeGroupPathLength,endSurface);
toc