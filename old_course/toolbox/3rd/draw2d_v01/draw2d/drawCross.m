function p = drawCross(  d1, d2, xc, yc, varargin )
%DRAWCROSS Draw cross.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawCross(  d1, d2, xc, yc )
%   drawCross(  d1, d2, xc, yc, rot )
%   drawCross(  d1, d2, xc, yc, LineSpec)
%   p = drawCross(__)
%
%Input:
%   d1       -- length of major arm
%   d2       -- length of minor arm
%   xc, yc   -- cross center
%
%Optional input:
%   rot      -- rotation angle
%
% Optional name-value pairs input:
%   LineSpec -- options for plot   
%
%Optional output
%   p        --- structure with fields containing key points,
%
    narginchk(4,inf)
    nargoutchk(0,1)

    validateattributes(d1, {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(d2, {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(xc, {'numeric'}, {'real', 'scalar'});    
    validateattributes(yc, {'numeric'}, {'real', 'scalar'});
    
    % default values
    rot = 0;
         
    % scan options
    if nargin > 4
        if ~ischar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real', 'scalar'});            
            varargin(1) = [];
        end        
    end  
      
    % calculate coordinates of end points of th ecross lines
    if rot ~= 0
        x1(1) = xc - d1*cosd(rot);
        y1(1) = yc - d1*sind(rot);
        x1(2) = xc + d1*cosd(rot);
        y1(2) = yc + d1*sind(rot);
        x2(1) = xc - d2*cosd(rot+90);
        y2(1) = yc - d2*sind(rot+90);
        x2(2) = xc + d2*cosd(rot+90);
        y2(2) = yc + d2*sind(rot+90);
    else
        x1(1)   = xc - d1;
        x1(2)   = xc + d1;
        y1(1:2) = yc;
        x2(1:2) = xc;
        y2(1)   = yc - d2;
        y2(2)   = yc + d2;
    end

    % draw cross
    hp = plot(x1,y1,varargin{:});
    style = get(hp,'LineStyle');
    width = get(hp,'LineWidth');
    color = get(hp,'Color');
    plot(x2,y2,'LineWidth',width,'LineStyle',style,'Color',color)
    if nargout > 0
        p.xk(1:2) = x1(1:2); % firs line
        p.yk(1:2) = y1(1:2);
        p.xk(3:4) = x2(1:2); % second line
        p.yk(3:4) = y2(1:2);        
        p.xk(5)   = xc;      % center
        p.yk(5)   = yc;
        p.color   = get(hp,'Color');
    end
    
end
