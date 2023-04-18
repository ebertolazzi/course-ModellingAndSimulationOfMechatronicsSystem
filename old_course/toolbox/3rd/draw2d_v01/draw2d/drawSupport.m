function p = drawSupport(type, r,x0,y0,varargin)
%DRAWSUPPORT Draw support
%History:
%   2019,May   - MB created
%c0 = [1 1 1]*0.7;
%c1 = [1 1 1]*0.9;

    narginchk(4,inf)
    nargoutchk(0,1)
    
    validateattributes(r, {'numeric'}, {'positive','real','scalar'});
    validateattributes(type, {'numeric'}, {'positive','integer','scalar'});    
    validateattributes(x0, {'numeric'}, {'real',   'scalar'});    
    validateattributes(y0, {'numeric'}, {'real',   'scalar'}); 
    
    rot = 0;
    % scan options
    if ~isempty(varargin)
        if ~ischar(varargin{1})
            rot = varargin{1};
            validateattributes(rot, {'numeric'}, {'real', 'scalar'});
            varargin(1) = [];
        end
    end
    
    switch type
        case 1
            [x,y] = evalCircle(0,0,r,linspace(0,180,45));
            n = length(x);
            x(n+1) =  x(n);       y(n+1) = -2*r;
            x(n+2) =  x(n) - r/2; y(n+2) = y(n+1);
            x(n+3) =  x(n+2)    ; y(n+3) = y(n+2) - r/2;
            x(n+4) = -x(n+3)    ; y(n+4) = y(n+3);
            x(n+5) = -x(n+2)    ; y(n+5) = y(n+2);
            x(n+6) = -x(n+1)    ; y(n+6) = y(n+1);
            x(n+7) =  x(1)      ; y(n+7) = y(1);

            [x,y] = trRot2d(x,y,x0,y0,rot);

            %xr = (x(n+3) + x(n+4))/2;
            %yr = (y(n+3) + y(n+4))/2;
            %fillRect(c0,4*r,r/2,xr,yr,rot,'-pos',8)

            %   fill(x,y,c0)
            c = gkPlot(x,y);
            plot([x(n+1),x(n+6)],[y(n+1),y(n+6)],'Color',c)
            drawCircle(x0,y0,r/2,'Color',c);

            %  xr = (x(n+3) + x(n+4))/2;
            %  yr = (y(n+3) + y(n+4))/2;
            %  fillRect(c0,4*r,r/2,xr,yr,rot,'-pos',8)

            if nargout > 0
                p.xk(1) = x(n+3);
                p.yk(1) = y(n+3);
                p.xk(2) = x(n+4);
                p.yk(2) = y(n+4);
                p.xk(3) = (p.xk(1) + p.xk(2))/2;
                p.yk(3) = (p.yk(1) + p.yk(2))/2; 
                p.xk(4) = x0;
                p.yk(4) = y0;                
            end
        case 2
            aa = atan2d(1,1.5);
            [x,y] = evalCircle(0,0,r,linspace(aa,180-aa,45));
            n = length(x);
            x(n+1) =  -1.5*r;       y(n+1) = - r;
            x(n+2) =  x(n+1);     y(n+2) = y(n+1)- r/2;
            x(n+3) = -x(n+2)    ; y(n+3) = y(n+2);
            x(n+4) = -x(n+1)      ; y(n+4) = y(n+1);
            x(n+5) = x(1)      ; y(n+5) = y(1);
            xr(1)  = -r*0.75;yr(1)=y(n+2)-r/2;
            xr(2)  = -xr(1);yr(2)=yr(1);
            xp(1)  = -r*0.75;yp(1)=y(n+2)-r;
            xp(2)  = -xp(1);yp(2)=yp(1);

            [x,y] = trRot2d(x,y,x0,y0,rot);
            [xr,yr] = trRot2d(xr,yr,x0,y0,rot);
            [xp,yp] = trRot2d(xp,yp,x0,y0,rot);
            %xr = (x(n+3) + x(n+4))/2;
            %yr = (y(n+3) + y(n+4))/2;
            %fillRect(c0,4*r,r/2,xr,yr,rot,'-pos',8)

            %  fill(x,y,c0)
            c = gkPlot(x,y);
            gkPlot([x(n+1),x(n+4)],[y(n+1),y(n+4)],'Color',c)
            drawCircle(x0,y0,r/2,'Color',c);
            drawCircle(xr(1),yr(1),r/2,'Color',c);
            drawCircle(xr(2),yr(2),r/2,'Color',c);
            if nargout > 0
                p.xk(1) = xp(1);
                p.yk(1) = yp(1);
                p.xk(2) = xp(2);
                p.yk(2) = yp(2);
                p.xk(3) = (p.xk(1) + p.xk(2))/2;
                p.yk(3) = (p.yk(1) + p.yk(2))/2; 
                p.xk(4) = x0;
                p.yk(4) = y0;              
            end
    end

end

