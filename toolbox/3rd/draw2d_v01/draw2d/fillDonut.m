function p = fillDonut(  c1, c2, d1, d2, xc, yc, varargin )
%FILLDONUT Fill donut, i.e. two concentric circles.
%
% Usage:
%   fillDonut( c1, c2, d1, d2 , xc, yc)
%   fillDonut( c1, c2, d1, d2 , xc, yc, LineSpec)
%   fillDonut( c1, c2, d1, d2 , xc, yc, '-np',40)
%   p = fillDonut(__)
%
% Input:
%   c1, c2   -- color
%   d1       -- diameter of outer circle 
%   d2       -- diameter of inner circle
%   xc, yc   -- circle center
%
%
% Optional name-value pairs input:
%   '-np',np -- the number of points in the output curve (>1)
%   LineSpec -- options for plot   
%
%Optional output
%   p    -- structure containing an output data
%
    narginchk(6,inf)
    nargoutchk(0,1)
    
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
    fill(x1,y1,c1,varargin{:},'EdgeColor','none'); 
    fill(x2,y2,c2,'EdgeColor','none')
    if nargout > 0
        p.xk(1) = xc - d1/2;
        p.yk(1) = yc;
        p.xk(2) = xc + d1/2;
        p.yk(2) = yc;
        p.xk(3) = xc;
        p.yk(3) = yc - d1/2;
        p.xk(4) = xc;
        p.yk(4) = yc + d1/2;
    end
    
end
