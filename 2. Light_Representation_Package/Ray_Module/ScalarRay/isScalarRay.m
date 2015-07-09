function [ isScalarRay ] = isScalarRay( currentScalarRay )
    %ISScalarRay Summary of this function goes here
    %   Detailed explanation goes here
    isScalarRay = 0;
    if isstruct(currentScalarRay)
        if isfield(currentScalarRay,'ClassName') && strcmpi(currentScalarRay.ClassName,'ScalarRay')
           isScalarRay = 1; 
        end
    else
        if strcmpi(class(currentScalarRay),'ScalarRay')
            isScalarRay = 1; 
        end
    end
    
end

