function [x, y] = evalRect( wd, ht, xr, yr, rot, ip, v1, v2 )
%EVALRECT Compute vertices of rectangle in CCW direction
%
%Usage:
%  [x, y] = evalRect( wd, ht, xr, yr, rot, ir, v1, v2 )
%
%Input:
%   wd       -- width
%   ht       -- height
%   xr, yr   -- reference point
%   rot      -- rotation of rectangle about reference point in radians
%   ip       -- reference point number
%   v1,v2    -- start and end vertex: 1,..,4
% 
%Output:
%   x, y     --- rectangle vertices (column vectors)
%
%Note:
%   rectangle reference points codes:
%
%               left   mid   right
%       top       7     8     9
%       mid       4     5     6
%       bottom    1     2     3

    narginchk(8,8)
    nargoutchk(2,2)

    validateattributes(wd,  {'numeric'}, {'positive', 'real', 'scalar'});     
    validateattributes(ht,  {'numeric'}, {'positive', 'real', 'scalar'}); 
    validateattributes(xr,  {'numeric'}, {'real', 'scalar'});    
    validateattributes(yr,  {'numeric'}, {'real', 'scalar'});     
    validateattributes(rot, {'numeric'}, {'real', 'scalar'});   
    validateattributes(ip,  {'numeric'}, {'>',0,'<=',9,'integer', 'scalar'});      
    validateattributes(v1,  {'numeric'}, {'>',0,'<=',4,'integer', 'scalar'});   
    validateattributes(v2,  {'numeric'}, {'>',0,'<=',4,'integer', 'scalar'});     
       
    % calculate coordinates
    xx = zeros(5,1);
    yy = zeros(5,1);
    xx(2) = wd;
    xx(3) = wd;
    yy(3) = ht;
    yy(4) = ht;
    
    % position of rotation point
    if ip ~= 1
        dx = 0;
        dy = 0;
        switch ip
            case {2,5,8}
                dx = -wd/2;
            case {3,6,9}
                dx = -wd;
        end
        switch ip
            case {4,5,6}
                dy = -ht/2;
            case {7,8,9}
                dy = -ht;
        end
        xx = xx + dx;
        yy = yy + dy;
    end
    
    % rotate coordinates
    [x,y] = trRot2d( xx, yy, xr, yr, rot);

    % selet polyline
    if v1 < v2
        x = x(v1:v2);
        y = y(v1:v2);
    elseif v1 > v2
        x = [x(v1:end);x(1:v2)];
        y = [y(v1:end);y(1:v2)];
    else
        % close rectangle
        x(5) = x(1);
        y(5) = y(1);
    end
    
end
