function p = drawDonut(  d1, d2, xc, yc, varargin )
%DRAWDONUT Draw donut, i.e. two concentric circles.
%
% Usage:
%   drawDonut( d1, d2 , xc, yc)
%   drawDonut( d1, d2 , xc, yc, LineSpec)
%   drawDonut( d1, d2 , xc, yc, '-np',40)
%   p = drawDonut(__)
%
% Input:
%   d1       -- diameter of outer circle 
%   d2       -- diameter of inner circle
%   xc, yc   -- circle center
%
%
% Optional name-value pairs input:
%   '-np',np -- the number of points in the output curve
%   LineSpec -- options for plot   
%
%Optional output
%   p    -- structure containing key points.
%
    narginchk(4,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(d1, {'numeric'}, {'positive','real','scalar'});
    validateattributes(d2, {'numeric'}, {'positive','real','scalar'});    
    validateattributes(xc, {'numeric'}, {'real',   'scalar'});    
    validateattributes(yc, {'numeric'}, {'real',   'scalar'}); 
    
    % default values
    np = 360; % default number of points in the arc
         
    % scan options
    if ~isempty(varargin)  
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
            switch lower(varargin{k})
                case {'-np','-numpts'}
                    np = varargin{k + 1};
                    validateattributes(np, {'numeric'}, {'>',2,'integer','scalar'});                    
                    id(k:k+1) = 1;  
                    break  % only additional option
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end  
      
    % calculate points in arc
    [x1,y1] = evalCircle(xc, yc, d1/2, linspace(0, 360, np)');
    [x2,y2] = evalCircle(xc, yc, d2/2, linspace(0, 360, np)');
    
    % plot circles
    c = gkPlot(x1,y1,varargin{:});  
    gkPlot(x2,y2,'Color',c)
    
    % pack output
    if nargout > 0
        p.xk(1) = xc - d1/2;  % left
        p.yk(1) = yc;
        p.xk(2) = xc + d1/2;  % right
        p.yk(2) = yc;
        p.xk(3) = xc;         % bottom
        p.yk(3) = yc - d1/2;
        p.xk(4) = xc;         % top
        p.yk(4) = yc + d1/2;
        p.xk(5) = xc;         % center
        p.yk(5) = yc;        
        p.color = c;
    end
    
end
