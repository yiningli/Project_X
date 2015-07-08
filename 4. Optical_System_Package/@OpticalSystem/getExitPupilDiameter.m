function ExitPupilDiameter = getExitPupilDiameter(optSystem,wavLen)
    % getExitPupilDiameter: returns EXP diameter
    if nargin < 2
        wavLen = getPrimaryWavelength(optSystem);
    end
    entPupDiam = getEntrancePupilDiameter(optSystem,wavLen);
    angMag = getAngularMagnification(optSystem,wavLen);
    ExitPupilDiameter = abs(entPupDiam/angMag);
end