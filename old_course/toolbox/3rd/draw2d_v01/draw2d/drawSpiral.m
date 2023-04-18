function p = drawSpiral( a, sang, eang, varargin)
%DRAWSPIRAL  Draw Archimedes' spiral with plot attributes
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawSpiral(a, sang, eang )
%   drawSpiral(a, sang, eang, LineSpec )
%   drawSpiral(a, sang, eang, xc, yc, rot, LineSpec )
%   p = drawSpiral(__)
%
%Input:
%   a        --- distance between succesive turns 
%   sang     --- spral start angle in degrees
%   eang     --- spral end angle in degrees
%
% Optional arguments:
%   xc, yc   --- center
%   rot      --- rotation angle about the center in degrees
%
% Optional name-value pairs input:
%   '-np',np -i- the number of points in the output curve (>1)
%   LineSpec --- options for plot   
%
%Optional output
%   p    -- structure containing key points
%

    narginchk(3,inf)
    nargoutchk(0,1)

    validateattributes(a,    {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(sang, {'numeric'}, {'>=',0,'real', 'scalar'});
    validateattributes(eang, {'numeric'}, {'positive','real', 'scalar'});

    % default values
    np = max(3,fix(eang - sang));    % number of points
    xc = 0;
    yc = 0;
    rot = 0;

    % scan options
    if nargin > 3
        if ~ischar(varargin{1})
            xc = varargin{1};
            validateattributes(xc, {'numeric'}, {'real', 'scalar'});
            varargin(1) = [];
        end
        if ~ischar(varargin{1})
            yc = varargin{1};
            validateattributes(yc, {'numeric'}, {'real', 'scalar'});
            varargin(1) = [];
        end
        if ~ischar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real', 'scalar'});
            varargin(1) = [];
        end
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
            switch lower(varargin{k})
                case {'-np','-numpts'}
                    np = varargin{k + 1};
                    id(k:k+1) = 1;
                    break % no othe options
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end

    % generate points
    [x,y] = evalSpiral(a,xc,yc,rot,linspace(sang,eang,np)');

    % plot spiral
    c = gkPlot(x,y,varargin{:});
    
    if nargout > 0
        p.xk(1) = x(1); % start point
        p.yk(1) = y(1);
        p.xk(2) = x(end); % end point
        p.yk(2) = y(end);
        p.xk(3) = xc;
        p.yk(3) = yc;
        p.color = c;
    end
    
end

