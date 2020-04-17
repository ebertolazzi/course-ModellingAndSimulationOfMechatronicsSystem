% animate
addpath('..\draw2d')
w = 1;h=1;d=h/2;
a = 2*h; b = 2*h;
cb = [255,178,102]/256; % brown
d1 = 0.5;wd=5;ht=2;h=2+ht;
fg = drawInit;
clear M
k = 0;
for t = 0:0.1:10
    drawInit(fg)
    axis off
    y=sin(3*t);
    c1=drawDonut(d1,d1/2,0,y);
    s1 = drawSupport(1,0.7*d1/2,0,y);
    r1 = drawRect(wd,ht,s1.xk(3),s1.yk(3),'-pos',8);
    sp = drawSpring1(2,d1,5,r1.xk(2),r1.yk(2),r1.xk(2),-h);
    drawLine( sp.xk(2),sp.yk(2),'-delta',1,0,-wd/2,2)
    s2 = drawSupport(1,0.7*d1/2,0,h,-180);
    c2=drawDonut(d1,d1/2,0,h);
    s3 = drawSupport(1,0.7*d1/2,wd,h,-180);
    c3=drawDonut(d1,d1/2,wd,h);
    drawLine(c1.xk(1),c1.yk(1),c2.xk(1),c2.yk(2))
    drawLine(c1.xk(2),c1.yk(2),c2.xk(5),c2.yk(5))
    drawLine(c2.xk(4),c2.yk(4),c3.xk(4),c3.yk(4))
    L1=drawLine(c3.xk(2),c3.yk(2),'-delta',0,-h-y);
    drawRect(ht,ht,L1.xk(2),L1.yk(2),'-pos',8)
    drawShow
    k = k + 1;
    M(k) = getframe;
end
v = VideoWriter('animate03.avi');
open(v)
writeVideo(v,M)
close(v)
clear M