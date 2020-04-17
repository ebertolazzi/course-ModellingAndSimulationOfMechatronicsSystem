function drawLimits( xmin, xmax, ymin, ymax)
%DRAWLIMITS Set the clipping boundaries for the curent axes.
%
%History:
%   2019,May   - MB created
%
    narginchk(0,4)

    if nargin == 0        
        xlim auto;
        ylim auto;
    elseif nargin == 4
        validateattributes(xmin, {'numeric'}, {'real',   'scalar'});
        validateattributes(xmax, {'numeric'}, {'real',   'scalar'});
        validateattributes(ymin, {'numeric'}, {'real',   'scalar'});
        validateattributes(ymax, {'numeric'}, {'real',   'scalar'});
        xlim([xmin xmax]);
        ylim([ymin ymax]);
    end
end

