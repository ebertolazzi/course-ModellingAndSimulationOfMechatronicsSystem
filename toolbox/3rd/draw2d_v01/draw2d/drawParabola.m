function p = drawParabola( t1, t2, f, xc, yc, varargin )
%DRAWPARABOLA Draw parabolic arc.
%
%History:
%   2019,May   - MB created
%
% Usage:
%   drawParabola( t1, t2, f)
%   drawParabola( t1, t2, f, xc, yc)
%   drawParabola( t1, t2, f, xc, yc, rot)
%   drawParabola( t1, t2, f, '-np',np)
%   drawParabola( t1, t2, f, LineSpec)
%   p = drawParabola(__)
%
%Input Arguments
%   t1 - initial parameter
%   t2 - final parameter
%   f  - focal distance
%   xc - x-coordinate of the vertex (real scalar)
%   yc - y-coordinate of the vertex (real scalar)
%
%Optional Input Argumnts
%   rot - rotation angle about the vertex in degrees
%
%Optional Name-Value Pair Input Arguments
%   '-np', np - number of points along the curve ( scalar integer value > 2)
%   LineSpec - specifies line properties, see Line Properties.
%
%Optional Output Arguments
%   p        --- structure with key points and color.
%
    narginchk(5,inf)
    nargoutchk(0,1)
   
    validateattributes(t1, {'numeric'}, {'real',   'scalar'});    
    validateattributes(t2, {'numeric'}, {'real',   'scalar'});      
    validateattributes(f,  {'numeric'}, {'positive','real',   'scalar'});    
    validateattributes(xc, {'numeric'}, {'real',   'scalar'});    
    validateattributes(yc, {'numeric'}, {'real',   'scalar'});        
    
    % default values
    np = 100; % default number of points in the arc
    rot = 0;
    form = 0;
    
    % scan options
    if nargin > 5
        if ~isempty(varargin)
            if ~ischar(varargin{1})
                rot = varargin{1};
                validateattributes(rot, {'numeric'}, {'real', 'scalar'});
                varargin(1) = [];
            end
        end
    end
    if ~isempty(varargin)
        for k = 1:length(varargin)
            if ~ischar(varargin{k})
                continue
            end
            switch lower(varargin{k})
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
    [x,y] = evalParabola( f, xc, yc, rot, linspace(t1, t2, np)');
     
    n = length(x);
    switch form
        case 2
            x(n+1) = x(1);
            y(n+1) = y(1);
    end
    
    % plot parabola
    if nargout == 0
        gkPlot(x,y,varargin{:})        
    else
        c = gkPlot(x,y,varargin{:});
        p.xk(1) = x(1);  % start point
        p.yk(1) = y(1);
        p.xk(2) = x(n);  % end point
        p.yk(2) = y(n);
        p.xk(3) = xc;
        p.yk(3) = yc;
        dx = 2*f*t1;
        dy = 2*f;
        % tangent angles
        xx = cosd(rot)*dx - sind(rot)*dy;
        yy = sind(rot)*dx + cosd(rot)*dy;
        p.th(1) = atan2d(yy,xx);
        dx = 2*f*t2;
        dy = 2*f;
        xx = cosd(rot)*dx - sind(rot)*dy;
        yy = sind(rot)*dx + cosd(rot)*dy;
        p.th(2) = atan2d(yy,xx);        
        p.color = c;  
    end
    
end
