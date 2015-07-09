function [ chiefRayTraceResult,chiefRay ] = traceChiefRay( optSystem,fieldPointXYInSI,wavLenInM,considerSurfAperture,recordIntermediateResult )
%TRACECHIIFRAY Computes the chief ray and traces it theough the
% given system
% fieldPointXYInSI,wavLenInM are measured in SI unit (meter and degree for angles)
% Deafault inputs
if nargin < 1
    disp('Error: The function traceChiefRay needs atleast optical system');
    chiefRayTraceResult = NaN;
    chiefRay = NaN;
    return;
elseif nargin == 1
    % Take all field points and primary wavelength
    nField = optSystem.NumberOfFieldPoints;
    fieldPointMatrix = optSystem.FieldPointMatrix;
    
    fieldPointXY = (fieldPointMatrix(:,1:2))';

    switch lower(optSystem.FieldType)
        case lower('ObjectHeight')
            % Change to field points to meter
            fieldPointXYInSI = fieldPointXY*getLensUnitFactor(optSystem);
        case lower('Angle')
            % Field values are in degree so Do nothing.
            fieldPointXYInSI = fieldPointXY;
    end
        
    wavLenInM = repmat(getPrimaryWavelength(optSystem),[1,nField]);

    considerSurfAperture = 1;
    recordIntermediateResult = 1;
elseif nargin == 2 
    % Take the primary wavelength
    nField = size(fieldPointXY,2);
    wavLenInM = repmat(getPrimaryWavelength(optSystem),[1,nField]);
    considerSurfAperture = 1;    
    recordIntermediateResult = 1;
elseif nargin == 3
    considerSurfAperture = 1; 
    recordIntermediateResult = 1;
elseif nargin == 4
    recordIntermediateResult = 1;
end
considerPolarization = 0;
chiefRay = getChiefRay(optSystem,fieldPointXYInSI,wavLenInM);
chiefRayTraceResult = rayTracer(optSystem,chiefRay,considerPolarization,considerSurfAperture,recordIntermediateResult);
end

