function p = drawBspline( c, xv, yv, varargin )
%DRAWBSPLINE Draw B-spline curve.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawBspline( xv, yv)
%   drawBspline( __, LineSpec )
%   drawBspline( __, '-np', np )
%   p = drawBspline(__)
%
%Input:
%   c       -- order of b-spline basis
%   xv, yv  --- vertices
%
%Optional name-value pairs input:
%   '-np',np    --- number of points on the curve (default value is 100)
%   LineSpec    --- plot options
%
%Optional output:
%   p        --- structure with fields containing key points, 
%               end tangent angles and color.

    narginchk(2,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(c,  {'numeric'}, {'>',0,'integer', 'scalar'});    
    validateattributes(xv, {'numeric'}, {'real', 'vector'});    
    validateattributes(yv, {'numeric'}, {'real', 'vector'});
    if ~isequal(length(xv),length(yv))
        error('The size of xv and yv must be equal.')
    end     
    
    % default values
    np = 100;    % number of points on the curve
    
    % scan options
    if ~isempty(nargin)
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:length(varargin)
            switch lower(varargin{k})
                case {'-np','-numpts'}
                    np = varargin{k + 1};
                    validateattributes(np, {'numeric'}, {'>',2,'<',1001,'integer','scalar'});
                    id(k:k+1) = 1;
                    break  % no other extra option
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end

    % calculate points on curve
    [x, y] = evalBspline( c, xv, yv, np);
    
    % plot the curve
    if nargout == 0
        gkPlot(x,y,varargin{:})        
    else
        c = gkPlot(x,y,varargin{:});
        p.x  = x';
        p.y  = y';
        p.xk(1) = x(1);     % start point
        p.yk(1) = y(1);  
        p.xk(2) = x(end);   % end point
        p.yk(2) = y(end);  
        % start and end tangent angle
        p.th(1)  = atan2d(yv(2) - yv(1),xv(2) - xv(1));
        p.th(2)  = atan2d(yv(end) - yv(end-1),xv(end) - xv(end-1));        
        p.color = c;         
    end
    
end
