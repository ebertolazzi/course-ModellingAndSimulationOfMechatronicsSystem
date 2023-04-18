addpath('..\draw2d')
close all
drawInit
ad1 = 0.3;
x1 = 1; y1 = 2;
x2 = 2.4; y2 = 4;
gkSet('FontSize',20)
drawPoint(1,ad1/2,x1,y1)
drawPoint(1,ad1/2,x2,y2)
drawHDim(3,ad1,ad1/2,x1,y1,x2,y2,2,0,'-str',12)
drawVDim(3,ad1,ad1/2,x1,y1,x2,y2,3,-1,'-str',12)
drawShow