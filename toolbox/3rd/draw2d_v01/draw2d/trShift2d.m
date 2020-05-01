function [xx,yy] = trShift2d( x, y, dx, dy)
%TRSHIFT2D  2D translation.
%
%Usage:
%   [xx,yy] = trTrans2d( x, y, dx, dy)
%
%Input:
%   x,y    -- points coordinates
%   dx,dy  -- shift vector
%
%Output:
%   xx, yy -- transformed points

    narginchk(4,4)
    nargoutchk(2,2)

    xx = x + dx;
    yy = y + dy;
    
end

