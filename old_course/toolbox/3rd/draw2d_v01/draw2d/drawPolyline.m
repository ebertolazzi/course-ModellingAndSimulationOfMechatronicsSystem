function p = drawPolyline( xv, yv, varargin)
%DRAWPOLYLINE Just call MATLAB function plot
%History:
%   2019,May   - MB created
    narginchk(2,inf)
    nargoutchk(0,1)    
    validateattributes(xv, {'numeric'}, {'real', 'vector'});    
    validateattributes(yv, {'numeric'}, {'real', 'vector'});
    if ~isequal(length(xv),length(yv))
        error('The size of xv and yv must be equal.')
    end
    c = gkPlot(xv,yv,varargin{:});
    if nargout > 0       
        p.xk(1) = xv(1);  % start point
        p.yk(1) = yv(1);  % end point
        p.xk(2) = xv(end);
        p.yk(2) = yv(end);        
        p.color = c;  
    end    
end

