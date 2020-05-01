addpath('..\draw2d')
drawInit
b1 = drawRect(1,1,0,0,'-pos',4);
b2 = drawRect(1,1,4,0,'-pos',4);
drawSpring1(2,0.4,5,b1.xk(6),b1.yk(6),b2.xk(4),b2.yk(4))
drawSave