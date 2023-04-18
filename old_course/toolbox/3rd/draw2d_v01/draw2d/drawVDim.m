function drawVDim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
%DRAWVDIM Draw the vertical dimension.
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
    
    validateattributes(form, {'numeric'}, {'positive','integer','scalar'});
    validateattributes(ad1,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(ad2,  {'numeric'}, {'positive','real', 'scalar'});
    validateattributes(x1,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y1,   {'numeric'}, {'real', 'scalar'});
    validateattributes(x2,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y2,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(xt,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(yt,   {'numeric'}, {'real', 'scalar'});    
    
     if y2 < y1
         [x1,x2] = swap(x1,x2);
         [y1,y2] = swap(y1,y2);   
     end
     
    txt = num2str(y2 - y1);
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
    
    if isempty(varargin)
      %  lw = gkGet('LineWidth');
      %  lc = gkGet('LineColor');
      %  gkSet('LineWidth',1,'LineColor','k')
    end
    
    s1 = sign(xt - x1);
    s2 = sign(xt - x2);
    drawLine( x1 + s1*ad2,y1, xt + s1*ad2, y1, varargin{:})
    drawLine( x2 + s2*ad2,y2, xt + s2*ad2, y2, varargin{:})
    
    if yt >= y1 && yt <= y2
        drawLine( xt,y1,xt,y2,varargin{:})
    elseif yt > y2
        drawLine( xt,y1,xt,yt,varargin{:}) 
    elseif yt < y1
        drawLine( xt,yt,xt,y2,varargin{:})
    end
        
    rot = gkGet('rotation');
    hal = gkGet('HorizontalAlignment');
    val = gkGet('VerticalAlignment');
    gkSet('torg',2)
    gkSet('Rotation',90)    
    if yt < y1
        gkText(xt,yt,txt)
    elseif yt > y2
        gkText(xt,yt,txt)
    else
        gkText(xt,(y1 + y2)/2,txt)
    end
    gkSet('rotation',rot);
    gkSet('HorizontalAlignment',hal);
    gkSet('VerticalAlignment',val);
    
    if 2*ad1 < (y2 - y1)
        drawArrowhead(form,ad1,ad2,xt,y1,-90)
        drawArrowhead(form,ad1,ad2,xt,y2, 90)
    else
        drawArrowhead(form,ad1,ad2,xt,y1, 90)
        drawArrowhead(form,ad1,ad2,xt,y2,- 90)
        if yt > y2
            drawLine(xt,y1-2*ad1,xt,y1)
        elseif yt < y1
            drawLine(xt,y2,xt,y2+2*ad1)
        end
    end
    
end
    