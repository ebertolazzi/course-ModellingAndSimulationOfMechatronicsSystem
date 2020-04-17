function p = drawLoad(wd,h1,h2,nc,d,xr,yr,varargin)  
%DRAWLOAD  Draw distributed load.
%
%History:
%   2019,May   - MB created
%
% Usage:
%   drawLoad(wd,h1,h2,nc,xr,yr,rot,varargin) 
%
%Input:
%   wd       -- width, 0= force
%   h1,h2    -- height
%   nc       -- number of interior vertical lines
%   d        -- disatnce from reference point
%   xr, yr   -- reference point 
%
%Optional input:
%   rot        -- rotation of rectangle about reference point in degrees
%
%Optional Name-Value Pair Input:
%   '-ad',ad -- set arrowhead width
%   LineSpec - specifies line properties, see Line Properties.
%
%Optional Name-Value Pair Input:
%   LineSpec - specifies line properties, see Line Properties.
%
%   p        --- structure with key points and color.

    narginchk(7,inf)
    nargoutchk(0,1)
    
    validateattributes(nc,   {'numeric'}, {'positive','integer','scalar'});
    validateattributes(xr,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(yr,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(wd,   {'numeric'}, {'>',0,   'real',   'scalar'});    
    validateattributes(d,    {'numeric'}, {'real',   'scalar'});     
    validateattributes(h1,   {'numeric'}, {'real',   'scalar'});   
    validateattributes(h2,   {'numeric'}, {'real',   'scalar'});    
    
    % scan options
    rot = 0;
    if nargin > 7
        if ~isempty(varargin)
            if ~ischar(varargin{1})
                rot = varargin{1};
                validateattributes(rot, {'numeric'}, {'real', 'scalar'});
                varargin(1) = [];
            end
        end
    end    
     
    % defualt value
    ad1 = (h2 + h1)/2*0.2;
    if ~isempty(varargin)
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
            switch lower(varargin{k})
                case '-ad'
                    ad1 = varargin{k + 1};
                    validateattributes(ad1, {'numeric'}, {'positive','real','scalar'});
                    id(k:k+1) = 1;
                    break  % only additional option
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end
    
    % calculate points
    x(1) = wd; y(1) = 0;
    x(2) = wd; y(2) = h2;
    x(3) = 0;  y(3) = h1;
    x(4) = 0;  y(4) = 0;
    tt = linspace(0,wd,nc+2);
    n =0;
    xc = zeros(2*nc,1);
    yc = zeros(2*nc,1);
    for k = 1:2:2*nc
        n = n+1;
        t = tt(n+1);
        xc(k) = t; %n*wd/(nc+1);
        yc(k) = 0;
        xc(k+1) = xc(k);
        yc(k+1) = h1 + (h2-h1)/wd*xc(k);
    end
    
    % rotate
    [xx,yy] = trRot2d(d,0,xr,yr,rot); % get reference point
    [x,y] = trRot2d(x,y,xx,yy,rot);
    [xc,yc] = trRot2d(xc,yc,xx,yy,rot);
    
    hp = plot(x,y,varargin{:});
    cl = get(hp,'Color');
    drawArrow(-3,ad1,ad1/2,x(1),y(1),x(2),y(2),'Color',cl)
    drawArrow(-3,ad1,ad1/2,x(4),y(4),x(3),y(3),'Color',cl)
    for k = 1:2:2*nc
        % plot(xc(k:k+1),yc(k:k+1),'Color',cl)
        drawArrow(-3,ad1,ad1/2,xc(k),yc(k),xc(k+1),yc(k+1),'Color',cl)
    end
    if nargout > 0
        p.xk(1) = x(4);  % start
        p.yk(1) = y(4);
        p.xk(2) = x(1);  % end
        p.yk(2) = y(1);
        p.xk(3) = x(2);
        p.yk(3) = y(2);
        p.xk(4) = x(3);
        p.yk(4) = y(3);
    end
    
end

