function p = fillNgon( c, n, r, xc, yc, varargin )
%FILLNGON Fill regular n-sided polygon (cyclic n-gon).
%
%History:
%   2019,May   - MB created
%
%Usage:
%  fillNgon( c, n, r, xc, yc, LineStyle)
%  fillNgon( c, n, r, xc, yc, rot )
%  fillNgon( c, n, r, xc, yc, rot, v1, v2 )
%  fillNgon( c, n, r, xc, yc, pos )
%  p = drawNgon(__)
%
%Input:
%   c    -- color
%   n    -- number of vertices
%   r    -- radius
%   xc   -- x-coordinate of the center (real scalar)
%   yc   -- y-coordinate of the center (real scalar)
% 
%Optional Input:
%   rot     -- angle of rotation about the origin in degrees
%   '-v',v1,v2   -- start and end vertices in CCLW direction
%   pos     -- circle position: '-in' (circle is inside polygon) or 
%                 '-out' (circle is outside polygon, default)
%
%Optional Name-Value Pair Input:
%   LineSpec - specifies line properties, see Line Properties.
%
%Optional Output Arguments
%   p    -- structure containing  ngon  data

    narginchk(5,inf)
    nargoutchk(0,1)
    
    validateattributes(n,  {'numeric'}, {'>',2,'integer', 'scalar'});       
    validateattributes(r,  {'numeric'}, {'positive', 'real', 'scalar'});     
    validateattributes(xc, {'numeric'}, {'real', 'scalar'});  
    validateattributes(yc, {'numeric'}, {'real', 'scalar'});    
    
    % default values
    rot = 0;
    rr  = r;
    v1  = 1;
    v2  = 1;
   
    % scan options
    if ~isempty(varargin)
        if ~ischar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real', 'scalar'});
            varargin(1) = [];
        end
    end
    if ~isempty(varargin)
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:length(varargin)
            if ~ischar(varargin{k})
                continue
            end
            switch lower(varargin{k})
                case '-in'
                    % draw circumgon
                    rr = r/cosd(180/n);
                    id(k:k) = 1;
                case '-out'
                    rr = r;
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
    
    % calculate points
    [x, y] = evalNgon( n, rr, xc, yc, rot, v1, v2);
    
    % plot polygon
    if nargout == 0
        fill(x,y,c,varargin{:},'EdgeColor','none')        
    else
        fill(x,y,c,varargin{:},'EdgeColor','none');
        p.r   = r;
        p.rr  = rr;
        p.xc  = xc;
        p.yc  = yc;
        p.xk  = x;
        p.yk  = y;
%        p.style = get(hp,'LineStyle');
%        p.width = get(hp,'LineWidth');
%        p.color = get(hp,'Color');  
    end
    
end
