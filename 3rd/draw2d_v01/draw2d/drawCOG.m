function drawCOG( dia, xc, yc, varargin) 
%DRAWCOG  Draw Center of Gravity Symbol.
%
%History:
%   2019,May   - MB created
%
%Usege:
%   drawCOG(xc,yc,r)
%   drawCOG(xc,yc,r,th)
%   drawCOG(xc,yc,r,LineSpec)
%
%Input:
%   dia         -- diameter
%   xc, yc      -- center point
%
%Optional arguments:
%   rot         -- rotation angle in degrees.
%   FillSpec    -- fill options
%
    narginchk(3,inf)
    narginchk(3,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(dia,  {'numeric'}, {'positive','real',   'scalar'});
    validateattributes(xc, {'numeric'}, {'real',   'scalar'});    
    validateattributes(yc, {'numeric'}, {'real',   'scalar'});  
    
    % set default value
    rot = 0;
    
    %scan options
    if nargin > 3
        if isreal(varargin{1}) && isscalar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real','scalar'});             
            varargin(1) = [];
        end
    end
    
    % get color for fill function
    hp = plot(xc,yc,varargin{:}); % dummy, just to get color
    c = get(hp,'Color');
    
    % plot symbol
    fillCircle('w',xc,yc,dia/2,'EdgeColor','none')
    fillCircle(c,xc,yc,dia/2,  0 + rot,90,'-pie','EdgeColor','none')
    fillCircle(c,xc,yc,dia/2,180 + rot,90,'-pie','EdgeColor','none')
    drawCircle(xc,yc,dia/2,'Color',c)   
    
end


