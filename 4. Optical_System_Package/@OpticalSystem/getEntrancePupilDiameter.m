function EntrancePupilDiameter = getEntrancePupilDiameter(optSystem,wavLen)
    % getEntrancePupilDiameter: returns EP diameter
    
    if nargin < 2
        wavLen = getPrimaryWavelength(optSystem);
    end
    systemApertureType = optSystem.SystemApertureType;
    systemApertureValue = optSystem.SystemApertureValue;
    entPupilLocation = optSystem.getEntrancePupilLocation;
    objectRefractiveIndex = optSystem.getSurfaceArray(1)...
        .Glass.getRefractiveIndex(wavLen);
    if abs(optSystem.getSurfaceArray(1).Thickness)>10^10
        objThick = 10^10;
    else
        objThick  = optSystem.getSurfaceArray(1).Thickness;
    end
    EntrancePupilDiameter = computeEntrancePupilDiameter...
        (systemApertureType,systemApertureValue,entPupilLocation, ...
        objectRefractiveIndex,objThick);
end