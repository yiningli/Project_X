function [ returnData1, returnData2, returnData3] = ImageSurface(...
    returnFlag,surfaceParameters,rayPosition,rayDirection,indexBefore,...
    indexAfter,wavlenInM,surfNormal,reflection,xyCoordinateMeshGrid,...
    refWavlenInM,paraxialRayParameter,reverseTracing)
%ImageSurface Image surface assumed to be plane.
% surfaceParameters = values of {'FocalLength'}

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
    disp('Error: The function ImageSurface() needs atleat the return type.');
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
        disp('Error: Missing input argument for ImageSurface().');
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
        disp('Error: Missing input argument for ImageSurface().');
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
        disp('Error: Missing input argument for ImageSurface().');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;        
    end
elseif nargin == 4
    if strcmpi(returnFlag,'ABTS') || strcmpi(returnFlag,'SSPB') || strcmpi(returnFlag,'SSPE')|| strcmpi(returnFlag,'PLTS') || strcmpi(returnFlag,'SIAN') || strcmpi(returnFlag,'GRTY')
        xyCoordinateMeshgrid = [];       
    else
        disp('Error: Missing input argument for ImageSurface().');
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
        returnData1 = {'ImageSurface','IMG'}; % display name
        % look for image description in the current folder and return 
        % full address 
        [pathstr,name,ext] = fileparts(mfilename('fullpath'));
        returnData2 = {[pathstr,'\Surface.jpg']};  % Image file name
        returnData3 = {['ImageSurface: An image surface.']};  % Text description   
        
    case 'SSPB' % 'BasicSurfaceDataFields' table field names and initial values in Surface Editor GUI SSPB
        returnData1 = {'Unused'};
        returnData2 = {{'numeric'}}; 
        defaultSurfUniqueStruct = struct();
        defaultSurfUniqueStruct.Unused = 0;     
        returnData3 = defaultSurfUniqueStruct;
    case 'SSPE' % 'Extra Data' table field names and initial values in Surface Editor GUI SSPE
        returnData1 = {'Unused'};
        returnData2 = {{'char'}};
        returnData3 = {[0]};
    case 'PLTS' % Return path length to the surface intersection points for given PLSI
        % Just assume plane surface
        nRay = size(rayPosition,2);
        initialPoint = rayPosition; % define the start point
        k = rayDirection(1,:);
        l = rayDirection(2,:);
        m = rayDirection(3,:);
        distanceToXY = -initialPoint(3,:)./m;
        intersectionPointXY  = ...
                    [initialPoint(1,:) +  distanceToXY.*k;...
            initialPoint(2,:) +  distanceToXY.*l;...
            zeros([1,nRay])];
        
        returnData1 = distanceToXY;
        NoIntersectioPoint = zeros([1,nRay]);
        NoIntersectioPoint(~(isreal(distanceToXY))) = 1;
        returnData2 = NoIntersectioPoint;
        returnData3 = 0;
       
    case 'SIAN'  % Return the surface intersection points and surface normal for given incident Ray parameters SIAN
        % Just assume plane surface
        nRay = size(rayPosition,2);
        initialPoint = rayPosition; % define the start point
        k = rayDirection(1,:);
        l = rayDirection(2,:);
        m = rayDirection(3,:);
        distanceToXY = -initialPoint(3,:)./m;
        intersectionPointXY  = ...
            [initialPoint(1,:) +  distanceToXY.*k;...
            initialPoint(2,:) +  distanceToXY.*l;...
            zeros([1,nRay])];
        surfaceNormal = repmat([0;0;1],[1,nRay]);
        returnData1 = intersectionPointXY;
        returnData2 = surfaceNormal;
        returnData3 = NaN;
    case 'SSAG' % Return the surface sag at given xyGridPoints % Used for plotting the surface SSAG
        % Just assume plane surface
        r = computeNormOfMatrix(xyCoordinateMeshGrid,3);
        % test fresnel zones
        z = 0*r;
        returnData1 = z;
        returnData2 = z;
        returnData3 = NaN;
    case 'GRTY' % Returns the grid type to be used for ploting 'Rectangular' or 'Polar' GRTY
        returnData1 = 'Polar';
        returnData2 = NaN;
        returnData3 = NaN;
    case 'EXRD' % Returns the exit ray direction EXRD
        % using gaussian thin lens equation 1/f = -n/t+n'/t' 
        % first compute the intersection of the lines with local z axis on
        % the object side     
        exitRayDirection = rayDirection;
        TIR = ones(1,size(exitRayDirection,2));
        
        returnData1 = exitRayDirection;
        returnData2 = TIR;
        returnData3 = NaN;
    case 'EXRP' % Returns the exit ray position EXRP
        % Just return the ray position
        exitRayPosition = rayPosition;
        
        returnData1 = exitRayPosition;
        returnData2 = NaN;
        returnData3 = NaN;
    case 'PRYT'  % Returns the output paraxial ray parameters PRYT
        y = paraxialRayParameter(1);
        u = paraxialRayParameter(2);
        yf = y;
        uf = u;
        returnData1 = [yf,uf]';
        returnData2 = NaN;
        returnData3 = NaN;
end
end