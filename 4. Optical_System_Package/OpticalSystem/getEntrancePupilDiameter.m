function EntrancePupilDiameter = getEntrancePupilDiameter(optSystem,wavLen)
    % getEntrancePupilDiameter: returns EP diameter
    
    if nargin < 2
        wavLen = getPrimaryWavelength(optSystem);
    end
    systemApertureType = optSystem.SystemApertureType;
    systemApertureValue = optSystem.SystemApertureValue;
    entPupilLocation = getEntrancePupilLocation(optSystem);
    currentSurf = getSurfaceArray(optSystem,1);
    objectRefractiveIndex = getRefractiveIndex(currentSurf.Glass,wavLen);
    if abs(currentSurf.Thickness)>10^10
        objThick = 10^10;
    else
        objThick  = currentSurf.Thickness;
    end
    EntrancePupilDiameter = computeEntrancePupilDiameter...
        (systemApertureType,systemApertureValue,entPupilLocation, ...
        objectRefractiveIndex,objThick);
end