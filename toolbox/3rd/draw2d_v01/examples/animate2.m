% Harmonic motion 
addpath('..\draw2d')
close all
fg=drawInit(1);
a = 3;
clear M
k = 0;
for t=0:0.05:6
    drawInit(1);
    d = sin(a*t);
    drawLimits(-3,10,0,6)
    p=drawSpring(0,0,1,2+d,4,90,'k','LineWidth',2);
    drawRect(4,2,p.xk(2),p.yk(2),'-pos',2)
     d = sin(2*a*t);
    p=drawSpring(5,0,1,2+d,4,90);
    drawRect(4,2,p.xk(2),p.yk(2),'-pos',2)
    drawnow
    k = k + 1;
    M(k) = getframe;
end
v = VideoWriter('animate02.avi');
open(v)
writeVideo(v,M)
close(v)
clear M

