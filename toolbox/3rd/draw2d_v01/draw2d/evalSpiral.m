function [x, y] = evalSpiral( a, xc, yc, rot, th)
%EVALSPIRAL  Calculate points on the Archimedes' spiral 
%
%       r = a*th/(2*pi)
%
% Usage:
%   [x,y] = evalSpiral( a, xc, yc,, th )
%
% Input:
%   a        --- distance between succesive turns 
%   xc, yc   --- center
%   rot      --- rotation angle about center in degrees
%   th       --- spral angle in degrees

    narginchk(5,5)
    nargoutchk(2,2)
    
    validateattributes(a,  {'numeric'}, {'positive', 'real', 'scalar'});     
    validateattributes(xc, {'numeric'}, {'real', 'scalar'});    
    validateattributes(yc, {'numeric'}, {'real', 'scalar'});           
    validateattributes(th, {'numeric'}, {'real', 'vector'});        
    
    r = a*th/360;
    x = r.*cosd(th);
    y = r.*sind(th);
       
    [x, y] = trRot2d( x, y, xc, yc, rot);
    
end

