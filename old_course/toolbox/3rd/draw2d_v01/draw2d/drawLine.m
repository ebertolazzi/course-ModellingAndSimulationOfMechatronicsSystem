function p = drawLine( x1, y1, varargin )
%DRAWLINE Draw line 
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawLine( x1, y1, x2, y2)
%   drawLine( x1, y1, x2, y2, t1, t2)
%   drawLine( x1, y1, x2, y2, LineSpec )
%   drawLine( x1, y1, '-delta', dx, dy)
%   drawLine( x1, y1, '-polar', r, th )
%   p = drawLine(__)
%
%Input:
%   x1,y1   -- start point 
%
%Optional input:
%   x2, y2           -- end point
%   '-polar'|'-rtheta',  r, th -- polar coordiantes of end point
%   '-delta', dx, dy -- delta coordinates of end point
%   t1, t2           -- start and end parameter value
%
%Optional name-value pairs input:
%   LineSpec --- plot options
%
%Optional output:
%   p        --- structure with key points and color.

    narginchk(4,inf)
    nargoutchk(0,1)
    
    validateattributes(x1, {'numeric'}, {'real', 'scalar'});
    validateattributes(y1, {'numeric'}, {'real', 'scalar'});
    
    % default values
    t1 = 0;
    t2 = 1;

    if ~ischar(varargin{1})
        x2 = varargin{1};
        y2 = varargin{2};
        varargin(1:2) = [];
    else
        switch lower(varargin{1})
            case {'-polar','-rtheta'}
                r = varargin{2};
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
        varargin(1:3) = []; %delete options
    end
    if ~isempty(varargin)
        if ~ischar(varargin{1})
            t1 = varargin{1};
            t2 = varargin{2};
            varargin(1:2) = [];
        end
    end

    [x, y] = evalLine( x1, y1, x2, y2, [t1, t2]');
     
    % plot line
    c = gkPlot(x,y,varargin{:});
    if nargout > 0
        p.xk(1:2) = x(1:2);
        p.yk(1:2) = y(1:2);
        p.xk(3) = (x(2) + x(1))/2; % mid point
        p.yk(3) = (y(2) + y(1))/2;
        p.x1 = x1;
        p.y1 = y1;
        p.x2 = x2;
        p.y2 = y2;
        % distance
        p.d  = sqrt((p.xk(1) - p.xk(2))^2 + (p.yk(1) - p.yk(2))^2);
        % angle in degrees
        p.th = atan2d(y2 - y1, x2 - x1);
        p.color = c;
    end
    
end
