function drawHDim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
%DRAWHDIM Draw the horizontal dimension.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawHdim( form, ad1, ad2, x1, y1, x2, y2, x3, y3, varargin)
%   drawHdim( __, LineSpec)
%
%Input:
%   form     -- arrowhead type number: if <0 swap tail and head
%   ad1, ad2 -- arrowhead dimensions
%   x1,y1    -- first point coordinates 
%   x2,y2    -- second point
%   xt,yt    -- text location
%
%Optional name-value pairs input:
%   LineSpec --- plot options
%

    narginchk(9,inf)
    nargoutchk(0,0)
    
    % check input
    validateattributes(form, {'numeric'}, {'positive','integer','scalar'});
    validateattributes(ad1,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(ad2,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(x1,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y1,   {'numeric'}, {'real', 'scalar'});
    validateattributes(x2,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y2,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(xt,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(yt,   {'numeric'}, {'real', 'scalar'});    
    
     if x2 < x1
         [x1,x2] = swap(x1,x2);
         [y1,y2] = swap(y1,y2);        
     end
     
    txt = num2str(x2 - x1);
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
    
    s1 = -sign(yt - y1);
    s2 = -sign(yt - y2);
    
    drawLine( x1,y1 - s1*ad2, x1, yt - s1*ad2, varargin{:})
    drawLine( x2,y2 - s2*ad2, x2, yt - s2*ad2, varargin{:})
    
    if xt >= x1 && xt <= x2
        drawLine( x1,yt,x2,yt,varargin{:})
    elseif xt > x2
        drawLine( x1,yt,xt,yt,varargin{:}) 
    elseif xt < x1
        drawLine( xt,yt,x2,yt,varargin{:})
    end
    
    rot = gkGet('rotation');
    hal = gkGet('HorizontalAlignment');
    val = gkGet('VerticalAlignment');    
    gkSet('torg',2)
    gkSet('Rotation',0)
    if xt < x1
        gkText(xt,yt,txt)
    elseif xt > x2
        gkText(xt,yt,txt)
    else
        gkText((x1 + x2)/2,yt,txt)
    end
    gkSet('rotation',rot);
    gkSet('HorizontalAlignment',hal);
    gkSet('VerticalAlignment',val);
    
    if 2*ad1 < (x2 - x1)
        drawArrowhead(form,ad1,ad2,x1,yt,180)
        drawArrowhead(form,ad1,ad2,x2,yt,  0)
    else
        drawArrowhead(form,ad1,ad2,x1,yt,0)
        drawArrowhead(form,ad1,ad2,x2,yt,180)
        if xt > x2
            drawLine(x1-2*ad1,yt,x1,yt)
        elseif xt < x1
            drawLine(x2,yt,x2+2*ad1,yt)
        end
    end
    
end
    