function newComponent = Component(compType,uniqueParameters,firstTilt,firstDecenter,firstTiltDecenterOrder,compTiltMode,lastThickness)
    if nargin == 0
        % Make single surface component by default
        compType = 'SequenceOfSurfaces';
        % Connect the component definition function
        componentDefinitionHandle = str2func(compType);
        returnFlag = 2; % Basic parameters of the component
        [ paramNames, paramTypes, defaultValueStruct] = componentDefinitionHandle(returnFlag);
        uniqueParameters = defaultValueStruct;
        
        firstTilt = [0,0,0];
        firstDecenter = [0,0];
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 5;
    elseif nargin == 1
        % Connect the component definition function
        componentDefinitionHandle = str2func(compType);
        returnFlag = 2; % Basic parameters of the component
        [ paramNames, paramTypes, defaultValueStruct] = componentDefinitionHandle(returnFlag);
        uniqueParameters = defaultValueStruct;
        
        firstTilt = [0,0,0];
        firstDecenter = [0,0];
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 5;
    elseif nargin == 2
        firstTilt = [0,0,0];
        firstDecenter = [0,0];
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 5;
    elseif nargin == 3
        firstDecenter = [0,0];
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 5;
    elseif nargin == 4
        firstTiltDecenterOrder  = {'Dx','Dy','Dz','Tx','Ty','Tz'};
        compTiltMode = 'DAR';
        lastThickness = 5;
    elseif nargin == 5
        compTiltMode = 'DAR';
        lastThickness = 5;
    elseif nargin == 6
        lastThickness = 5;
    else
        
    end
    newComponent.Type = compType;
    newComponent.Name = compType;
    newComponent.Comment = '';
    newComponent.StopSurfaceIndex = 0;
    newComponent.LastThickness = lastThickness;
    newComponent.FirstTiltDecenterOrder = firstTiltDecenterOrder;
    newComponent.FirstTilt = firstTilt;
    newComponent.FirstDecenter = firstDecenter;
    newComponent.ComponentTiltMode = compTiltMode;
    newComponent.UniqueParameters = uniqueParameters;
    newComponent.ClassName = 'Component';
end


