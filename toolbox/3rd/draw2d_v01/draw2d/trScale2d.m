function [xx,yy] = trScale2d( x, y, sx, sy, x0, y0)
%TRSCALE2D  2D scaling.
%
%Usage:
%   [xx,yy] = trScale2d( x, y, sx, sy, x0, y0)
%
%Input:
%   x,y    -- points coordinates
%   sx,sy  -- scale factors
%
% Optional input:
%   x0, y0 -- origin 
%
%Output:
%   xx, yy -- transformed points

    narginchk(4,6)
    nargoutchk(2,2)
    
    if nargin < 5
        x0 = 0;
    end
    if nargin < 6
        y0 = 0;
    end
    
    xx = x*sx + x0;
    yy = y*sy + y0;
    
end

