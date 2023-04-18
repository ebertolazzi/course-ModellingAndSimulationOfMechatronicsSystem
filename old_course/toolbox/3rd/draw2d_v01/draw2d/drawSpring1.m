function p = drawSpring1(form,r,nc,x1,y1,varargin)  
%DRAWSPRING1  Draw a coil spring with plot attributes.
%
%History:
%   2019,May   - MB created
%
% Usage:
%   p = drawSpring1(form,r,nc,x1,y1,varargin)  
%
% Input:
%   form    --- spring type
%   r       --- radius
%   nc      --- number of circuts
%   x1, y1  --- start point
%
%Optional input:
%   x2, y2           -- end point
%   '-polar'|'-rtheta',  r, th -- polar coordiantes of end point
%   '-delta', dx, dy -- delta coordinates of end point
%
% Optional input:
%   varargin -- line spec.

    narginchk(7,inf)
    nargoutchk(0,1)

    validateattributes(form, {'numeric'}, {'positive','integer','scalar'});
    validateattributes(nc,   {'numeric'}, {'positive','integer','scalar'});
    validateattributes(x1,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(y1,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(r,    {'numeric'}, {'positive','real',   'scalar'});    
    
    if ~ischar(varargin{1})
        x2 = varargin{1};
        y2 = varargin{2};
        varargin(1:2) = [];
    else
        switch lower(varargin{1})
            case {'-polar','-rtheta'}
                rr = varargin{2};
                th = varargin{3};
                x2 = x1 + rr*cosd(th);
                y2 = y1 + rr*sind(th);
            case '-delta'
                dx = varargin{2};
                dy = varargin{3};                
                x2 = x1 + dx;
                y2 = y1 + dy;
            otherwise
                error('invalid option')
        end
        varargin(1:3) = []; %delete options
    end
       
    h = sqrt((x1 - x2)^2 + (y1 - y2)^2);
    rot = atan2d(y2 - y1, x2 - x1);
    
    % calculate points
    switch form
        case 1 % flat
            x = zeros(2*nc + 2,1);
            y = zeros(2*nc + 2,1);
            x(1) = -r;
            x(2) =  r;
            hc = h/(2*nc-1);
            for k = 3:2*nc + 2
                x(k) = -x(k - 1);
                y(k) = y(k-1) + hc;
            end
            y(end) = y(end - 1);
        case 2
            x = zeros(2*nc + 4,1);
            y = zeros(2*nc + 4,1);
            hc = h/(2*nc+2);
            x(3) = r;
            y(2) = hc;
            y(3) = hc+hc/2;
            for k = 4:2*nc + 4
                x(k) = -x(k - 1);
                y(k) = y(k - 1) + hc;
            end
            x(end-1:end) = 0;
            y(end)   = y(end) - hc/2;
            y(end-1) = y(end) - hc;
    end
    
    % rotate
    [xx,yy] = trRot2d(x,y,x1,y1,rot - 90);
       
    % plot spring
    c = gkPlot(xx,yy,varargin{:});
    
    if nargout > 0 
        p.xk(1) = x1;  % start point
        p.yk(1) = y1;
        p.xk(2) = x2;  % end point
        p.yk(2) = y2;
        p.color = c;
    end
        
    
end

