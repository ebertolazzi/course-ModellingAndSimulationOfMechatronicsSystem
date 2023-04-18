% show key-point for various entities 
addpath('..\draw2d')
hcopy = false; % if true then jpeg images are produced
close all
xv = [ 1 2 4 7];
yv = [ 0 4 5 2];
ad1 = 1;
ad2 = ad1/2;
xc = 1;
yc = 1;
r = 2;
a = r;
b = r/2;
sang = 30;
ang = 45;
x1   = 1; y1 = 1; x2 = 4; y2 = 6;
rot = 45;
for ent = 1:27
    drawInit(ent)
    gkInit
    aflg = false;
    switch ent
        case 1
            titl = 'drawArcArrow';
            form = 3;
            p = drawArcArrow( form,ad1, ad2, xc, yc, r, sang, ang)
        case 2
            titl = 'drawArrow';
            form = 3;
            p = drawArrow( form, ad1, ad2, x1, y1, x2, y2)
        case 3
            titl = 'drawAxes';
            form = 3;
            ad = 1;
            a  = 5;
            p = drawAxes( form, ad, a, x1, y1, rot)
        case 4
            titl = 'drawBezier';
            p = drawBezier( xv, yv)
            aflg = true;
        case 5
            titl = 'drawBspline';
            c = 3;
            p = drawBspline( c, xv, yv )
            aflg = true;
        case 6
            titl = 'drawCanoe';
            wd = 5;
            ht = 2;
            p = drawCanoe( wd, ht, xc, yc,rot,'-pos',7 )
        case 7
            titl = 'drawCatenary';
            x1=2;y1=2;dx=4;dy=4;L=13;
            p = drawCatenary( x1, y1, dx, dy, L )
        case 8
            titl = 'drawCircle';
            p = drawCircle( xc, yc, r, sang, ang )
            aflg = true;
        case 9
            titl = 'drawCross';
            d1 = 3; d2 = 6;
            p = drawCross(  d1, d2, xc, yc, rot )
        case 10
            titl = 'drawDonut';
            d1 = 3; d2 = 2;
            p = drawDonut(  d1, d2, xc, yc )
        case 11
            titl = 'drawEllipse';
            p = drawEllipse( a, b, xc, yc, rot , sang, ang,'-sec')
            aflg = true;
        case 12
            titl = 'drawhyperbola';
            t1 = -1; t2 = 1;
            p = drawHyperbola( t1, t2, a, b, xc, yc, rot,'-seg' )
            aflg = true;
        case 13
            titl = 'drawLeader';
            p = drawLeader( 6, ad1/2, ad2, xc, yc, xv, yv)
        case 14
            titl = 'drawLine';
            p = drawLine( x1, y1, x2, y2,0.2,1.3 )
        case 15
            titl = 'drawLoad';
            wd = 6;h1=1;h2=2;nc=5;d=5;
            p = drawLoad(wd,h1,h2,nc,d,xc,yc,rot)
        case 16
            titl = 'drawNgon';
            n=6;r=2;
            p = drawNgon( n, r, xc, yc, rot,'-v',2,5 )
        case 17
            titl = 'drawParabola';
            t1 = -1;t2=1;f=2;
            p = drawParabola( t1, t2, f, xc, yc, rot,'-seg' )
            aflg = true;
        case 18
            p = drawPoint( 2, ad1, xc, yc )
        case 19
            p = drawPolygon( xv, yv)
        case 20
            p = drawPolyline( xv, yv)
        case 21
            p = drawRect( wd, ht, xc, yc, rot )
        case 22
            p = drawSpiral( 1, sang, sang + ang)
        case 23
            p = drawSpline( 1, xv, yv )
            aflg = true
        case 24
            titl = 'drawSpring';
            p = drawSpring1(2,1,4,1,2,4,6)
        case 25
            p = drawSupport(1, ad1, xc,yc,rot)
        case 26
            p = drawSupport(2, ad1, xc,yc,rot)
        case 27
            p = drawCanoe1( ht, x1, y1, x2, y2 )
            drawPoint(1,0.5,x1,y1)
            drawPoint(1,0.5,x2,y2)            
    end
    gkSet('FontSize',16)
    gkSet('torg',2)
    for k = 1:length(p.xk)
        scatter(p.xk,p.yk,30,'b','filled')
        gkText(p.xk(k),p.yk(k),num2str(k))
    end
    if aflg
        for k = 1:2
            drawArrow(3,0.5,0.25,p.xk(k),p.yk(k),'-polar',2,p.th(k),'r')
        end
    end
    % title(titl)
    drawShow
    if hcopy
      drawSave
    end
end



