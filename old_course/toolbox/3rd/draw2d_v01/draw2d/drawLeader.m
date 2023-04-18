function p = drawLeader( form, ad1, ad2, xh, yh, xt, yt, varargin)
%DRAWLEADER Draw one or more lines where the first line begin with arrowhead.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawLeader( form, ad1, ad2, xh, yh, x, y)
%   drawLeader( __, LineSpec)
%
%Input:
%   ad1     - arrowhead height (real scalar >0)
%   ad2     - arrowhead width (real scalar >0)
%   xh,yh   - arrowhead coordinates (real scalar)
%   xt,yt   - tail coordinate pairs for the segments (real vector)
%
%Optional Name-Value Pair Input Arguments
%   LineSpec - specifies line properties
%
%Optional output arguments
%   p    -- structure containing key points and color.
%

    narginchk(7,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(form, {'numeric'}, {'integer','scalar'});
    validateattributes(ad1,  {'numeric'}, {'positive','real',   'scalar'});
    validateattributes(ad2,  {'numeric'}, {'positive','real',   'scalar'});
    validateattributes(xh,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(yh,   {'numeric'}, {'real',   'scalar'});
    validateattributes(xt,   {'numeric'}, {'real',   'vector'});    
    validateattributes(yt,   {'numeric'}, {'real',   'vector'});    
      
    c = gkPlot(xt,yt,varargin{:});
    hp = plot([xt(1),xh],[yt(1),yh],'Color',c);
    drawArrowhead( form, ad1, ad2, xh, yh, atan2d(yh - yt(1), xh - xt(1)), ...
        'Color',c)
    
    if nargout > 0
        p.xk(1) = xh; % start
        p.yk(1) = yh;        
        p.xk(2) = xt(end); % end point
        p.yk(2) = yt(end);
        p.color = get(hp,'Color');
    end
end
    