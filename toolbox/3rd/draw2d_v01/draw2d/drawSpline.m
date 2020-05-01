function p = drawSpline( ctype, xv, yv, varargin )
%DRAWSPLINE Draw cubic spline curve.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawSpline( xv, yv )
%   drawSpline( xv, yv, '-s1', u, '-s2', v )
%   drawSpline( xv, yv, '-np', np)
%   drawSpline( xv, yv, LineSpec)
%
%Input:
%   ctype    -- spline type. 1=cubic, 2=Wilson-Fowler
%   xv, yv   -- polygon points
%
%Optional name-value pairs input:
%   '-s1',u  -- slope at start point
%   '-s2',v  -- slope at end point
%   '-np',np -- number of output points (default 100)
%   LineSpec -- plot options
%
%Optional output:
%   p        --- structure with key points.

    narginchk(2,inf)
    nargoutchk(0,1)
    validateattributes(xv, {'numeric'}, {'real', 'vector'});
    validateattributes(yv, {'numeric'}, {'real', 'vector'});
    if ~isequal(length(xv),length(yv))
        error('The size of xv and yv must be equal.')
    end
    if iscolumn(xv)
        xv = xv';
    end
    if iscolumn(yv)
        yv = yv';
    end
    
    % default values
    np = 100;    % number of points on the curve
    u = [];      % start slope
    v = [];      % end slope
    
    % scan options
    if nargin > 3
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
            switch lower(varargin{k})
                case '-np'
                    np = varargin{k + 1};
                    validateattributes(np, {'numeric'}, {'>',2,'<',1001,'integer','scalar'});
                    id(k:k+1) = 1;   
                case '-s1'
                    u = varargin{k + 1};
                    validateattributes(u, {'numeric'}, {'size',[1,2],'real','vector'});
                    id(k:k+1) = 1;   
                case '-s2'
                    v = varargin{k + 1};
                    validateattributes(v, {'numeric'}, {'size',[1,2],'real','vector'});
                    id(k:k+1) = 1;                     
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end   

    % calculate points
    [x, y, th] = evalSpline( ctype, xv, yv, u, v, np);
    
    % plot spline
    c = gkPlot(x,y,varargin{:});
    if nargout > 0
        p.th = th;  % tangent angle at start point and and point
        p.x = x;
        p.y = y;
        p.xk(1) = x(1);     % start point
        p.yk(1) = y(1);
        p.xk(2) = x(end);   % end point
        p.yk(2) = y(end);
        p.color = c;
    end
    
end
