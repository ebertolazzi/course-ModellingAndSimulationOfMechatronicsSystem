% - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
function DoubleSliderPlot( t, x, y, theta, ell )
      x_0 = 0;
      y_0 = 0;
      hold off;
      axis_lim = ell*1.25;
      xc2 = -axis_lim:0.05:axis_lim;
      yc2 = 0.0*(-axis_lim:0.05:axis_lim);
      plot( xc2, yc2, '-r', 'Linewidth', 1 );
      axis equal;
      drawLine( x+ell/2*cos(theta), y+ell/2*sin(theta), ...
                x-ell/2*cos(theta), y-ell/2*sin(theta), ...
                'LineWidth', 8, 'Color', 'r' );
      drawCOG(0.1*ell,x_0,y_0);
      fillCircle( 'b', x, y, 0.1*ell );
      xlim([ -axis_lim axis_lim ]);
      ylim([ -axis_lim axis_lim ]);
      title(sprintf('time=%5.2g',t));
end
