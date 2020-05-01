function p = drawAxes( form, ad, a, xc, yc, varargin)
%DRAWAXES Draw coordinate axes.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawArrow( form, ad1, ad2, xc, yc)
%   drawArrow( form, ad1, ad2, xc, yc, rot)
%   drawArrow( __, LineSpec)
%   p = drawArrow(__)
%
%Input:
%   form     -- arrowhead type number
%   ad       -- arrowhead width, height is 0.5*ad
%   a        -- axes length
%   xc,yc    -- origin 
%
% Optional input:
%   rot -- roation angle in degrees
%
%Optional name-value pairs input:
%   LineSpec --- plot options
%
%   p        --- structure with fields containing key points and color.

    narginchk(5,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(form, {'numeric'}, {'>=',0,'integer','scalar'});
    validateattributes(ad,   {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(a,    {'numeric'}, {'positive','real', 'scalar'});    
    validateattributes(xc,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(yc,   {'numeric'}, {'real', 'scalar'});

    % set default values
    rot = 0;
         
    % scan options
    if nargin > 5
        if ~ischar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real', 'scalar'});            
            varargin(1) = [];
        end        
    end
   
    % draw axes
    hx = drawArrow( 3, ad, ad/2, xc, yc, '-rtheta', a, rot, varargin{:});
    hy = drawArrow( 3, ad, ad/2, xc, yc, '-rtheta', a, 90 + rot, 'Color',hx.color);
    drawPoint( 2, ad, xc, yc, rot, 'Color',hx.color);

    % pack output
    if nargout > 0
        p.xk(1) = hx.xk(1);  % center
        p.yk(1) = hx.yk(1);
        p.xk(2) = hx.xk(2);  % end of x-axis
        p.yk(2) = hx.yk(2);       
        p.xk(3) = hy.xk(2);  % end of y-axis
        p.yk(3) = hy.yk(2);       
        p.color = hx.color;          
    end
    
end
    