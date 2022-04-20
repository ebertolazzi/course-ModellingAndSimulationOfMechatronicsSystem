% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function ScotchYokePlot( t, x2, s, theta, R, H, L, alpha, x30)
  x_0 = 0;
  y_0 = 0;
  xc1 = R*cos(0:pi/100:2*pi);
  yc1 = R*sin(0:pi/100:2*pi);
  hold off;
  plot( xc1, yc1, '-r', 'Linewidth', 1 );
  hold on
  axis_lim = R*1.5;
  xc2 = -axis_lim:0.05:axis_lim;
  yc2 = 0.0*(-axis_lim:0.05:axis_lim);
  plot( xc2, yc2, '-r', 'Linewidth', 1 );
  plot( yc2, xc2, '-r', 'Linewidth', 1 );
  axis equal
  drawLine( x_0, y_0, R*cos(theta), R*sin(theta), 'LineWidth', 8, 'Color', 'r' );
  drawLine( x2, H, x2+L, H, 'LineWidth', 8, 'Color', 'r' );
  drawLine( R*cos(theta), R*sin(theta), x2, H, 'LineWidth', 4, 'Color', 'k' );
  drawLine( x30, R, x30, -R, 'LineWidth', 4, 'Color', 'k' );
  drawCOG(0.1*R, x_0, y_0);
  fillCircle( 'b', R*cos(theta), R*sin(theta), 0.1*R );
  fillCircle( 'b', x2, H, 0.1*R );
  xlim([ -axis_lim x30+R/2 ]);
  ylim([ -axis_lim axis_lim ]);
  title(sprintf('time=%5.2g',t));
end
