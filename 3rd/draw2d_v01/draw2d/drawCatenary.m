function p = drawCatenary( x1, y1, dx, dy, varargin )
%DRAWCATENARY Draw 2D catenary.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawCatenary( x1, y1, dx, dy, L )
%   drawCatenary( x1, y1, dx, dy, '-L',L)
%   drawCatenary( x1, y1, dx, dy, '-h',h)
%   drawCatenary( x1, y1, dx, dy, L, LineSpec)
%   p = drawCatenary(__)
%
%Input:
%   x1, y1    -- start point
%   dx        -- horizontal distance between end points (>0)
%   dy        -- vertical distance between end points
%
%   L         -- catenary length
%
% Optional name-value pairs input
%   '-L',L      -- catenary length ( > 0)
%   '-h',h1     -- sag of the first point (> 0)
%   '-guess',c0 -- initial quess for fzero (> 0)
%   LineSpec    -- plot options
%
%Optional output:
%   p           --- structure with fields containing output data.

    narginchk(5,inf)
    nargoutchk(0,1)
    
    % check input
    validateattributes(x1, {'numeric'}, {'real', 'scalar'});    
    validateattributes(y1, {'numeric'}, {'real', 'scalar'});   
    validateattributes(dx, {'numeric'}, {'positive', 'real', 'scalar'});     
    validateattributes(dy, {'numeric'}, {'real', 'scalar'});     
    
    % default values
    np = 100;    % number of points on the curve
    z0 = 1;      % default initial quess
    kan = 1;     % type of data set
    
    % scan options

    if ~ischar(varargin{1})
        L = varargin{1};  % length is given
        kan = 1;
        varargin(1) = [];
    end
    if ~isempty(varargin)
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
            switch lower(varargin{k})
                case {'-np','-numpts'}
                    np = varargin{k + 1};
                    validateattributes(np, {'numeric'}, {'>',2,'<',1001,'integer','scalar'});
                    id(k:k+1) = 1; 
                case '-h'
                    h1 = varargin{k + 1};
                    validateattributes(h1, {'numeric'}, {'positive', 'real', 'scalar'});  
                    kan = 2;
                    id(k:k+1) = 1;                     
                case '-l'
                    L = varargin{k + 1};
                    validateattributes(L, {'numeric'}, {'positive','real', 'scalar'});  
                    kan = 1;
                    id(k:k+1) = 1; 
                case '-quess'
                    z0 = varargin{k + 1};
                    id(k:k+1) = 1;                     
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end
    
    Lmin = sqrt(dx^2 + dy^2);
    switch kan
        case 1 % L is given
            if Lmin > L
                error('Minimal length L should be %g, but got %g.',Lmin,L)
            end
            lambda = fzero( @fun1, z0);    
            s1 = 0.5*(dy*sqrt((L^2 - dy^2 + 4*lambda^2)/(L^2 - dy^2)) - L);
            s2 = L + s1;            
        case 2 % h1 is given (default)
            if h1 + dy < 0
                error('Catenary sag h1 should be > dy = %g, but got %g.',dy,h1)
            end
            lambda = fzero( @fun2, z0);
            %L1 = lambda*acosh(1 + h1/lambda);
            %L2 = lambda*acosh(1 + (h1 + dy)/lambda);
            s1 = -sqrt(h1*(h1 + 2*lambda));
            s2 =  sqrt((h1 + dy)*(h1 + dy + 2*lambda));
    end
        
    % calculate points
    [x, y] = evalCatenary( lambda, x1, y1, s1, linspace(s1,s2,np)');
    
    % plot the curve
    if nargout == 0
        plot(x,y,varargin{:})        
    else
        hp = plot(x,y,varargin{:});
        p.type = 'Catenary';
        p.x = x;
        p.y = y;
        [p.xa, p.ya] = evalCatenary( lambda, x1, y1, s1, 0);   % appex coord.         
        p.lambda = lambda;  
        p.s1 = s1;          % start parameter
        p.s2 = s2;          % end parameter
        p.L = s2 - s1;      % length of chain
        p.dx = x(end) - x(1);   % horiz. distance        
        p.dy = y(end) - y(1);   % vert. distance between end points
        p.h1 = y(1) - p.ya;     % sag of first point    
        p.h2 = y(end) - p.ya;   % sag of end point
        p.d1 = x(1) - p.xa;     % distance of first point to appex
        p.d2 = x(end) - p.xa;   % distance of end point to appex       
        p.xk(1) = x(1);     % start point
        p.yk(1) = y(1);  
        p.xk(2) = x(end);   % end point
        p.yk(2) = y(end);
        p.xk(3) = p.xa;     % appex
        p.yk(3) = p.ya;        
        p.color = get(hp,'Color');  
    end

    function z = fun1(c)
        % Equation for unknown characteristic length (L > dy)
        z = 2*c^2*(cosh(dx/c) - 1) - (L^2 - dy^2);
    end

    function z = fun2(c)
        % Equation for unknown characteristic length
        z=c*(acosh(1+h1/c)+acosh(1+(h1+dy)/c)) - dx;
    end


end


