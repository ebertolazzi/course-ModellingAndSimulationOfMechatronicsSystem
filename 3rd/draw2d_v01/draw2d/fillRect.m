function p = fillRect( c, wd, ht, xr, yr, varargin )
%FILLRECT Fill rectangle with fill attributes.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   fillRect'( c, wd, ht, xr, yr )
%   fillRect'( c, wd, ht, xr, yr, rot )
%   fillRect'(__, '-pos', ip)
%   fillRect'(__, '-v', v1, v2)
%   fillRect'( __, LineStyle )
%   p = fillRect'(__)
%
%Input:
%   c        -- color
%   wd       -- width
%   ht       -- height
%   xr, yr   -- reference point 
%
%Optional input:
%   rot        -- rotation of rectangle about reference point in degrees
%
%Optional Name-Value Pair Input:
%   '-pos', ip -- reference point number (default is 1)
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
%   p    -- structure with output data
%
    narginchk(5,inf)
    nargoutchk(0,1)
         
    validateattributes(wd, {'numeric'}, {'positive', 'real', 'scalar'});  
    validateattributes(ht, {'numeric'}, {'positive', 'real', 'scalar'});    
    validateattributes(xr, {'numeric'}, {'real', 'scalar'});  
    validateattributes(yr, {'numeric'}, {'real', 'scalar'});  
    
    % set default values
    ip  = 1;  % position of reference point
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
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
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
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end
    
    % calculate coordinates
    [x,y] = evalRect( wd, ht, xr, yr, rot, ip, v1, v2);
   
    % plot 
    if nargout == 0
        fill(x,y,c,varargin{:},'EdgeColor','none')        
    else
        fill(x,y,c,varargin{:},'EdgeColor','none');
        [x,y] = evalRect( wd, ht, xr, yr, rot, ip, 1, 1);
        p.xk = [x(1), (x(1) + x(2))/2, x(2),...
            (x(1) + x(4))/2, (x(1) + x(3))/2, (x(2) + x(3))/2,...
            x(4), (x(3) + x(4))/2, x(3)]';
        p.yk = [y(1), (y(1) + y(2))/2, y(2),...
            (y(1) + y(4))/2, (y(1) + y(3))/2, (y(2) + y(3))/2,...
            y(4), (y(3) + y(4))/2, y(3)]';
    end
    
end
