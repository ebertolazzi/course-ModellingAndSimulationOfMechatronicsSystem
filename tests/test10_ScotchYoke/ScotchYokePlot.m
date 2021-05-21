% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function ScotchYokePlot( t, x2, s, theta, R, H, L, alpha)
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
  axis equal
%   drawLine( x_0, y_0, x1, y1, 'LineWidth', 8, 'Color', 'r' );
%   drawLine( x1, y1, x2, y2, 'LineWidth', 8, 'Color', 'r' );
  drawCOG(0.1*R,x2,H);
%   fillCircle( 'b', x1, y1, 0.1*self.ell );
%   fillCircle( 'b', x2, y2, 0.1*self.ell );
  xlim([ -axis_lim axis_lim ]);
  ylim([ -axis_lim axis_lim ]);
  title(sprintf('time=%5.2g',t));
end