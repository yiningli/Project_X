function NAI = getImageNA(optSystem,wavLen)
    % getImageNA: returns image space NA of the optical system
    if nargin < 2
        wavLen = getPrimaryWavelength(optSystem);
    end
    exitPupilLocation = getExitPupilLocation(optSystem,wavLen);
    exitPupilDiameter = getExitPupilDiameter(optSystem,wavLen);
    numberOfSurfaces = getNumberOfSurfaces(optSystem);
    imageRefractiveIndex = optSystem.getSurfaceArray(numberOfSurfaces-1)...
        .Glass.getRefractiveIndex(wavLen);
    imageThick = optSystem.getSurfaceArray(numberOfSurfaces-1). ...
        Thickness;
    paraxialImageDistance = getParaxialImageLocation(optSystem);
    NAI = computeImageNA...
        (exitPupilLocation,exitPupilDiameter, imageRefractiveIndex,...
        imageThick, paraxialImageDistance);
end