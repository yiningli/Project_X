function [ finalPolarizationVector ] = computeFinalPolarizationVector(...
    rayTraceResultFinal,initialPolVector, wavLen)
%COMPUTEFINALPOLARIZATIONVECTOR Computes the final polarization vector in
% global coordinate given the initialPolVector in global xyz coordinate

    % normalize the given jones vector and convert to Polarization Vector
    % normalizedPolVector = normalizeJonesVector(initialPolVector);
    
    % Shall be changed or checked
    nRayTraceResult = length(rayTraceResultFinal);
    initialPolarizationVector = initialPolVector;
    totalPMatrix = reshape([rayTraceResultFinal.TotalPMatrix],3,3,nRayTraceResult);
    
    % Compute the field including all effects 
    % 1. Complex amplitude coefficients due to interface + coating
    nRay = size(initialPolarizationVector,2);
    polarizationVector1 = squeeze(multiplySliced3DMatrices(totalPMatrix,reshape(initialPolarizationVector,[3,1,nRay])));
    % 2. Effect of OPL
    k0 = 2*pi./wavLen;
    OPL = [rayTraceResultFinal.TotalOpticalPathLength];
    polarizationVector2 = polarizationVector1.*repmat(exp(1i*k0*OPL),[3,1]);
    % 3. Effect of Absorption
    
    finalPolarizationVector = polarizationVector2;   
end

