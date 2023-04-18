function p = drawArc( xc, yc, x1, y1, x2, y2, varargin)
%DRAWARC Draw circular arc defined by center point and end points.
%
%History:
%   2019,June   - MB created
%
%Usage:
%   drawArc( xc, yc, x1, y1, x2, y2)
%   drawArc(__,'-large')
%   drawArc( __,'-np',np)
%   drawArc( __, LineSpec)
%
%Input:
%   xc,yc    -- center point 
%   x1, y1,  -- first point
%   x2, y2   -- second point
%
%Optional:
%  '-large' -- draw arc with central angle > 180
%
%Optional name-value pairs input:
%   LineSpec --- plot options
%

    narginchk(6,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(xc,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(yc,   {'numeric'}, {'real', 'scalar'});
    validateattributes(x1,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y1,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(x2,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y2,   {'numeric'}, {'real', 'scalar'});        
        
    lflg = false;
    if ~isempty(varargin)
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:length(varargin)
            if ~ischar(varargin{k})
                continue
            end
            switch lower(varargin{k})
                case '-np'
                    np = varargin{k + 1};
                    validateattributes(np, {'numeric'}, {'>',2,'integer','scalar'});
                    id(k:k+1) = 1;   
                case '-large'
                    lflg = true;
                    id(k:k) = 1;   
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end         
    
    % calculate start angle
    sang = atan2d(y1 - yc, x1 - xc);
    
    % calculate central angle
    d1 = sqrt((x1 - xc)^2 + (y1 - yc)^2);
    d2 = sqrt((x2 - xc)^2 + (y2 - yc)^2);
    sina  = ((x2 - xc)*(y1 - yc) - (x1 - xc)*(y2 - yc))/(d1*d2);
    cosa =  ((x2 - xc)*(x1 - xc) + (y1 - yc)*(y2 - yc))/(d1*d2);
    ang = -atan2d(sina,cosa);
    if lflg 
        if ang > 0
        ang = -360 + ang;
        else
            ang = 360 + ang;
        end
    end
    
    np = max(3,fix(abs(ang)));
    
    % draw arc
    pp = drawCircle( xc, yc, d1, sang, ang,'-np',np, varargin{:});
 
    if nargout > 0
        p = pp;
        p.xc = xc;
        p.yc = yc;
        p.r  = d1;
        p.sang = sang;
        p.ang  = ang;
    end
end
    