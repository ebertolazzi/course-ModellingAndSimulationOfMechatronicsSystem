function p = drawArrow( form, ad1, ad2, x1, y1, varargin)
%DRAWARROW Draw the arrow between two points..
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawArrow( form, ad1, ad2, x1, y1, x2, y2)
%   drawArrow( form, ad1, ad2, x1, y1, '-delta', dx, dy)
%   drawArrow( form, ad1, ad2, x1, y1, '-polar', r, th)
%   drawArrow( form, ad1, ad2, x1, y1, x2, y2, LineSpec)
%   p = drawArrow(__)
%
%Input:
%   form     -- arrowhead type number: if <0 swap tail and head
%   ad1, ad2 -- arrowhead dimensions
%   x1,y1    -- arrow head coordinates 
%   x2,y2    -- arrow tail coordinates
%   or    
%   '-polar'|'-rtheta',  r, th -- polar coordiantes of tail point
%   or
%   '-delta', dx, dy -- delta coordinates of tail point
%
%Optional name-value pairs input:
%   LineSpec --- plot options
%
%Optional output:
%   p        --- structure with fields containing key points and color.

    narginchk(5,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(form, {'numeric'}, {'integer','scalar'});
    validateattributes(ad1,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(ad2,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(x1,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y1,   {'numeric'}, {'real', 'scalar'});
    
    % scan options
    if ~ischar(varargin{1})
        x2 = varargin{1};
        y2 = varargin{2};
        varargin(1:2) = [];
    else
        switch lower(varargin{1})
            case {'-polar','-rtheta'}
                r  = varargin{2};
                th = varargin{3};
                x2 = x1 + r*cosd(th);
                y2 = y1 + r*sind(th);
            case '-delta'
                dx = varargin{2};
                dy = varargin{3};                
                x2 = x1 + dx;
                y2 = y1 + dy;
            otherwise
                error('invalid option')
        end
        varargin(1:3) = []; %delete option
    end
    
    if form < 0
        % swap tail and head
        t = x1;  x1 = x2;  x2 = t;
        t = y1;  y1 = y2;  y2 = t;
        form = -form;
    end

    % draw arrow
    c = gkPlot([x1,x2],[y1,y2],varargin{:});
    drawArrowhead( form, ad1, ad2, x2, y2, atan2d(y2 - y1, x2 - x1), ...
       'Color',c)

    % pack outoput
    if nargout > 0         
        p.xk(1) = x1; % start point
        p.yk(1) = y1;
        p.xk(2) = x2; % end point
        p.yk(2) = y2;   
        p.xk(3) = (x2 + x1)/2; % mid point
        p.yk(3) = (y2 + y1)/2;           
        p.color = c; 
    end
    
end
    