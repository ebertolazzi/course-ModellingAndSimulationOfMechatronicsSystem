function [x, y] = evalConic( a, b, c, d, e, f, t)
%EVALCONIC Compute the points on the conic section.
%
% Usage:
%   evalConic( a, b, c, d, e, f, t )
%
% Input:
%   a,..,f   -- coeficients
%   t        -- values of parameter
% 
% Output:
%   x, y     --- points on conic
%

    narginchk(7,7)
    nargoutchk(2,2)
    
    q1 = det([a b/2 d/2; b/2 c e/2; d/2 e/2 f]);
    q2 = det([a b/2; b/2 c]);
    q3 = a + c;
    
    if q2 > 0 && q2*q3 < 0
        % ellipse
        a = sqrt(-f/a);
        b = sqrt(-f/c);
        x = a*cos(t);
        y = b*sin(t);
    elseif q2 < 0 %% q2 ~= 0
        % hyperbola
        if f*a < 0 && f*c > 0
            a = sqrt(-f/a);
            b = sqrt(f/c);
        elseif f*a > 0 && f*c < 0
            a = sqrt(f/a);
            b = sqrt(-f/c);
        end
            x = a*sec(t);
            y = b*tan(t);
    elseif q2 == 0 && q1 ~= 0
        % parabola
        if a ~= 0 && e ~= 0
            x = t;
            y = -(a/e)*t.^2;
        elseif c ~= 0 && d ~= 0
            x = - (c/d)*t.^2;
            y = t;
        end
    else
        error('Not a conic')
    end
        
end


