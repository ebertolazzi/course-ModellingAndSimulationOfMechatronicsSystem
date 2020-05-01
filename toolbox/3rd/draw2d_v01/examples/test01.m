addpath('..\draw2d')
close all
drawInit
ht = 0.5;hs = 0.7*ht;F=1;d1=8;d2=4;
% draw truses
drawCanoe1( ht, 0,0,d1,0 )
drawCanoe1( ht, d1,0,d1,d2 )
drawCanoe1( ht, 0,0,d1,d2 )
drawCanoe1( ht, 0,d2,d1,d2 )
drawCanoe1( ht, 0,0,0,d2 )
% draw pins
drawDonut(hs,0.9*hs,0,d2)
drawDonut(hs,0.9*hs,d1,d2)
% draw supports
s1 = drawSupport(1,hs,0,0);
s2 = drawSupport(2,hs,d1,0);
% draw floor
fillRect('y',d2*ht,ht,s1.xk(3),s1.yk(3),'-pos',d1)
fillRect('y',d2*ht,ht,s2.xk(3),s2.yk(3),'-pos',d1)
drawRect(d2*ht,ht,s1.xk(3),s1.yk(3),'-pos',d1,'-v',2,4)
drawRect(d2*ht,ht,s2.xk(3),s2.yk(3),'-pos',d1,'-v',3,1)
% draw forces
drawForce(F,180,0,0,d2,'-ad',0.5,'r','LineWidth',2)
drawForce(2*F,90,0,d1,d2,'-ad',0.5,'r','LineWidth',2)
% dimension
drawVDim(3,0.8*ht,ht/2,d1,0,d1,d2,d1+1,d2/2);
drawHDim(3,0.8*ht,ht/2,0,d2,d1,d2,d1/2,d2+1);
drawShow
drawSave