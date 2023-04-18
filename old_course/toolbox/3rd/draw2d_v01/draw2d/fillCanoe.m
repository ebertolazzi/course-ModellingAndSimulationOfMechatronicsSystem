function p = fillCanoe( c, wd, ht, xr, yr, varargin )
%FILLCANOE Fill canoe.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   fillCanoe( c, wd, ht, xr, yr, rot )
%   fillCanoe( c, wd, ht, '-pos', ira)
%   fillCanoe( c, wd, ht, LineStyle )
%   p = fillCanoe(__)
%
%Input:
%   c        -- color
%   wd       -- width
%   ht       -- height
%   xr, yr   -- reference point 
%   rot      -- rotation about reference point in degrees
%
%Optional Name-Value Pair Input:
%   '-pos', ip -- reference point number (default is 5 i.e. center)
%   '-np',np   -- the number of points in the output curve (>1)
%   LineSpec   -- specifies line properties, see Line Properties.
%
%   rectangle regference point codes:
%
%               left   mid   right
%       top         7     8     9
%       mid     10  4     5     6  11
%       bottom      1     2     3
%
%   4,6 are circles center, 10,11 are boundary points
%
%Optional Output Arguments
%   p    -- structure containing an output data
%
    narginchk(5,inf)
    nargoutchk(0,1)
    
    validateattributes(wd,  {'numeric'}, {'positive','real','scalar'});
    validateattributes(ht,  {'numeric'}, {'positive','real','scalar'});
    validateattributes(xr,  {'numeric'}, {'real','scalar'});    
    validateattributes(yr,  {'numeric'}, {'real','scalar'});  
    
    % set default values
    ip = 5;  % position of reference point
    np = 90;
    rot = 0;
    
    if nargin > 5
        if ~ischar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real', 'scalar'});
            varargin(1) = [];
        end
    end
    % scan options
    if ~isempty(varargin)
        if ~isempty(varargin)
            id = zeros(length(varargin),1); % use for delition of options
            for k = 1:2:length(varargin)
                switch lower(varargin{k})
                    case '-pos'
                        ip = varargin{k+1};
                        validateattributes(ip, {'numeric'}, {'>',0,'<',12,'integer','scalar'});
                        id(k:k+1) = 1;
                    case '-np'
                        np = varargin{k+1};
                        validateattributes(np, {'numeric'}, {'>',2,'<',361,'integer','scalar'});
                        id(k:k+1) = 1;                        
                    otherwise
                end
            end
            % delete used options
            varargin(id == 1) = [];
        end
    end
    
    % calculate coordinates
    [x(1:np),y(1:np)] = evalCircle(wd-ht,ht/2,ht/2,linspace(-90,90,np)');
    [x(np+1:2*np),y(np+1:2*np)] = evalCircle(0*ht/2,ht/2,ht/2,linspace(90,270,np)');
    
    % position of reference point point
    if ip ~= 1
        dx = 0;
        dy = 0;
        switch ip
            case {2,5,8}
                dx = -(wd-ht)/2;
            case {3,6,9}
                dx = -(wd-ht);
            case 10
                dx = ht/2;
            case 12
                dx = -wd + ht/2;
        end
        switch ip
            case {4,5,6,10,11}
                dy = -ht/2;
            case {7,8,9}
                dy = -ht;
        end
        x = x + dx;
        y = y + dy;
    end   
    [x,y]  = trRot2d(x,y,xr,yr,rot);
    x(end) = x(1);
    y(end) = y(1);
        
    % plot
    fill(x,y,c,varargin{:},'EdgeColor','none')      
    
    if nargout > 0
        if ip == 10
            [x, y]  = evalRect(wd-ht,ht,xr+ht/2*cosd(rot),yr+ht/2*sind(rot),rot,4,1,1);
        elseif ip == 11
           [x, y]  = evalRect(wd-ht,ht,xr-ht/2*cosd(rot),yr-ht/2*sind(rot),rot,6,1,1);
        else
        [x, y]  = evalRect(wd-ht,ht,xr,yr,rot,ip,1,1);
        end
        p.xk    = [x(1), (x(1) + x(2))/2, x(2),...
            (x(1) + x(4))/2, (x(1) + x(3))/2, (x(2) + x(3))/2,...
            x(4), (x(3) + x(4))/2, x(3)]';
        p.yk    = [y(1), (y(1) + y(2))/2, y(2),...
            (y(1) + y(4))/2, (y(1) + y(3))/2, (y(2) + y(3))/2,...
            y(4), (y(3) + y(4))/2, y(3)]';
        [p.xk(10:11),p.yk(10:11)] = evalLine(p.xk(4),p.yk(4),p.xk(6),p.yk(6),...
            [-ht/(wd-ht)/2,1+ht/(wd-ht)/2]);         
    end
        
end
