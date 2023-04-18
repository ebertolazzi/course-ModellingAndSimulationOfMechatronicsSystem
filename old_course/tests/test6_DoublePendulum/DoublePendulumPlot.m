% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function DoublePendulumPlot( t, x1, y1, x2, y2, L1, L2 )
  % extract states
  hold off;
  drawAxes( 2, 0.25, 3, 0, 0 );
  hold on;
  xm  = x1/2;
  ym  = y1/2;
  dx  = L1*x1/hypot(x1,y1);
  dy  = L1*y1/hypot(x1,y1);
  xx0 = xm - dx/2;
  yy0 = ym - dy/2;
  xx1 = xm + dx/2;
  yy1 = ym + dy/2;
  plot( [xx0,xx1], [yy0,yy1], 'LineWidth',4,'Color','red');
  fillCircle( 'red', xx0, yy0, 0.05 );
  fillCircle( 'red', xx1, yy1, 0.05 );
  xm  = (x1+x2)/2;
  ym  = (y1+y2)/2;
  dx  = L1*(x2-x1)/hypot(x2-x1,y2-y1);
  dy  = L1*(y2-y1)/hypot(x2-x1,y2-y1);
  xx0 = xm - dx/2;
  yy0 = ym - dy/2;
  xx1 = xm + dx/2;
  yy1 = ym + dy/2;
  plot( [xx0,xx1], [yy0,yy1], 'LineWidth',4,'Color','red');
  fillCircle( 'red', xx0, yy0, 0.05 );
  fillCircle( 'red', xx1, yy1, 0.05 );
  fillCircle( 'black', 0, 0, 0.05 );
  axis equal;
  axis([-1.1 1.1 -1.1 1.1]*(L1+L2));
  title(sprintf('time=%5.2g',t));
end
