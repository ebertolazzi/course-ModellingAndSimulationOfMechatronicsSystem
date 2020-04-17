function p = drawBezier( xv, yv, varargin )
%DRAWBEZIER Draw Bezier curve.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawBezier( xc, yc)
%   drawBezier( xc, yc, LineSpec )
%   drawBezier( xc, yc, '-np', np )
%   p = drawBezier(__)
%
%Input:
%   xv, yv      --- vertices
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
    validateattributes(xv, {'numeric'}, {'real', 'vector'});    
    validateattributes(yv, {'numeric'}, {'real', 'vector'});
    if ~isequal(length(xv),length(yv))
        error('The size of xv and yv must be equal.')
    end
    if length(xv) < 3
        error('Polygon must contains at least 3 verices.')
    end
    
    % default values
    np = 100;    % number of points on the curve
    
    % scan options
    if ~isempty(varargin)
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
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
    [x, y] = evalBezier( xv, yv, linspace(0,1,np));
    
    % plot the curve  
    c = gkPlot(x,y,varargin{:});
    
    % pack output
    if nargout> 0
        p.x  = x';          % the curve
        p.y  = y';
        p.xk(1) = x(1);     % start point
        p.yk(1) = y(1);  
        p.xk(2) = x(end);   % end point
        p.yk(2) = y(end);  
        % start and end tangent angle
        p.th(1)  = atan2d(yv(2) - yv(1),xv(2) - xv(1));
        p.th(2)  = atan2d(yv(end) - yv(end-1),xv(end) - xv(end-1));
        p.color  = c;         
    end
    
end
