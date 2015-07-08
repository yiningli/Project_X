function  [ returnData1, returnData2, returnData3]  = Kostenbauder(...
    returnFlag,surfaceParameters,rayPosition,rayDirection,indexBefore,...
    indexAfter,wavlenInM,surfNormal,reflection,xyCoordinateMeshGrid,...
    refWavlenInM,paraxialRayParameter,reverseTracing)

%KOSTENBAUDER Represent an ideal kostenbuder matrix surface defined by 4x4
% matrix in general. If the refrernce ray is axial ray, then Kostenbuder
% matrix surface can represent the normal ABCD matrix surfaces

% surfaceParameters = values of {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I'}
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
    disp('Error: The function Kostenbauder() needs atleat the return type.');
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
        disp('Error: Missing input argument for Kostenbauder().');
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
        disp('Error: Missing input argument for Kostenbauder().');
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
        disp('Error: Missing input argument for Kostenbauder().');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        return;        
    end
elseif nargin == 4
    if strcmpi(returnFlag,'ABTS') || strcmpi(returnFlag,'SSPB') || strcmpi(returnFlag,'SSPE')|| strcmpi(returnFlag,'PLTS') || strcmpi(returnFlag,'SIAN') || strcmpi(returnFlag,'GRTY')
        xyCoordinateMeshgrid = [];       
    else
        disp('Error: Missing input argument for Kostenbauder().');
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
        returnData1 = {'Kostenbauder','KOST'}; % display name
        % look for image description in the current folder and return 
        % full address 
        [pathstr,name,ext] = fileparts(mfilename('fullpath'));
        returnData2 = {[pathstr,'\Surface.jpg']};  % Image file name
        returnData3 = {['Kostenbauder: Used to define an ideal Kostenbauder matrix element.']};  % Text description   
    case 'SSPB' % 'BasicSurfaceDataFields' table field names and initial values in Surface Editor GUI
        returnData1 = {'A','B','C','D','E','F','G','H','I'};
        returnData2 = {{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'},{'numeric'}};  
        defaultSurfUniqueStruct = struct();
        defaultSurfUniqueStruct.A = 0;     
        defaultSurfUniqueStruct.B = 0;  
        defaultSurfUniqueStruct.C = 0;  
        defaultSurfUniqueStruct.D = 0;  
        defaultSurfUniqueStruct.E = 0;  
        defaultSurfUniqueStruct.F = 0;  
        defaultSurfUniqueStruct.G = 0;  
        defaultSurfUniqueStruct.H = 0;  
        defaultSurfUniqueStruct.I = 0;  
        returnData3 = defaultSurfUniqueStruct;        
        
    case 'SSPE' % 'Extra Data' table field names and initial values in Surface Editor GUI
        returnData1 = {'Unused'};
        returnData2 = {{'char'}};  
        returnData3 = {[0]};
    case 'PLTS' % Return path length to the surface intersection points for given 
        % Just assume plane surface
        nRay = size(rayPosition,2);
        initialPoint = rayPosition; % define the start point
        k = rayDirection(1,:);
        l = rayDirection(2,:);
        m = rayDirection(3,:);
        distanceToXY = -initialPoint(3,:)./m;
        returnData1 = distanceToXY; 
        NoIntersectioPoint = zeros([1,nRay]);
        NoIntersectioPoint(~(isreal(distanceToXY))) = 1;
        returnData2 = NoIntersectioPoint;
        returnData3 = NaN;
        disp('Error: Currently computation of optical path due to Kostenbauder surface is not implemented.'); 
    case 'SIAN' % Return the surface intersection points and surface normal for given incident Ray parameters
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
    case 'SSAG' % Return the surface sag at given xyGridPoints % Used for plotting the surface
        % Just assume plane surface
        r = computeNormOfMatrix(xyCoordinateMeshGrid,3);
        % test fresnel zones
        z = 0*r;       
        returnData1 = z; 
        returnData2 = z;
        returnData3 = NaN;
    case 'GRTY' % Returns the grid type to be used for ploting 'Rectangular' or 'Polar'
       returnData1 = 'Polar'; 
       returnData2 = NaN;
       returnData3 = NaN;
    case 'EXRD' % Returns the exit ray direction 
        % Just multiply the x and y direction cosines with the ABCD matrix .*sign(rayDirection)
        % NB all the coefficients are in lens unit, deg, sec and hz
        C = surfaceParameters.C;
        D = surfaceParameters.D;
        F = surfaceParameters.F;
        
        c = 299792458;
        delWaveLength = wavlenInM-refWavlenInM;
        refFrequency = c./refWavlenInM;
        frequency = c./wavlenInM;
        delFrequency = -((refFrequency^2)/(c))*delWaveLength;
        
        % X direction not changed
        exitRayDirection(1,:) = rayDirection(1,:);
        % Y direction changed by the Kostenbauder matrix
        exitRayAnglesInY = (((1./indexAfter)).*((indexBefore).*acos(rayDirection(2,:))*D - rayPosition(2,:)*C + (delFrequency*F)));
        exitRayDirection(2,:) = cos(exitRayAnglesInY).*sign(exitRayAnglesInY);
        % The Z direction cosine shall be computed in such a way that the
        % mag of direction vector is unity
        exitRayDirection(3,:) = sqrt(1-exitRayDirection(1,:).^2-exitRayDirection(2,:).^2);       
        
       TIR = ones(1,size(exitRayDirection,2));

       returnData1 = exitRayDirection; 
       returnData2 = TIR;
       returnData3 = NaN;       
    case 'EXRP' % Returns the exit ray position 
        % Just use the positions and  direction cosines with the ABCD matrix
        
        A = surfaceParameters.A;
        B = surfaceParameters.B;
        E = surfaceParameters.E;
        
        c = 299792458;
        delWaveLength = wavlenInM-refWavlenInM;
        refFrequency = c./refWavlenInM;
        frequency = c./wavlenInM;
        delFrequency = -((refFrequency^2)/(c))*delWaveLength;
        

        % Kostenbauder matrix apply for y positions
        exitRayPosition(2,:) = ((1./indexAfter)).*((indexBefore).*rayDirection(2,:)*B+rayPosition(2,:)*A+ (delFrequency*E));
        % The Z and X position remins unchanged 
        exitRayPosition(1,:) = rayPosition(1,:);
        exitRayPosition(3,:) = rayPosition(3,:);       
        
       returnData1 = exitRayPosition; 
       returnData2 = NaN;
       returnData3 = NaN; 
    case 'PRYT' % Returns the output paraxial ray parameters
        y = paraxialRayParameter(1);
        u = paraxialRayParameter(2);
        % The paraxial parameters are simply altered by the kostenbauder
        % matrix
        A = surfaceParameters.A;
        B = surfaceParameters.B;
        C = surfaceParameters.C;
        D = surfaceParameters.D;
        ABCD = [A,B;C,D];
        invABCD = (1/(A*D-B*C))*[D,-B;-C,A];
        if ~reverseTracing
            %forward trace 
            yf = ABCD(1,1)*y + ABCD(1,2)*u ;
            uf = ABCD(2,1)*y + ABCD(2,2)*u ;            
        else
            %reverse trace 
            yf = invABCD(1,1)*y + invABCD(1,2)*u ;
            uf = invABCD(2,1)*y + invABCD(2,2)*u ;             
        end
        
        returnData1 = [yf,uf]';
        returnData2 = NaN;
        returnData3 = NaN;       
       
end
end
