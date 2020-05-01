function p = fillPolygon( c, xv, yv, varargin)
%FILLPOLYGON Fill a closed 2D shape with straight sides.
%History:
%   2019,May   - MB created  
    narginchk(3,inf)
    nargoutchk(0,1)
    
    validateattributes(xv, {'numeric'}, {'real', 'vector'});    
    validateattributes(yv, {'numeric'}, {'real', 'vector'});
    if ~isequal(length(xv),length(yv))
        error('The size of xv and yv must be equal.')
    end
      
    % close polygon
    if xv(end) ~= xv(1) || yv(end) ~= yv(1)
        xv(end+1) = xv(1);
        yv(end+1) = yv(1);
    end
    
    if ~isempty(c)
        fill(xv,yv,c,'EdgeColor','none');
    end
        
    % plot polygon
    if nargout == 0
        fill(xv,yv,c,varargin{:},'EdgeColor','none')        
    else
        fill(xv,yv,c,varargin{:},'EdgeColor','none');
        p.xk = xv;
        p.yk = yv;
    end
    
end

