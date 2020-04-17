function drawAngDim( form, ad1, ad2, xc, yc, sang, ang, rt, at, varargin)
%DRAWANGDIM Draw angle dimension.
%
%History:
%   2019,June   - MB created
%
%Usage:
%   drawAngDim( form, ad1, ad2, xc, yc, sang, ang, td, tang)
%   drawAngDim( __,'-str',str)
%   drawAngDim( __, LineSpec)
%
%Input:
%   form     -- arrowhead type number
%   ad1, ad2 -- arrowhead dimensions
%   xc,yc    -- center point 
%   sang     -- start angle in degrees
%   ang      -- central angle in degrees
%   rt, at   -- relative polar coordinates of the text location
%
%Optional name-value pairs input:
%   '-str',str -- text to plot
%   LineSpec --- plot options
%

    narginchk(9,inf)
    nargoutchk(0,0)
    
    % check input
    validateattributes(form, {'numeric'}, {'positive','integer','scalar'});
    validateattributes(ad1,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(ad2,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(xc,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(yc,   {'numeric'}, {'real', 'scalar'});
    validateattributes(sang, {'numeric'}, {'real', 'scalar'});    
    validateattributes(ang,  {'numeric'}, {'real', 'scalar'});    
    validateattributes(rt,   {'numeric'}, {'positive','real', 'scalar'});    
    validateattributes(at,   {'numeric'}, {'real', 'scalar'});    
    
    % default values
    txt = strcat(num2str(abs(ang)),'^0');
    
    % scan options
    if ~isempty(varargin)
        id = zeros(length(varargin),1); % use for delition of options
        for k = 1:2:length(varargin)
            switch lower(varargin{k})
                case {'-txt','-str'}
                    txt = varargin{k + 1};
                    if ~ischar(txt)
                        txt = num2str(txt);
                    end
                    id(k:k+1) = 1;
                    break  % no other extra option
                otherwise
            end
        end
        % delete used options
        varargin(id == 1) = [];
    end
      
    % draw arc arrows  
    drawArcArrow( form, ad1, ad2, xc, yc, rt, sang,        ang, varargin{:})
    drawArcArrow( form, ad1, ad2, xc, yc, rt, sang + ang, -ang, varargin{:})
        
    % calculate text location
    xt = xc + 1.075*rt*cosd(at + sang);
    yt = yc + 1.075*rt*sind(at + sang);
    
    % draw text
    rot = gkGet('rotation');
    hal = gkGet('HorizontalAlignment');
    val = gkGet('VerticalAlignment');    
    gkSet('torg',5)
    aa = atan2d(yt - yc,xt - xc) - 90;
    if abs(aa) > 180
        aa = aa + 180;
    end
    gkSet('Rotation',aa)
    gkText(xt,yt,txt)
    gkSet('rotation',rot);
    gkSet('HorizontalAlignment',hal);
    gkSet('VerticalAlignment',val);
    
    % draw arc to text
    %if at < ang && ang < 0
        drawCircle(xc,yc,rt,sang,at,varargin{:})
    %elseif at > sang && ang > 0
    %    drawCircle(xc,yc,rt,sang,at,varargin{:})      
    %end
end
    