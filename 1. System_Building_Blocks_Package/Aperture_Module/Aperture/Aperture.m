function newAperture = Aperture(type,apertDecenter,apertRotInDeg,drawAbsolute,outerShape,additionalEdge,uniqueParameters)
    if nargin == 0
        type = 'FloatingCircularAperture';
        apertDecenter = [0,0];
        apertRotInDeg = 0;
        drawAbsolute = 0;
        apertureDefinitionHandle = str2func(type);
        returnFlag = 1; % isInsideTheOuterAperture
        [ ~,~,defaultParameters] = ...
            apertureDefinitionHandle(returnFlag);
        outerShape = 'Circular';
        additionalEdge = 0.1;
        uniqueParameters = defaultParameters;
    elseif nargin == 1
        apertDecenter = [0,0];
        apertRotInDeg = 0;
        drawAbsolute = 0;
        apertureDefinitionHandle = str2func(type);
        returnFlag = 1; % isInsideTheOuterAperture
        [ ~,~,defaultParameters] = ...
            apertureDefinitionHandle(returnFlag);
        if strcmpi(type,'RectangularAperture')||...
                strcmpi(type,'RectangularObstruction')
            outerShape = 'Rectangular';
        else
            outerShape = 'Circular';
        end
        additionalEdge = 0.1;
        uniqueParameters = defaultParameters;
    elseif nargin == 2
        apertRotInDeg = 0;
        drawAbsolute = 0;
        apertureDefinitionHandle = str2func(type);
        returnFlag = 1; % isInsideTheOuterAperture
        [ ~,~,defaultParameters] = ...
            apertureDefinitionHandle(returnFlag);
        if strcmpi(type,'RectangularAperture')||...
                strcmpi(type,'RectangularObstruction')
            outerShape = 'Rectangular';
        else
            outerShape = 'Circular';
        end
        additionalEdge = 0.1;
        uniqueParameters = defaultParameters;
    elseif nargin == 3
        drawAbsolute = 0;
        apertureDefinitionHandle = str2func(type);
        returnFlag = 1; % isInsideTheOuterAperture
        [ ~,~,defaultParameters] = ...
            apertureDefinitionHandle(returnFlag);
        if strcmpi(type,'RectangularAperture')||...
                strcmpi(type,'RectangularObstruction')
            outerShape = 'Rectangular';
        else
            outerShape = 'Circular';
        end
        additionalEdge = 0.1;
        uniqueParameters = defaultParameters;
    elseif nargin == 4
        apertureDefinitionHandle = str2func(type);
        returnFlag = 1; % isInsideTheOuterAperture
        [ ~,~,defaultParameters] = ...
            apertureDefinitionHandle(returnFlag);
        if strcmpi(type,'RectangularAperture')||...
                strcmpi(type,'RectangularObstruction')
            outerShape = 'Rectangular';
        else
            outerShape = 'Circular';
        end
        additionalEdge = 0.1;
        uniqueParameters = defaultParameters;
    elseif nargin == 5
        if strcmpi(type,'RectangularAperture')||...
                strcmpi(type,'RectangularObstruction')
            outerShape = 'Rectangular';
        else
            outerShape = 'Circular';
        end
        additionalEdge = 0.1;
    elseif nargin == 6
        additionalEdge = 0.1;
    else
    end
    newAperture.Type = type;
    newAperture.Decenter = apertDecenter;
    newAperture.Rotation = apertRotInDeg;
    newAperture.DrawAbsolute = drawAbsolute;
    newAperture.OuterShape = outerShape;
    newAperture.AdditionalEdge = additionalEdge;
    newAperture.UniqueParameters = uniqueParameters;
    newAperture.ClassName = 'Aperture';
end


