function p = PCA2d( X, Y)
%PCA2d Principal components analysis in two-dimensions
%
%   Input:
%       X    -- data points x - coordinates
%       Y    -- data points y - coordinates
%
%   Output:
%       structure with fields
%       xm, ym   -- average location
%       s1, s2   -- stdev in principal axes 
%       th1, th2 -- principal axes inclination angles (in degrees)
%       S        -- PCA matrix
%       C        -- PC coefficients
%
%   Matlab functions called:
%       atan2d, maen, isvector, isequal, isnan, length, size, sqrt
%
    p.xm  = [];
    p.ym  = [];
    p.s1  = [];
    p.s2  = [];
    p.th1 = [];
    p.th2 = [];
    p.S   = [];
    p.C   = [];
    
    % check input
    narginchk(2,2)
    nargoutchk(0,7)
    
    % check input    
    validateattributes(X,   {'numeric'}, {'real',   'vector'});    
    validateattributes(Y,   {'numeric'}, {'real',   'vector'});
    if ~isequal(length(X),length(Y))
        error('The length of X and Y must be equal.')
    end

    % mean values
    p.xm = mean(X);
    p.ym = mean(Y);
    
    % calculate sums
    nd  = length(X);
    sx2 = 0;
    sxy = 0;
    sy2 = 0;
    nn  = 0;
    for n = 1:nd
        if isnan(X(n)) || isnan(Y(n))
            continue
        end
        nn = nn + 1;
        sx2 = sx2 + (X(n) - p.xm)^2;
        sxy = sxy + (X(n) - p.xm)*(Y(n) - p.ym);
        sy2 = sy2 + (Y(n) - p.ym)^2;
    end
    
    if nn <= 1
        warning('*** PCA2d error: invalid data. Principal directions are not calculated.');
        return
    end
    
    sx2 = sx2/(nn - 1);
    sxy = sxy/(nn - 1);
    sy2 = sy2/(nn - 1);
    
    % principal dierctions    
    p.th1  = 0.5*atan2d(2*sxy,(sx2 - sy2));
    p.th2  = p.th1 + 90;
    
    % stdev in principal directions
    s12  = ((sx2 + sy2) + sqrt((sx2 - sy2)^2 + 4*sxy^2))/2;
    s22  = ((sx2 + sy2) - sqrt((sx2 - sy2)^2 + 4*sxy^2))/2;    
    p.s1   = sqrt(s12);
    p.s2   = sqrt(s22);
    
    % pack output
    p.S   = [sx2, sxy; sxy, sy2];
    p.C   = [cosd(p.th1) sind(p.th1); cosd(p.th2) sind(p.th2)];
  
end