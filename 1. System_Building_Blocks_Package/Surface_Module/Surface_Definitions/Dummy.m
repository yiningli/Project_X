function [ returnData1, returnData2, returnData3 ] = Dummy( ...
    returnFlag,~,~,~,~,~)
%DUMMY Dummy surface definition

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

% surfaceParameters = values of {'Unused'}
%% Default input vaalues
if nargin == 0
    disp('Error: The function Dummy() needs atleat the return type.');
    returnData1 = NaN;
    returnData2 = NaN;
    returnData3 = NaN;
    return;
else
end

%%
switch upper(returnFlag)
    case 'ABTS' % About the surface
        returnData1 = {'Dummy','DUMY'}; % display name
        % look for image description in the current folder and return 
        % full address 
        [pathstr,name,ext] = fileparts(mfilename('fullpath'));
        returnData2 = {[pathstr,'\Surface.jpg']};  % Image file name
        returnData3 = {['Dummy Surface: Is is just surface with no effects ',...
            ' on the optical system.']};  % Text description  
        
    case 'SSPB' % 'BasicSurfaceDataFields' table field names and initial values in Surface Editor GUI
        returnData1 = {'Unused'};
        returnData2 = {{'numeric'}}; 
        defaultSurfUniqueStruct = struct();
        defaultSurfUniqueStruct.Unused = 0;     
        returnData3 = defaultSurfUniqueStruct;
    case 'SSPE' % 'Extra Data' table field names and initial values in Surface Editor GUI
        returnData1 = {'Unused'};
        returnData2 = {{'numeric'}};  
        returnData3 = {[0]};
    case 'PLTS' % Return path length to the surface intersection points for given 
        disp('Error: Path length to Dummy surface can not be computed.');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
        
    case 'SIAN' % Return the surface intersection points and surface normal for given incident Ray parameters
        disp('Error: Intersection points to Dummy surface can not be computed.');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
    case 'SSAG' % Return the surface sag at given xyGridPoints % Used for plotting the surface
        disp('Error: Sag of Dummy surface can not be computed.');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
    case 'GRTY' % Returns the grid type to be used for ploting 'Rectangular' or 'Polar'
        disp('Error: Grid type of Dummy surface can not be computed.');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;
    case 'EXRD' % Returns the exit ray direction 
        disp('Error: exit ray direction  of Dummy surface can not be computed.');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;  
    case 'EXRP' % Returns the exit ray position 
        disp('Error: exit ray position of Dummy surface can not be computed.');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;  
    case 'PRYT' % Returns the output paraxial ray parameters
        disp('Error: output paraxial ray parameters of Dummy surface can not be computed.');
        returnData1 = NaN;
        returnData2 = NaN;
        returnData3 = NaN;        
        
end
end

