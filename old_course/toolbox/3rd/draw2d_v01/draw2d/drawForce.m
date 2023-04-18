function p = drawForce(F,th,d,xr,yr,varargin)  
%DRAWFORCE  Draw force.
%
%History:
%   2019,May   - MB created
%
% Usage: 
%   drawForce(F,th,d,xr,yr,rot)
%   drawForce(__,'-ad',ad) 
%
%Input:
%   F,th     -- force and its local inclination angle in degrees
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
%   p        --- structure with key points and color.

    narginchk(5,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(xr,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(yr,   {'numeric'}, {'real',   'scalar'});        
    validateattributes(d,    {'numeric'}, {'real',   'scalar'});     
    validateattributes(F,    {'numeric'}, {'positive', 'real',   'scalar'});   
    validateattributes(th,   {'numeric'}, {'real',   'scalar'});   
     
    % defualt value
    ad1 = F*0.2;
    rot = 0;
    Fx = F*cosd(th);
    Fy = F*sind(th);
    
    % scan options
    if nargin > 6
        if ~isempty(varargin)
            if ~ischar(varargin{1})
                rot = varargin{1};
                validateattributes(rot, {'numeric'}, {'real', 'scalar'});
                varargin(1) = [];
            end
        end
    end
    
    if ~isempty(varargin)
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
            switch lower(varargin{k})
                case '-ad'  % arrowhead width
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
    
    x(1) = 0; y(1) = 0;
    x(2) = Fx; y(2) = Fy;
    
    % rotate
    [xx,yy] = trRot2d(d,0,xr,yr,rot); % get reference point
    [x,y] = trRot2d(x,y,xx,yy,rot);
    
    % draw
    drawArrow(3,ad1,ad1/2,x(2),y(2),x(1),y(1),varargin{:});
    
    if nargout > 0
        p.xk(1) = x(1);
        p.yk(1) = y(1);
        p.xk(2) = x(2);
        p.yk(2) = y(2);
        p.xk(3) = (x(1) + x(2))/2;
        p.yk(3) = (y(1) + y(2))/2;
    end
        
end

