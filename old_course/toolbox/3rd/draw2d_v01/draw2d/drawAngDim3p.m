function drawAngDim3p( form, ad1, ad2, xc, yc, x1, y1, x2, y2, rt, at, varargin)
%DRAWANGDIM3P Draw angle dimension for angle formed by 3 points.
%
%History:
%   2019,June   - MB created
%
%Usage:
%   drawAngDim3p( form, ad1, ad2, xc, yc, x1, y1, x2, y2, rt, at)
%   drawAngDim3p( __,'-str',str)
%   drawAngDim3p( __, LineSpec)
%
%Input:
%   form     -- arrowhead type number: if <0 swap tail and head
%   ad1, ad2 -- arrowhead dimensions
%   xc,yc    -- center point 
%   x1, y1,  -- first point
%   x2, y2   -- second point
%   rt, at   -- relative polar coordinates of the text
%
%Optional name-value pairs input:
%   LineSpec --- plot options
%

    narginchk(11,inf)
    nargoutchk(0,0)
    
    % check input
    validateattributes(form, {'numeric'}, {'positive','integer','scalar'});
    validateattributes(ad1,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(ad2,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(xc,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(yc,   {'numeric'}, {'real', 'scalar'});
    validateattributes(x1,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y1,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(x2,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y2,   {'numeric'}, {'real', 'scalar'});        
    validateattributes(rt,   {'numeric'}, {'positive','real', 'scalar'});    
    validateattributes(at,   {'numeric'}, {'real', 'scalar'});    
    
    % calculate start angle
    sang = atan2d(y1 - yc, x1 - xc);
    
    % calculate central angle
    d1 = sqrt((x1 - xc)^2 + (y1 - yc)^2);
    d2 = sqrt((x2 - xc)^2 + (y2 - yc)^2);
    sina  = ((x2 - xc)*(y1 - yc) - (x1 - xc)*(y2 - yc))/(d1*d2);
    cosa =  ((x2 - xc)*(x1 - xc) + (y1 - yc)*(y2 - yc))/(d1*d2);
    ang = -atan2d(sina,cosa);
    
    % draw angle dimension
    drawAngDim( form, ad1, ad2, xc, yc, sang, ang, rt, at, varargin{:})
end
    