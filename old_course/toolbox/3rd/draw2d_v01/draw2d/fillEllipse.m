function p = fillEllipse( c, a, b, xc, yc, varargin )
%FILLELLIPSE Draw elliptic arc.
%
%History:
%   2019,May   - MB created
%
% Usage:
%   fillEllipse( c, a, b,  xc, yc)
%   fillEllipse( c, a, b,  xc, yc, rot)
%   fillEllipse( c, a, b,  xc, yc, rot, t1, t2)
%   fillEllipse( c, a, b,  xc, yc, rot, t1, t2,'-pie'|'-seg')
%   fillEllipse( __,  '-np',np)
%   fillEllipse( __,  LineSpec)
%   p = fillEllipse(__)
%
%Input Arguments
%   c       -- fill color
%   a, b    -- semi major axis (real scalar)
%   xc      -- x-coordinate of the center (real scalar)
%   yc      -- y-coordinate of the center (real scalar)
%
%Optional Input Argumnts
%   rot     -- angle of rotation about the origin in degrees
%   t1      -- start sweep angle in degrees
%   tt      -- central sweep angle in degrees
%   '-pie'|'-sec'  --- draw pie or
%   '-seg'   --- draw segment
%
%Optional Name-Value Pair Input Arguments
%   '-np', np -- number of points along the curve ( scalar integer value > 2)
%   LineSpec  -- specifies line properties, see Line Properties.
%
%Optional Output Arguments
%   p    -- structure containing an output data
%
    narginchk(4,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(a,  {'numeric'}, {'positive','real',   'scalar'});
    validateattributes(b,  {'numeric'}, {'positive','real',   'scalar'});    
    validateattributes(xc, {'numeric'}, {'real',   'scalar'});    
    validateattributes(yc, {'numeric'}, {'real',   'scalar'});    
    
    % default values
    np = 360; % default number of points in the arc
    rot = 0;    
    t1  = 0;
    t2  = 360;    
    form  = 0; %0=arc,1=pie,2=segment
         
    % scan options
    if nargin > 4
        if ~ischar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real', 'scalar'});
            varargin(1) = [];
        end
    end
    if ~isempty(varargin)
        if ~ischar(varargin{1})
            t1 = varargin{1};
            validateattributes(t1, {'numeric'}, {'real', 'scalar'});
            tt = varargin{2};
            validateattributes(tt, {'numeric'}, {'real', 'scalar'});
            t2 = t1 + tt;
            varargin(1:2) = [];
            np = max(3,fix(abs(t2 - t1)));
        end
    end
    
    % scan pairs
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
                    break  % only additional option
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end  
    
    % calculate points in arc
    [x,y] = evalEllipse( a, b, xc, yc, rot, linspace(t1, t2, np)');
     
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
    
    % plot 
    fill(x,y,c,varargin{:},'EdgeColor','none');    
        
    if nargout > 0
        if t1 == 0 && t2 == 360
            p.xk(1)  = xc - a*cosd(rot);  % start
            p.yk(1)  = yc - a*sind(rot);
            p.xk(2)  = xc + a*cosd(rot);  % end
            p.yk(2)  = yc + a*sind(rot);
            p.xk(3)  = xc + b*sind(rot);  % start
            p.yk(3)  = yc - b*cosd(rot);
            p.xk(4)  = xc - b*sind(rot);  % end
            p.yk(4)  = yc + b*cosd(rot);            
            p.xk(5)  = xc;    % center
            p.yk(5)  = yc;
            p.th(1) = 90+rot;
            p.th(2) = 90+rot;
        else
            p.xk(1)  = x(1);  % start
            p.yk(1)  = y(1);
            p.xk(2)  = x(n);  % end
            p.yk(2)  = y(n);
            p.xk(3)  = xc;    % center
            p.yk(3)  = yc;
            p.th(1)  = atan2d(b*cosd(t1),-a*sind(t1))+rot; % tangent angle
            p.th(2)  = atan2d(b*cosd(t2),-a*sind(t2))+rot;
        end
    end
    
end
