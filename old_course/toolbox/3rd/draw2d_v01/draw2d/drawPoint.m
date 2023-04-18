function p = drawPoint( form, d, xp, yp, varargin )
%DRAWPOINT Draw point in plane .
%
%History:
%   2019,May   - MB created
%
%Usage:
%  drawPoint( form, d, xp, yp )
%  drawPoint( form, d, xp, yp, rot )
%  drawNgon( __, LineStyle)
%  p = drawPoint(__)
%
%Input:
%   form -- form number
%   d    -- dimension
%   xp   -- coordinates of point
%   yp   -- 
%
% Optional input:
%   rot -- roation angle in degrees
% 
%Optional Name-Value Pair Input:
%   LineSpec - specifies line properties
%
%Optional Output Arguments
%   p    -- structure containing output data

    narginchk(4,inf)
    nargoutchk(0,1)
    
    validateattributes(form,{'numeric'}, {'>',0,'<',4,'integer', 'scalar'});       
    validateattributes(d,   {'numeric'}, {'positive', 'real', 'scalar'});     
    validateattributes(xp,  {'numeric'}, {'real', 'scalar'});  
    validateattributes(yp,  {'numeric'}, {'real', 'scalar'});    
         
    rot = 0;
    
    if nargin > 4
        if ~ischar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real', 'scalar'});            
            varargin(1) = [];
        end        
    end 
    
    % calculate points
    switch form
        case 1  % star
            [x, y] = evalNgon( 6, d/2, xp, yp, 30 + rot, 1, 1);
            c = gkPlot([x(1),x(4)],[y(1),y(4)],varargin{:});
            plot([x(2),x(5)],[y(2),y(5)],'Color',c);
            plot([x(3),x(6)],[y(3),y(6)],'Color',c);
        case 2 % square
            [x, y] = evalNgon( 4, d/2, xp, yp, 45 + rot, 1, 1);
            c =  gkPlot(x,y,varargin{:});
            [x,y] = trRot2d([0 0],[0 d/4*sqrt(2)],xp,yp,rot);
            plot(x,y, 'Color',c);
        case 3 % circle
            pp = drawCircle(xp,yp,d/2,varargin{:});
            c = pp.color;
            [x,y] = trRot2d([0 0],[0 d/2],xp,yp,rot);
            gkPlot(x,y, 'Color',c);
        case 4 % triangle
            [x, y] = evalNgon( 3, d/2, xp, yp, 60 + rot, 1, 1);
            c =  gkPlot(x,y,varargin{:});
           % c = get(hp,'Color');
           % [x,y] = trRot2d([0 0],[0 d/4*sqrt(2)],xp,yp,rot);
           % scatter(x,y, 'Color',c);            
        otherwise
    end
    
    if nargout > 0
        p.xk(1) = xp;
        p.yk(1) = yp;
        p.color = c;  
    end
    
end
