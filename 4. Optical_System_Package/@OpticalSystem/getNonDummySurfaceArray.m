function [ NonDummySurfaceArray ] = getNonDummySurfaceArray( optSystem )
%GETNONDUMMYSURFACEARRAY Returns the surface array which are not dummy
NonDummySurfaceArray = optSystem.getSurfaceArray((getNonDummySurfaceIndices(optSystem)));
end

