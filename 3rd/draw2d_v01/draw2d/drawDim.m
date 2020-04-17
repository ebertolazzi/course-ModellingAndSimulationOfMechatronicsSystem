function drawDim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
%DRAWDIM Draw the paralel dimension.
%
%History:
%   2019,May   - MB created
%
%Usage:
%   drawHdim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
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
    
    if x1 == x2
        drawVDim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
        return
    elseif y1 == y2
        drawHDim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
        return
    end
    
    if x2 < x1
         [x1,x2] = swap(x1,x2);
         [y1,y2] = swap(y1,y2);        
    end
     
    d = sqrt((x2 - x1)^2 + (y2 - y1)^2);
    th = atan2d(y2 - y1,x2 - x1);
    txt = num2str(d);
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
    
    % calculate local coordinates
    xx1 = 0;
    xx2 = d;
    xxt =  (xt - x1)*cosd(th) + (yt - y1)*sind(th);
    yyt = -(xt - x1)*sind(th) + (yt - y1)*cosd(th);
    d1 = ((xt - x1)*sind(th) - (yt - y1)*cosd(th));
    s  = -sign(d1);
    d1 = abs(d1);
    [x,y] = trRot2d([0 0],s*[ad2, d1 + ad2],x1,y1,th);
    drawLine(x(1),y(1),x(2),y(2),varargin{:})
    [x,y] = trRot2d([d d],s*[ad2, d1 + ad2],x1,y1,th);
    drawLine(x(1),y(1),x(2),y(2),varargin{:})    
    
    if xxt >= xx1 && xxt <= xx2
        [x,y] = trRot2d([0 d],s*[d1, d1],x1,y1,th);
        drawLine(x(1),y(1),x(2),y(2),varargin{:})   
    elseif xxt > xx2
        [x,y] = trRot2d([0 xxt],s*[d1, d1],x1,y1,th);
        drawLine(x(1),y(1),x(2),y(2),varargin{:})
    elseif xxt < xx1
        [x,y] = trRot2d([xxt d],s*[d1, d1],x1,y1,th);
        drawLine(x(1),y(1),x(2),y(2),varargin{:})
    end
   
    rot = gkGet('rotation');
    hal = gkGet('HorizontalAlignment');
    val = gkGet('VerticalAlignment');    
    gkSet('torg',2)
    gkSet('Rotation',th)
    if xxt < xx1
        gkText(xt,yt,txt)
    elseif xxt > xx2
        gkText(xt,yt,txt)
    else
        [x,y] = trRot2d(d/2,s*d1,x1,y1,th);
        gkText(x(1),y(1),txt)
    end
    gkSet('rotation',rot);
    gkSet('HorizontalAlignment',hal);
    gkSet('VerticalAlignment',val);
    
    if 2*ad1 < d
        [x,y] = trRot2d([0 d],s*[d1, d1],x1,y1,th);
        drawArrowhead(form,ad1,ad2,x(1),y(1),th+180)
        drawArrowhead(form,ad1,ad2,x(2),y(2),  th)
    else
        [x,y] = trRot2d([0 d],s*[d1, d1],x1,y1,th);
        drawArrowhead(form,ad1,ad2,x(1),y(1),th)
        drawArrowhead(form,ad1,ad2,x(2),y(2),th+180)        
       
       % if xt > x2
       %     drawLine(x1,y1,'-rtheta',2*ad1,th)
       % elseif xt < x1
       %     drawLine(x2,y2,'-rtheta',2*ad1,th)
       % end
    end
    
end
    