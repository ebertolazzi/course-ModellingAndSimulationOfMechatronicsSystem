% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function ParabolicPendulumPlot( t, x, y )
  hold off;
  drawAxes( 2, 0.25, 3, 0, 0 );
  hold on;
  % plot constraint
  xx = -1.3:0.1:1.3;
  yy = xx.^2;
  plot( xx, yy, 'LineWidth', 2, 'Color', 'blue' );
  plot( [0,0], [-1.1,1.6], 'LineWidth', 2, 'Color','blue' );

  % plot contraint
  xx  = -1:0.01:1;
  yy1 = xx.^2+sqrt(1-xx.^2);
  yy2 = xx.^2-sqrt(1-xx.^2);
  plot( xx, yy1, '-', 'Linewidth', 1, 'Color','green' );
  plot( xx, yy2, '-', 'Linewidth', 1, 'Color','cyan' );

  % plot mass position
  xm  = xx./2;
  ym1 = (xx.^2+yy1)./2;
  ym2 = (xx.^2+yy2)./2;
  plot( xm, ym1, '-', 'Linewidth', 1, 'Color','green' );
  plot( xm, ym2, '-', 'Linewidth', 1, 'Color','cyan' );

  % evaluate middle point and direction
  xm = x/2;
  ym = (x^2+y)/2;
  L  = 2*hypot( x, x^2-y );
  dx = x/L;
  dy = (x^2-y)/L;

  x0 = xm-dx;
  y0 = ym-dy;
  x1 = xm+dx;
  y1 = ym+dy;

  plot( [x0,x,x1], [y0,y,y1], 'LineWidth',1,'Color','black' );

  ww  = 0.2;
  ang = 180*atan2( 2*x1, 1 )/pi;
  col = [0.9290, 0.6940, 0.1250];
  plot( [x0,x1], [y0,y1], 'LineWidth', 4, 'Color', 'red' );
  fillRect( col, ww, ww/4, x0, y0, 90,'-pos',5 );
  fillRect( col, ww, ww/4, x1, y1, ang,'-pos',5 );

  fillCircle( 'black', (x0+x1)/2, (y0+y1)/2, 0.1 );
  fillCircle( 'black', x, y, 0.025 );
  title(sprintf('time=%5.2g',t));
  axis equal;
end
