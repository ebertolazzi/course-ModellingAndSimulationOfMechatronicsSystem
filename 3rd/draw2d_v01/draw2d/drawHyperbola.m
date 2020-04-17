function p = drawHyperbola( t1, t2, a, b, xc, yc, varargin )
%DRAWHYPERBOLA Draw hyperbolic arc.
%
% Usage:
%   drawHyperbola( t1, t2, a, b)
%   drawHyperbola( t1, t2, a, b,  xc, yc)
%   drawHyperbola( t1, t2, a, b,  xc, yc, rot)
%   drawHyperbola( t1, t2, a, b,  '-np',np)
%   drawHyperbola( t1, t2, a, b,  LineSpec)
%   p = drawHyperbola(__)
%
%Input Arguments
%   t1 - initial parameter
%   t2 - final parameter
%   a  - major semi axis
%   b  - minor semi axis
%
%   xc - x-coordinate of the center (real scalar)
%   yc - y-coordinate of the center (real scalar)
%
%Optional Input Argumnts
%   rot - rotation angle about the center in degrees
%
%Optional Name-Value Pair Input Arguments
%   '-np', np - number of points along the curve ( scalar integer value > 2)
%   LineSpec - specifies line properties, see Line Properties.
%
%Optional output arguments
%   p    -- structure containing key points and color.
%
    narginchk(6,inf)
    nargoutchk(0,1)

    validateattributes(t1, {'numeric'}, {'real',   'scalar'});    
    validateattributes(t2, {'numeric'}, {'real',   'scalar'}); 
    validateattributes(a,  {'numeric'}, {'positive','real',   'scalar'});
    validateattributes(b,  {'numeric'}, {'positive','real',   'scalar'});    
    validateattributes(xc, {'numeric'}, {'real',   'scalar'});    
    validateattributes(yc, {'numeric'}, {'real',   'scalar'});  
    
    % default values
    np = 100; % default number of points in the arc
    rot = 0;
    form = 0;
         
    % scan options
    if nargin > 6
        if ~isempty(varargin)
            if ~ischar(varargin{1})
                rot = varargin{1};
                validateattributes(rot, {'numeric'}, {'real', 'scalar'});
                varargin(1) = [];
            end
        end
    end
% scan pairs
    if ~isempty(varargin)        
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
    [x,y] = evalHyperbola( a, b, xc, yc, rot, linspace(t1, t2, np)');
    
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
    
    % plot arc
    if nargout == 0
        gkPlot(x,y,varargin{:})        
    else
        c = gkPlot(x,y,varargin{:});
        p.xk(1)   = x(1);  % start
        p.yk(1)   = y(1);
        p.xk(2)   = x(n); % end
        p.yk(2)   = y(n);
        p.xk(3)  = xc;    % center
        p.yk(3)  = yc;          
        p.th(1)   = atan2d(b*cosh(t1),a*sinh(t1))+rot; % tangent angle
        p.th(2)   = atan2d(b*cosh(t2),a*sinh(t2))+rot; 
        p.color = c;  
    end
    
end
