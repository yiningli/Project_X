function [ surfaceSag1,surfaceSag2 ] = getSurfaceSag( surface,xyCoordinateMeshgrid,actualSurfacePointIndices )
    %GETSURFACESAG returns the surface sag in local coordinate for the given
    %local xy coordinates
    % Inputs:
    %   (surface,xyCoordinateMeshgrid,actualSurfacePointIndices )
    % Outputs:
    %   [surfaceSag1,surfaceSag2]
    
    % <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    %   Written By: Worku, Norman Girma
    %   Advisor: Prof. Herbert Gross
    %	Optical System Design and Simulation Research Group
    %   Institute of Applied Physics
    %   Friedrich-Schiller-University of Jena
    
    % <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
    % Date----------Modified By ---------Modification Detail--------Remark
    % Jun 17,2015   Worku, Norman G.     Original Version
    
    surfaceType = surface.Type;
    surfaceParameters = surface.UniqueParameters;
    rayPosition = [];
    rayDirection = [];
    indexBefore = [];
    indexAfter = [];
    wavlenInM = [];
    surfaceNormal = [];
    reflection = [];
    % Connect the surface definition function
    surfaceDefinitionHandle = str2func(surfaceType);
    returnFlag = 'SSAG';
    [ z1,z2] = surfaceDefinitionHandle(...
        returnFlag,surfaceParameters,rayPosition,rayDirection,indexBefore,...
        indexAfter,wavlenInM,surfaceNormal,reflection,xyCoordinateMeshgrid);
    % z values will be complex for points outside the actual surface.
    % So replace the complex z values with the neighboring values
    realSag = real(z1);
    
    realSag1 = realSag(actualSurfacePointIndices);
    extremeZ = realSag1(1);
    realSag(~actualSurfacePointIndices) = extremeZ;
    
    surfaceSag1 = realSag;
    surfaceSag2 = realSag;
end

