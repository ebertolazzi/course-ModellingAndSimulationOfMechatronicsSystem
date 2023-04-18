function p = drawArcArrow( form, ad1, ad2, xc, yc, r, sang, ang, varargin)
%DRAWARCARROW Draw arc arrow. Arrowhead is at arc head.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawArcArrow( form, ad1, ad2, xc, yc, r, sang, ang)
%   drawArcArrow(__, LineSpec)
%   p = drawLine(__)
%
%Input:
%   form     -- arrowhead type number: if <0 swap tail and head
%   ad1, ad2 -- arrowhead dimensions
%   xc, yc   -- center
%   r        -- radius
%   sang     -- start angle in degrees
%   ang      -- central angle in degrees
%
%Optional name-value pairs input:
%   LineSpec --- plot options
%
%Optional output:
%   p        --- structure with fields containing key points and color.

    narginchk(8,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(form, {'numeric'}, {'integer','scalar'});
    validateattributes(ad1,  {'numeric'}, {'positive','real',   'scalar'});
    validateattributes(ad2,  {'numeric'}, {'positive','real',   'scalar'});
    validateattributes(xc,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(yc,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(r,    {'numeric'}, {'positive','real',   'scalar'});   
    validateattributes(sang, {'numeric'}, {'real',   'scalar'});    
    validateattributes(ang,  {'numeric'}, {'real',   'scalar'});      

    % get arc points
    [x,y] = evalCircle( xc, yc, r, linspace(sang,sang+ang,max(3,fix(abs(ang))))');
    
    if form > 0
        x = flip(x);
        y = flip(y);        
        sang =  ang + sang;
        ang  = -ang;
    else
        form = -form;
    end
    da = sign(ang)*ad1/r*190/pi;
    x1 = x(1);
    y1 = y(1);
    if abs(da) < abs(ang)
        x2 = xc + r*cosd(sang + da);
        y2 = yc + r*sind(sang + da);
    else
        x2 = x(2);
        y2 = y(2);
    end
           
    % draw 
    c = gkPlot(x,y,varargin{:});    
    drawArrowhead( form, ad1, ad2, x1, y1, atan2d(y1 - y2, x1 - x2),...
        'Color',c)

    % output
    if nargout > 0    
        p.xk(1) = x(end);
        p.yk(1) = y(end);
        p.xk(2) = x(1);
        p.yk(2) = y(1);   
        p.color = c;         
    end
    
end
    