function p = drawCircle( xc, yc, r, varargin )
%DRAWCIRCLE Draw circlar arc.
%
%History:
%   2019,May   - MB created
%
% Usage:
%   drawCircle( xc, yc, r)
%   drawCircle( xc, yc, r, sang, theta )
%   drawCircle( xc, yc, r, sang, theta, '-pie'|'-seg' )
%   drawCircle( __, LineSpec)
%   drawCircle( __, '-np',np)
%   p = drawCircle(__)
%
% Input:
%   xc, yc   -- circle center
%   r        -- circle radius (> 0)
%
% Optional input:
%   sang     -- start angle (deg)
%   theta    -- central angle (deg), > 0 CCW, < 0 CW
%   '-pie'|'-sec'   -- draw pie (sector) i.e. conect stat point, center point and end point
%   '-seg'   -- draw segment i.e. conect start and end point
%
% Optional name-value pairs input:
%   '-np',np -- the number of points in the output curve (>1)
%   LineSpec -- options for plot   
%
%Optional output
%   p        --- structure with fields containing key points, 
%               end tangent angles and color.
%
    narginchk(3,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(r,  {'numeric'}, {'positive','real',   'scalar'});
    validateattributes(xc, {'numeric'}, {'real',   'scalar'});    
    validateattributes(yc, {'numeric'}, {'real',   'scalar'});    
    
    % default values
    np = 360; % default number of points in the arc
    sang = 0;
    theta = 360;
    form  = 0; %0=arc,1=pie,2=segment
         
    % scan options
    if ~isempty(varargin)  
        if ~ischar(varargin{1})
            sang  = varargin{1};
            theta = varargin{2};
            varargin(1:2) = [];
            validateattributes(sang,  {'numeric'}, {'real', 'scalar'});
            validateattributes(theta, {'numeric'}, {'real', 'scalar'});
            np = max(4,fix(abs(theta)));
        end
    end
    if ~isempty(varargin)  
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:length(varargin)
            if ~ischar(varargin{k})
                continue
            end
            switch lower(varargin{k})
                case {'-pie','-sec'}
                    form = 1;
                    id(k:k) = 1;
                case '-seg'
                    form = 2;
                    id(k:k) = 1;
                case '-np'
                    np = varargin{k + 1};
                    validateattributes(np, {'numeric'}, {'>',2,'integer','scalar'});
                    id(k:k+1) = 1;                    
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end  
    
    % calculate points in arc
    [x,y] = evalCircle(xc, yc, r, linspace(sang, sang + theta, np)');
    
    n = length(x);    
    switch form
        case 1
            x(n+1) = xc;
            y(n+1) = yc;
            x(n+2) = x(1);
            y(n+2) = y(1); 
        case 2
            x(n+1) = x(1);
            y(n+1) = y(1);
    end
     
    % plot circle
    c = gkPlot(x,y,varargin{:});
    if nargout > 0
        if theta == 360
            p.xk(1)  = xc - r;  % start
            p.yk(1)  = yc;
            p.xk(2)  = xc + r;  % end
            p.yk(2)  = yc ;
            p.xk(3)  = xc ;  % start
            p.yk(3)  = yc - r;
            p.xk(4)  = xc; % end
            p.yk(4)  = yc + r;
            p.xk(5)  = xc;    % center
            p.yk(5)  = yc;
            p.th(1) = 90;
            p.th(2) = 90;
        else
            p.xk(1) = x(1);  % start point
            p.yk(1) = y(1);
            p.xk(2) = x(n);  % end point
            p.yk(2) = y(n);
            p.xk(3) = xc;    % center
            p.yk(3) = yc;
            % tangent angles at end points
            p.th(1) = atan2d(cosd(sang),-sind(sang)); % tangent angle
            p.th(2) = atan2d(cosd(sang + theta),-sind(sang + theta));
        end
        p.color = c;  
    end
    
end
