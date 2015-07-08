function [ returnData1, returnData2, returnData3] = Standard(...
    returnFlag,surfaceParameters,rayPosition,rayDirection,...
    indexBefore,indexAfter,wavlenInM,surfNormal,reflection,xyCoordinateMeshGrid,...
    refWavlenInM,paraxialRayParameter,reverseTracing)
%STANDARD Standard surface definition
% surfaceParameters = values of {'Radius','Conic','GratingLineDensity','DiffractionOrder'}

% paraxialRayParameter: 2xN matrix of paraxial heigh and angle [y,u]
% reverseTracing: boolean indicating direction of ray trace (currently
% supported only for paraxial tracing)

% returnFlag : A four char word indicating what is requested 
% ABTS: About the surface 
% SSPB: Surface specific 'BasicSurfaceDataFields' table field names and initial values in Surface Editor GUI 
% SSPE: Surface specific 'Extra Data' table field names and initial values in Surface Editor GUI 
% PLTS: Return path length to the surface intersection points for given 
% SIAN: Return the surface intersection points and surface normal for given incident Ray parameters
% SSAG: Return the surface sag at given xyGridPoints % Used for plotting the surface 
% GRTY: Returns the grid type to be used for ploting 'Rectangular' or 'Polar' 
% EXRD: Returns the exit ray direction 
% EXRP: Returns the exit ray position 
% PRYT: Returns the output paraxial ray parameters 

%% Default input vaalues
if nargin == 0
    disp('Error: The function Standard() needs atleat the return type.');
    returnData1 = NaN;
    returnData2 = NaN;
    returnData3 = NaN;
    return;
elseif nargin == 1
    if strcmpi(returnFlag,'ABTS') || strcmpi(returnFlag,'SSPB') || strcmpi(returnFlag,'SSPE') || strcmpi(returnFlag,'GRTY')
        surfaceParameters = [];
        rayPosition = [];
        rayDirection = [];
        xyCoordinateMeshgrid = [];       
    else
        disp('Error: Missing input argument for Standard().');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;        
    end
elseif nargin == 2
    if strcmpi(returnFlag,'ABTS') || strcmpi(returnFlag,'SSPB') || strcmpi(returnFlag,'SSPE') || strcmpi(returnFlag,'GRTY')
        surfaceParameters = [];
        rayPosition = [];
        rayDirection = [];
        xyCoordinateMeshgrid = [];       
    else
        disp('Error: Missing input argument for Standard().');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;        
    end        
elseif nargin == 3
    if strcmpi(returnFlag,'ABTS') || strcmpi(returnFlag,'SSPB') || strcmpi(returnFlag,'SSPE') ||  strcmpi(returnFlag,'GRTY')
        surfaceParameters = [];
        rayPosition = [];
        rayDirection = [];
        xyCoordinateMeshgrid = [];       
    else
        disp('Error: Missing input argument for Standard().');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;        
    end
elseif nargin == 4
    if strcmpi(returnFlag,'ABTS') || strcmpi(returnFlag,'SSPB') || strcmpi(returnFlag,'SSPE')|| strcmpi(returnFlag,'PLTS') || strcmpi(returnFlag,'SIAN') || strcmpi(returnFlag,'GRTY')
        xyCoordinateMeshgrid = [];       
    else
        disp('Error: Missing input argument for Standard().');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;        
    end        
else
end

%%
switch upper(returnFlag)
    case 'ABTS' % About the surface ABTS
        returnData1 = {'Standard','STND'}; % display name
        % look for image description in the current folder and return 
        % full address 
        [pathstr,name,ext] = fileparts(mfilename('fullpath'));
        returnData2 = {[pathstr,'\Surface.jpg']};  % Image file name
        returnData3 = {['Standard: Used to define standard conical surfaces.']};  % Text description   

    case 'SSPB' % 'BasicSurfaceDataFields' table field names and initial values in Surface Editor GUI 
        % Shall be = 10 Unused fields are also allowed but should be
        % written unused
        returnData1 = {'Radius','Conic','GratingLineDensity','DiffractionOrder'};
        returnData2 = {{'numeric'},{'numeric'},{'numeric'},{'numeric'}}; 
        defaultSurfUniqueStruct = struct();
        defaultSurfUniqueStruct.Radius = Inf;
        defaultSurfUniqueStruct.Conic = 0;
        defaultSurfUniqueStruct.GratingLineDensity = 0;
        defaultSurfUniqueStruct.DiffractionOrder = 0;
        returnData3 = defaultSurfUniqueStruct;
    case 'SSPE' % 'Extra Data' table field names and initial values in Surface Editor GUI
        returnData1 = {'Unused'};
        returnData2 = {{'numeric'}}; 
        returnData3 = {[0]};               
    case 'PLTS' % Return path length to the surface intersection points for given 
        % incident Ray parameters
        % To compute path length general iterative method can be used in
        % gereal case but for standard surface analytic solution is
        % possible.
        surfaceRadius = surfaceParameters.Radius;
        surfaceConic = surfaceParameters.Conic;            
        [geometricalPathLength,NoIntersectioPoint] = computeStandardSurfacePath ...
            (rayPosition,rayDirection,surfaceRadius,surfaceConic);
        
        % Additional phase shift due to grating
        surfaceGratingLineDensity = surfaceParameters.GratingLineDensity;
        gratingOrder = surfaceParameters.DiffractionOrder;
        % similar formula used in Zemax  usgdcyl.c user defined surface
        % file
        gratingAdditionalPath = (rayPosition(2,:).*wavlenInM*(gratingOrder)*surfaceGratingLineDensity*10^6)./indexBefore;
        
        returnData1 = geometricalPathLength;
        returnData2 = NoIntersectioPoint;
        % currently the additional path due to grating is ignored 
        gratingAdditionalPath = 0; % Not sure
        returnData3 = gratingAdditionalPath; % Since rayPosition is in lens unit 
                                         % this result is also in lens unit
    case 'SIAN'  % Return the surface intersection points and surface normal for given incident Ray parameters
        % For standard surfaces the intersection points can be easily
        % computed from the path length and initial ray parameters  
        surfaceRadius = surfaceParameters.Radius;
        surfaceConic = surfaceParameters.Conic; 
        % since geometric path length computation doesn't require the
        % refractive index data
        indexBefore = NaN;
        indexAfter = NaN;
        wavlenInM =  NaN;      
        geometricalPathLength = Standard('PLTS', surfaceParameters,rayPosition,rayDirection,...
            indexBefore,indexAfter,wavlenInM );
        intersectionPoint = computeIntersectionPoint(...
            rayPosition,rayDirection,geometricalPathLength);  
        surfaceNormal = computeStandardSurfaceNormal(surfaceRadius,surfaceConic,intersectionPoint);
        returnData1 = intersectionPoint;
        returnData2 = surfaceNormal;
        returnData3 = NaN;
    case 'SSAG' % Return the surface sag at given xyGridPoints % Used for plotting the surface
        surfaceRadius = surfaceParameters.Radius;
        surfaceConic = surfaceParameters.Conic;  
        surfaceGratingLineDensity = surfaceParameters.GratingLineDensity;
        if surfaceGratingLineDensity
            gratingHeight = 0.1*surfaceRadius;
        else
            gratingHeight = 0;
        end
        returnData1 = computeStandardSurfaceSag(surfaceRadius,surfaceConic,xyCoordinateMeshGrid,gratingHeight);
        returnData2 = returnData1; % Reserved for alternative sag
        returnData3 = NaN;
    case 'GRTY' % Returns the grid type to be used for ploting 'Rectangular' or 'Polar'
       returnData1 = 'Polar';
       %returnData1 = 'Rectangular'; 
       returnData2 = NaN;
       returnData3 = NaN;
    case 'EXRD' % Returns the exit ray direction real
        surfaceGratingLineDensity = surfaceParameters.GratingLineDensity;
        surfaceDiffractionOrder = surfaceParameters.DiffractionOrder;
        wavLenInUm = wavlenInM*10^6;
        gratingVector1 = [0,2*pi*surfaceGratingLineDensity,0]';
        diffractionOrder1 = surfaceDiffractionOrder;
        if  reflection
            if diffractionOrder1 ~= 0 && gratingVector1(2) ~= 0
                localReflectedRayDirection = computeNewRayDirection ...
                    (rayDirection,surfNormal,...
                    indexBefore,indexAfter,reflection,wavLenInUm,gratingVector1,diffractionOrder1);
            else
                localReflectedRayDirection = computeReflectedRayDirection ...
                    (rayDirection,surfNormal); % 6th function
            end
            exitRayDirection = localReflectedRayDirection;
            TIR = ones(1,size(localReflectedRayDirection,2));
        else
            if diffractionOrder1 ~= 0 && gratingVector1(2) ~= 0
                [localTransmittedRayDirection,TIR] = computeNewRayDirection ...
                    (rayDirection,surfNormal,...
                    indexBefore,indexAfter,reflection,wavLenInUm,gratingVector1,diffractionOrder1);
            else
                [localTransmittedRayDirection,TIR] = computeRefractedRayDirection ...
                    (rayDirection,surfNormal,indexBefore,indexAfter);
            end% 7th function
            exitRayDirection = localTransmittedRayDirection;
        end
       returnData1 = exitRayDirection; 
       returnData2 = TIR;
       returnData3 = NaN;

    case 'EXRP' % Returns the exit ray position 
        % Just return the ray position    
        exitRayPosition = rayPosition;
        
        returnData1 = exitRayPosition;
        returnData2 = NaN;
        returnData3 = NaN;
        
    case 'PRYT' % Returns the output paraxial ray parameters
        y = paraxialRayParameter(1);
        u = paraxialRayParameter(2);
        surfaceRadius = surfaceParameters.Radius;
        % the height doesnot change
        yf = y;
        % for angle compute based on the direction of propagation
        if ~reverseTracing
            %forward trace
            c = 1/surfaceRadius;
            n = indexBefore;
            nPrime = indexAfter;
        else
            %reverse trace
            c = -1/surfaceRadius;
            n = indexAfter;
            nPrime = indexBefore;
        end
        paI = u+yf*c; %The yui method generates the paraxial angles of incidence
        % during the trace and is probably the most common method used in computer programs.
        uf = u+((n/nPrime)-1)*paI;
        returnData1 = [yf,uf]';
        returnData2 = NaN;
        returnData3 = NaN;        
end
end

function surfaceNormal = computeStandardSurfaceNormal...
    (surfaceRadius,surfaceConic,intersectionPoint)
% COMPUTESTANDARDSURFACENORMAL to calculate the normal vector at a point of the surface
% The function is vectorized so it can work on multiple sets of
% inputs once at the same time.
% Inputs:
% 	intersectionPoint: 1-by-3 vector, the position of the point at the surface
% 	surfaceType: scalar, the parameter to describe the type of the surface,
%                eg. 0(plane), 1(sphere), 2(conic)
% 	surfaceRadius: scalar, radius of the surface
% 	surfaceConic: scalar, the parameter to describe the shape of aspherical
%                 surface, for plane and sphere(k=0)
% Output:
%   surfaceNormal: 1-by-3 vector, which is the unit normal vector of the
%                  surface at this point


nRay = size(intersectionPoint,2);

% Determine the exact surface type for standard surfaces
if abs(surfaceRadius) > 10^10
    surfaceType = 'Plane';
elseif surfaceConic ~= 0
    surfaceType = 'Conic Aspherical';
else
    surfaceType = 'Spherical';
end
switch surfaceType
    case {'Plane'}
        surfaceNormal = repmat([0;0;1],[1,nRay]);
    case 'Spherical'
        curv = 1/(surfaceRadius);
        normal = [-curv*intersectionPoint(1,:);-curv*intersectionPoint(2,:);...
            1-curv*intersectionPoint(3,:)];
        surfaceNormal = normal./repmat(sum(normal.^2,1),[3,1]);
    case 'Conic Aspherical'
        curv = 1/(surfaceRadius);
        denom = (sqrt(1-2*curv*surfaceConic*intersectionPoint(3,:) + ...
            curv^2*(1+surfaceConic)*surfaceConic*intersectionPoint(3,:).^2));
        normal = [-curv*intersectionPoint(1,:); -curv*intersectionPoint(2,:);...
            1-curv*(1+surfaceConic)*intersectionPoint(3,:)]./...
            repmat(denom,[3,1]);
        % to determine if the normal vector cosines are real
        S3 = 1-(1+surfaceConic)*curv^2*((intersectionPoint(1,:)).^2 + ...
            (intersectionPoint(2,:)).^2);
        normal(:,S3<0) = NaN;
        surfaceNormal = normal./repmat(sum(normal.^2,1),[3,1]);
end
end

function surfaceSag = computeStandardSurfaceSag...
    (surfaceRadius,surfaceConic,xyCoordinateMeshGrid,gratingHeight)

r = computeNormOfMatrix(xyCoordinateMeshGrid,3);
c = 1/surfaceRadius;
k = surfaceConic;
z = (c.*r.^2)./(1+sqrt(1-(1+k).*c.^2.*r.^2));   

% sameXIndices = floor(size(r,1)/2);
% % Make the sawtooth groove every 2nd points
% z(2:2:end) = z(2:2:end) + gratingHeight;
surfaceSag = z; 
end

function [geometricalPathLength,NoIntersectioPoint] = computeStandardSurfacePath ...
(rayInitialPosition,rayDirection,surfaceRadius,surfaceConic)
	% COMPUTEPATHLENGTH to calculate the path length of the ray from the start 
	% point to the intersection point
	%    REF: G.H.Spencer and M.V.R.K.Murty, GENERAL RAY-TRACING PROCEDURE
    % The function is vectorized so it can work on
    % multiple sets of inputs once at the same time.

    % Inputs:
	%   rayInitialPosition: position of the start ray point 1-by-3 vector
	%   rayDirection: unit vector for the direction of the start ray, 1-by-3 vector
	%   surfaceType: type of the surface, scalar, 0(plane), 1(spherical), 2(conic).....
	%   surfaceRadius: radius for the surface, scalar
	%   surfaceConic: the parameter of 'shape' of the surface, scalar
	%   refractiveIndexBefore: refractive index of the medium, vector as it
	%   depends on th wavelength.
	% Outputs 
	% 	geometricalPathLength: scalar, which is the total length from the start point to 
	%                          the intersection point
	%	opticalPathLength: scalar, which is the optical path corresponding to the 
	%                      geometrical path length


   % <<<<<<<<<<<<<<<<<<<<<<< Algorithm Section>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%	

	% <<<<<<<<<<<<<<<<<<<<<<<<< Example Usage>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%

	% <<<<<<<<<<<<<<<<<<<<<<<<< Author Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
	%   Part of the RAYTRACE toolbox
	%   Written by: Yi Zhong 05.03.2013
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University  
	
	%   Modified By: Worku, Norman Girma  
	%   Advisor: Prof. Herbert Gross
	%   Part of the RAYTRACE_TOOLBOX V3.0 (OOP Version)
	%	Optical System Design and Simulation Research Group
	%   Institute of Applied Physics
	%   Friedrich-Schiller-University of Jena   
							 
	% <<<<<<<<<<<<<<<<<<< Change History Section >>>>>>>>>>>>>>>>>>>>>>>>>>
	% Date----------Modified By ---------Modification Detail--------Remark
	% 04.09.2012    Yi Zhong             Original Version         Version 2.1
	% 05.03.2013	Yi Zhong			 Modification			  Version 2.1
	% Oct 14,2013   Worku, Norman G.     OOP Version              Version 3.0
	% Jan 18,2014   Worku, Norman G.     Vectorized inputs and outputs

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>>

    nRay = size(rayInitialPosition,2);
    initialPoint = rayInitialPosition; % define the start point
    k = rayDirection(1,:);
    l = rayDirection(2,:);
    m = rayDirection(3,:);

    distanceToXY = -initialPoint(3,:)./m;
    intersectionPointXY  = ...
        [initialPoint(1,:) +  distanceToXY.*k;...
        initialPoint(2,:) +  distanceToXY.*l;...
        zeros([1,nRay])];

    X = intersectionPointXY(1,:);
    Y = intersectionPointXY(2,:);
    Z = intersectionPointXY(3,:);

    % Determine the exact surface type for standard surfaces
        if abs(surfaceRadius) > 10^10
            surfaceType = 'Plane';
        elseif surfaceConic ~= 0
            surfaceType = 'Conic Aspherical'; 
        else
            surfaceType = 'Spherical'; 
        end
    
    switch surfaceType
        case {'Plane'} 
            % when the surface is plane, the intersection point is on the z=0 plane
            additionalPath = zeros([1,nRay]);
            NoIntersectioPoint = zeros([1,nRay]);
        case 'Spherical' % spherical 
            curv = 1/(surfaceRadius);       
            F = curv * ((X).^2+(Y).^2);
            G = m - curv .*(k.*X + l.*Y);
            additionalPath = F./(G+(sign(m)).*sqrt(G.^2-curv*F));
            NoIntersectioPoint = zeros([1,nRay]);
            
             NoIntersectioPoint(~(isreal(additionalPath))) = 1;
             additionalPath(~(isreal(additionalPath))) = NaN;
 
        case 'Conic Aspherical' % conic aspherical
            curv = 1/(surfaceRadius);       
            F = curv .* ((X).^2+(Y).^2);
            G = m - curv .*(k.*X + l.*Y);
            additionalPath = F./(G+(sign(m)).*sqrt(G.^2-curv.*F.*(1+surfaceConic.*(m.^2))));
            NoIntersectioPoint = zeros([1,nRay]);

            NoIntersectioPoint(~(isreal(additionalPath))) = 1;
            additionalPath(~(isreal(additionalPath))) = NaN;
    end
    geometricalPathLength = distanceToXY + additionalPath;
end

function intersectionPoint = computeIntersectionPoint(rayInitialPosition,rayDirection,...
                              geometricalPathLength)
	% COMPUTEINTERSECTIONPOINT to calculate the intersection point of a ray on one surface
	%   Ref: G.H.Spencer and M.V.R.K.Murty, GENERAL RAY-TRACING PROCEDURE
	%   We are calculating the intersection point for the j surface
    % The function is vectorized so it can work on multiple sets of 
    % inputs once at the same time.
    
    % Inputs (For N ray)
	%   incidentRayArray: Array of ray object incident to the surface p
	%   geometricalPathLength: the pathlength of the ray from the start point (j-1) to ...
	%                          the intersection point of the j surface
	%   The output will be 3-by-N matrix, which is the position of the intersection point

	% <<<<<<<<<<<<<<<<<<<<< Main Code Section >>>>>>>>>>>>>>>>>>>>>>>>>>>>
    nRay = size(rayInitialPosition,2);
    %compute the intersection point
    intersectionPoint = ...
    [rayInitialPosition(1,:) + rayDirection(1,:).*geometricalPathLength;...
    rayInitialPosition(2,:) + rayDirection(2,:).*geometricalPathLength;...
    rayInitialPosition(3,:) + rayDirection(3,:).*geometricalPathLength];   
end

