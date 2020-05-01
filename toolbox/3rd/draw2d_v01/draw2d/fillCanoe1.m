function p = fillCanoe1( c, ht, x1, y1, varargin )
%FILLCANOE1 Fill canoe i.e. rectangle with rounded ends.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   fillCanoe1( c, ht, x1, y1 )
%   fillCanoe1( c, ht, x1, y1, x2, y2 )
%   fillCanoe1( c, ht, x1, y1, '-delta',dx, dy )
%   fillCanoe1( c, ht, x1, y1, '-polar',r, th )
%   fillCanoe1( __, '-pos', ipa)
%   fillCanoe1( __, LineSpec )
%   p = fillCanoe1(__)
%
%Input:
%   ht       -- height
%   x1,y1    -- start point (pos=4) 
%   x2,y2    -- end point (pos = 6)
%   or
%   '-delta',dx,dy
%   or
%   '-polar',r,th
%
%Optional input:
%   rot      -- rotation about reference point in degrees
%
%Optional Name-Value Pair Input:
%   '-pos', ip -- reference point number (default is 5 i.e. center)
%   '-np',np   -- the number of points in the output curve
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
%   p        --- structure with fields containing key points and color.
%
    narginchk(4,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(ht,  {'numeric'}, {'positive','real','scalar'});
    validateattributes(x1,  {'numeric'}, {'real','scalar'});    
    validateattributes(y1,  {'numeric'}, {'real','scalar'});  
       
    % scan options
    if ~ischar(varargin{1})
        x2 = varargin{1};
        y2 = varargin{2};
        varargin(1:2) = [];
    else
        switch lower(varargin{1})
            case {'-polar','-rtheta'}
                r = varargin{2};
                th = varargin{3};
                x2 = x1 + r*cosd(th);
                y2 = y1 + r*sind(th);
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
       
    % calculate canoe width and rotation angle
    wd = sqrt((x1 - x2)^2 + (y1 - y2)^2)+ht;
    rot = atan2d(y2 - y1, x2 - x1);
    
    pp = fillCanoe(c, wd, ht, x1, y1, rot, '-pos',4,varargin{:});
    
    if nargin > 0
        p = pp;
    end
        
end
