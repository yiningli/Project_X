function NAO = getObjectNA(optSystem,wavLen)
    % getObjectNA: returns object space NA of the optical system
    
    if nargin < 2
        wavLen = optSystem.getPrimaryWavelength;
    end
    systemApertureType = optSystem.SystemApertureType;
    systemApertureValue = optSystem.SystemApertureValue;
    entPupilLocation = getEntrancePupilLocation(optSystem);
    objectRefractiveIndex = optSystem.getSurfaceArray(1)...
        .Glass.getRefractiveIndex(wavLen);
    if abs(optSystem.getSurfaceArray(1).Thickness)>10^10
        objThick = 10^10;
    else
        objThick  = optSystem.getSurfaceArray(1).Thickness;
    end
    
    NAO = computeObjectNA...
        (systemApertureType,systemApertureValue,entPupilLocation,...
        objectRefractiveIndex,objThick);
end