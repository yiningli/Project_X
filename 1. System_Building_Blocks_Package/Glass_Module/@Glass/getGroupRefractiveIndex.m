function [ groupIndex ] = getGroupRefractiveIndex( glass,wavLen )
    % GETGROUPREFRACTIVEINDEX Computes the group refractive index of the glass
    % for the pulse with central wavelength given.
    % Formula used: Group_Index = n(wavLen) + wavLen*dn/dwavLen
    
    % Inputs:
    %   (glass,wavLenInM,derivativeOrder)
    % Outputs:
    %   [refractiveIndex]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version

    groupIndex = getRefractiveIndex(glass,wavLen,0) - (wavLen).*getRefractiveIndex(glass,wavLen,1);    
end

