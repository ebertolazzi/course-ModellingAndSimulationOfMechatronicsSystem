function p = drawRect( wd, ht, xr, yr, varargin )
%DRAWRECT Draw rectangle with plot attributes.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawRect( wd, ht, xr, yr )
%   drawRect( wd, ht, xr, yr, rot )
%   drawRect(__, '-pos', ip)
%   drawRect(__, '-v', v1, v2)
%   drawRect( __, LineStyle )
%   p = drawRect(__)
%
%Input:
%   wd       -- width
%   ht       -- height
%   xr, yr   -- reference point 
%
%Optional input:
%   rot        -- rotation of rectangle about reference point in degrees
%   '-pos', ip -- reference point number (default is 1)
%   '-v',v1,v2 -- start and end vertices
%
%Optional Name-Value Pair Input:
%   LineSpec - specifies line properties, see Line Properties.
%
%   rectangle regference point codes:
%
%               left   mid   right
%       top       7     8     9
%       mid       4     5     6
%       bottom    1     2     3
%
%Optional Output Arguments
%   p    -- structure with key points and color
%
    narginchk(4,inf)
    nargoutchk(0,1)
         
    validateattributes(wd, {'numeric'}, {'positive', 'real', 'scalar'});  
    validateattributes(ht, {'numeric'}, {'positive', 'real', 'scalar'});    
    validateattributes(xr, {'numeric'}, {'real', 'scalar'});  
    validateattributes(yr, {'numeric'}, {'real', 'scalar'});  
    
    % set default values
    ip   = 1;  % position of reference point
    rot = 0;  % no inclination
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
        try
            id = zeros(length(varargin),1); % use for delition of options
            for k = 1:length(varargin)
                if ~ischar(varargin{k})
                    continue
                end
                switch lower(varargin{k})
                    case '-pos'
                        ip = varargin{k+1};
                         validateattributes(ip, {'numeric'}, {'>',0,'<',10,'integer','scalar'});
                        id(k:k+1) = 1;                    
                    case '-np'
                        np = varargin{k + 1};
                        validateattributes(np, {'numeric'}, {'>',2,'integer','scalar'});
                        id(k:k+1) = 1;
                        break  % only additional option
                    case '-v'
                        v1 = varargin{k + 1};
                        v2 = varargin{k + 2};
                        validateattributes(v1, {'numeric'}, {'>=',1,'<=',4,'integer','scalar'});
                        validateattributes(v2, {'numeric'}, {'>=',1,'<=',4,'integer','scalar'});
                        id(k:k+2) = 1;
                    otherwise
                end
            end
            % delete used options
            varargin(id == 1) = [];
        catch
            error('Invalid optional input.')
        end
    end    
    
    % calculate coordinates
    [x,y] = evalRect( wd, ht, xr, yr, rot, ip, v1, v2);
   
    % plot
    c = gkPlot(x,y,varargin{:});
    if nargout > 0
        [x,y] = evalRect( wd, ht, xr, yr, rot, ip, 1, 1);
        p.xk    = [x(1), (x(1) + x(2))/2, x(2),...
            (x(1) + x(4))/2, (x(1) + x(3))/2, (x(2) + x(3))/2,...
            x(4), (x(3) + x(4))/2, x(3)]';
        p.yk    = [y(1), (y(1) + y(2))/2, y(2),...
            (y(1) + y(4))/2, (y(1) + y(3))/2, (y(2) + y(3))/2,...
            y(4), (y(3) + y(4))/2, y(3)]';
        p.color = c;
    end
    
end
