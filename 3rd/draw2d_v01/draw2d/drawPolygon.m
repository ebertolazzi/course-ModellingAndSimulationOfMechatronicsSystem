function p = drawPolygon( xv, yv, varargin)
%DRAWPOLYGON Draw a closed 2D shape with straight sides.
%History:
%   2019,May   - MB created  
    narginchk(2,inf)
    nargoutchk(0,1)
    
    validateattributes(xv, {'numeric'}, {'real', 'vector'});    
    validateattributes(yv, {'numeric'}, {'real', 'vector'});
    if ~isequal(length(xv),length(yv))
        error('The size of xv and yv must be equal.')
    end
    
    %set optional values
    c = [];
    
    if nargin > 2
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
            switch lower(varargin{k})
                case '-fill'
                    c = varargin{k + 1};
                    id(k:k+1) = 1;  
                    break  % only additional option
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
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
    c = gkPlot(xv,yv,varargin{:});
    if nargout > 0
        p.xk = xv;
        p.yk = yv;
        p.color = c;  
    end
    
end

