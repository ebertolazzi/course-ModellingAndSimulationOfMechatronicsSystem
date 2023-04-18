function [x, y] = evalNgon( nv, r, xc, yc, rot, v1, v2)
%EVALNGON Compute vertices of regular polygon (ngon) in CCW direction
%
% Usage:
%  [x, y] = evalNgon( nv, xc, yc, rot, v1, v2 )
%
% Input:
%   nv       --- number of vertices
%   r        --- radius
%   xc, yc   --- center
%   rot      --- rotation angle about the centre in degrees
%   v1,v2    --- start and end vertex in CCLW direction
% 
% Output:
%   x, y     --- polygon (column vectors)
%

    narginchk(7,7)
    nargoutchk(2,2)
    
    validateattributes(nv,  {'numeric'}, {'positive', 'integer', 'scalar'});  
    validateattributes(r,   {'numeric'}, {'positive', 'real', 'scalar'}); 
    validateattributes(xc,  {'numeric'}, {'real', 'scalar'});    
    validateattributes(yc,  {'numeric'}, {'real', 'scalar'});     
    validateattributes(rot, {'numeric'}, {'real', 'scalar'});          
    validateattributes(v1,  {'numeric'}, {'>',0,'<=',nv,'integer', 'scalar'});   
    validateattributes(v2,  {'numeric'}, {'>',0,'<=',nv,'integer', 'scalar'}); 
    
    dt = 360/nv;
    if v1 == v2
        t1 = rot;
        t2 = rot + 360 + dt;
    else
       if v1 < v2 
           v1 = max(1,v1);
           v2 = min(nv,v2);
           t1 = rot + (v1 - 1)*dt;
           t2 = rot + (v2 - 1)*dt;
       else
           v1 = max(1,v1);
           v2 = min(nv,v2);
           t1 = rot + (v1 - 1)*dt;
           t2 = t1 + (nv - v1 + v2)*dt;
       end
    end
    
    t = t1:dt:t2;
    x = xc + r*cosd(t);
    y = yc + r*sind(t);

end


