function [ NonDummySurfaceArray ] = getNonDummySurfaceArray( optSystem )
%GETNONDUMMYSURFACEARRAY Returns the surface array which are not dummy
NonDummySurfaceArray = getSurfaceArray(optSystem,(getNonDummySurfaceIndices(optSystem)));
end

