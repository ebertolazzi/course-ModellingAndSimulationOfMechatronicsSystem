function p = drawSpring(x0,y0,r,h,nc,rot,varargin)  
%DRAWSPRING  Draw a coil spring with plot attributes.
%
%History:
%   2019,May   - MB created
%
% Usage:
%   drawSpring(x0,y0,L,theta,varargin) 
%
% Input:
%   x0, y0  --- base point (bottom, center)
%   r       --- radius
%   ht      --- spring length
%   nc      --- number of circuts
%   rot     --- spring inclination angle in deg (0, default)
%
% Optional input:
%   varargin --- options
%       '-type','flat' (default),'extend'
%       'Color',[0,0,0](default),'none'|RGB triplet|hexadecimal color code|'r'|'k'|...   
%       'LineStyle','-' (default)|'--'|':'|'-.'|'none'
%       'LineWidth',0.5 (default)|positive value

    narginchk(6,inf)
    nargoutchk(0,1)
    
    validateattributes(nc,   {'numeric'}, {'positive','integer','scalar'});
    validateattributes(x0,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(y0,   {'numeric'}, {'real',   'scalar'});    
    validateattributes(r,    {'numeric'}, {'positive','real',   'scalar'});   
    validateattributes(h,    {'numeric'}, {'real',   'scalar'});    
    validateattributes(rot,  {'numeric'}, {'real',   'scalar'});  
    
    % defaut values
    flat = true;
    
    % scan options
    if nargin > 6
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:length(varargin)
            switch lower(varargin{k})
                case '-type'
                    switch lower(varargin{k + 1})
                        case 'flat'
                            flat = true;
                        case {'extend','ext'}
                            flat = false;
                    end
                    id(k:k+1) = 1;               
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end 
    
    % calculate points
    if flat
        x = zeros(2*nc + 2,1);
        y = zeros(2*nc + 2,1);
        x(1) = -r;
        x(2) = r;
        hc = h/(2*nc-1);
        for k = 3:2*nc + 2
            x(k) = -x(k - 1);
            y(k) = y(k-1) + hc;
        end
        y(end) = y(end - 1);
    else
        x = zeros(2*nc + 4,1);
        y = zeros(2*nc + 4,1);
        hc = h/(2*nc+2);
        x(3) = r;
        y(2) = hc;
        y(3) = hc+hc/2;
        for k = 4:2*nc + 4
            x(k) = -x(k - 1);
            y(k) = y(k - 1) + hc;
        end
        x(end-1:end) = 0;
        y(end)   = y(end) - hc/2;
        y(end-1) = y(end) - hc;
    end
    
    % rotate
    [xx,yy] = trRot2d(x,y,x0,y0,rot - 90);
    %rot = rot - 90;
    %xx = x0 + x*cosd(rot) - y*sind(rot);
    %yy = y0 + x*sind(rot) + y*cosd(rot);
       
    % plot spring
    c = gkPlot(xx,yy,varargin{:});
    
    if nargout > 0
        p.xk(1) = x0;  % start point
        p.yk(1) = y0;
        [x,y] = trRot2d(h,0,x0,y0,rot);
        p.xk(2) = x;  % end point
        p.yk(2) = y;
        p.color = c;
    end
        
    
end

