%
% Matlab code for the Course:
%
%     Modelling and Simulation of Mechatronics System
%
% by
% Enrico Bertolazzi
% Dipartimento di Ingegneria Industriale
% Universita` degli Studi di Trento
% email: enrico.bertolazzi@unitn.it
%
classdef ParabolicPendulum5EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    mass;
    gravity;
  end
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = ParabolicPendulum5EQ( mass, gravity )
      % call the constructor of the basic class
      neq  = 5;
      ninv = 3;
      self@DAC_ODEclass('ParabolicPendulum5EQ',neq,ninv);
      % setup of the parmater of the ODE
      self.mass    = mass;
      self.gravity = gravity;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__f = f( self, t, vars__ )
      m = self.mass;
      g = self.gravity;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
      lambda = vars__(5);

      % evaluate function
      res__1 = u;
      res__2 = v;
      t1 = x ^ 2;
      t4 = u ^ 2;
      res__3 = 8 * (lambda * (-t1 + y - 0.1e1 / 0.4e1) + t4) * x;
      t7 = t1 ^ 2;
      res__4 = lambda * (32 * t7 + t1 * (-32 * y + 12) - 4 * y) / 2 - 16 * t1 * t4 - 2 * t4 - g / 2;
      t21 = t1 * x;
      t38 = y ^ 2;
      res__5 = 0.1e1 / (64 * t7 * t1 + t7 * (-128 * y + 36) + t1 * (64 * t38 - 40 * y + 4) + 4 * t38) * (-1024 * t7 * t21 * u * lambda + 1024 * t7 * x * u * (t4 + 2 * lambda * (y - 0.5e1 / 0.8e1)) + 256 * t7 * v * lambda - 1024 * t21 * (t4 * (y - 0.7e1 / 0.8e1) + (t38 - 0.3e1 / 0.2e1 * y + 0.11e2 / 0.32e2) * lambda) * u - 192 * t1 * v * (t4 + 0.4e1 / 0.3e1 * (y - 0.5e1 / 0.16e2) * lambda) + 6 * x * u * (t4 * (-0.128e3 / 0.3e1 * y + 0.56e2 / 0.3e1) + lambda * (-0.128e3 / 0.3e1 * t38 + 0.80e2 / 0.3e1 * y - 0.8e1 / 0.3e1) + g) - 3 * (8 * t4 + 0.16e2 / 0.3e1 * lambda * y + g) * v);

      % store on output
      res__f = zeros(5,1);
      res__f(1) = res__1;
      res__f(2) = res__2;
      res__f(3) = res__3;
      res__f(4) = res__4;
      res__f(5) = res__5;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DfDx = DfDx( self, t, vars__ )
      m = self.mass;
      g = self.gravity;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
      lambda = vars__(5);

      % evaluate function
      res__1_3 = 1;
      res__2_4 = 1;
      t1 = x ^ 2;
      t3 = 8 * y;
      t6 = u ^ 2;
      t7 = 8 * t6;
      res__3_1 = lambda * (-24 * t1 + t3 - 2) + t7;
      res__3_2 = 8 * lambda * x;
      res__3_3 = 16 * u * x;
      t10 = t1 * x;
      t12 = x * y;
      res__3_5 = -8 * t10 + 8 * t12 - 2 * x;
      res__4_1 = -32 * (lambda * (-2 * t1 + y - 0.3e1 / 0.8e1) + t6) * x;
      res__4_2 = lambda * (-16 * t1 - 2);
      res__4_3 = u * (-32 * t1 - 4);
      t25 = t1 ^ 2;
      t30 = 2 * y;
      res__4_5 = 16 * t25 + t1 * (-16 * y + 6) - t30;
      t31 = t25 ^ 2;
      t44 = t31 * x;
      t50 = y ^ 2;
      t63 = v * (t6 + 0.4e1 / 0.3e1 * (y - 0.5e1 / 0.16e2) * lambda);
      t64 = t25 * t10;
      t71 = t50 * y;
      t72 = lambda * t71;
      t74 = t50 * lambda;
      t76 = lambda * y;
      t81 = t25 * t1;
      t84 = 0.128e3 / 0.3e1 * y;
      t92 = t25 * x;
      t100 = t50 ^ 2;
      t101 = lambda * t100;
      t108 = 0.9e1 / 0.32e2 * g;
      t134 = 0.5e1 / 0.8e1 * g;
      t138 = g / 16;
      t139 = lambda / 6;
      t144 = 4 * t50;
      t149 = g - 0.5e1 / 0.3e1 * lambda;
      t158 = t50 * u;
      t161 = 0.128e3 / 0.3e1 * t74;
      t163 = 0.8e1 / 0.3e1 * lambda;
      t167 = -8192 * lambda * u * t31 * t25 - 8192 * t31 * t1 * (t6 - 4 * lambda * (y - 0.7e1 / 0.64e2)) * u - 4096 * v * lambda * t44 + 8192 * t31 * (t6 * (y - 0.33e2 / 0.16e2) - 6 * (t50 - 0.3e1 / 0.8e1 * y - 0.1e1 / 0.384e3) * lambda) * u + 6144 * t64 * t63 - 240 * t81 * u * (t6 * (-0.512e3 / 0.15e2 * t50 - 0.288e3 / 0.5e1 * y + 0.436e3 / 0.15e2) - 0.2048e4 / 0.15e2 * t72 + 0.320e3 / 0.3e1 * t74 - 0.208e3 / 0.15e2 * t76 + g - 0.19e2 / 0.15e2 * lambda) + 144 * t92 * v * (t6 * (-t84 + 20) - 0.256e3 / 0.9e1 * t74 + 0.64e2 / 0.3e1 * t76 + g - 0.29e2 / 0.9e1 * lambda) + 288 * t25 * u * (t6 * (-0.256e3 / 0.9e1 * t71 + 0.80e2 / 0.9e1 * t50 + 0.40e2 / 0.3e1 * y - 0.133e3 / 0.36e2) - 0.256e3 / 0.9e1 * t101 + 0.320e3 / 0.9e1 * t72 - 0.32e2 / 0.3e1 * t74 + (g - 0.25e2 / 0.18e2 * lambda) * y - t108 + 0.5e1 / 0.36e2 * lambda) - 192 * t10 * v * (t6 * (t3 - 0.9e1 / 0.4e1) + 0.8e1 / 0.3e1 * t74 + (g - 0.3e1 / 0.2e1 * lambda) * y - t108) - 48 * t1 * u * (t6 * (-0.32e2 / 0.3e1 * t71 + 0.52e2 / 0.3e1 * t50 - 0.43e2 / 0.3e1 * y + 0.7e1 / 0.6e1) - 0.32e2 / 0.3e1 * t101 + 0.16e2 / 0.3e1 * t72 + t50 * (g - 11 * lambda) + y * (-t134 + 0.10e2 / 0.3e1 * lambda) + t138 - t139) + 48 * x * v * (t6 * (t144 - 5 * y + 0.1e1 / 0.2e1) + t50 * t149 + y * (-t134 + lambda / 3) + t138) + 3 * (t6 * (-t84 + 0.56e2 / 0.3e1) - t161 + 0.80e2 / 0.3e1 * t76 + g - t163) * t158;
      t175 = (t81 + t25 * (-t30 + 0.9e1 / 0.16e2) + t1 * (t50 - 0.5e1 / 0.8e1 * y + 0.1e1 / 0.16e2) + t50 / 16) ^ 2;
      t176 = 0.1e1 / t175;
      res__5_1 = t176 * t167 / 512;
      t208 = 64 * y;
      t225 = 0.5e1 / 0.16e2 * g;
      res__5_2 = t176 * (t44 * (-4096 * u * lambda + 8192 * t6 * u) + 2048 * lambda * t31 * v - 16384 * t64 * (t6 * (y - 0.25e2 / 0.32e2) - lambda * (y - 0.11e2 / 0.32e2) / 2) * u - 3072 * t81 * t63 + 96 * t92 * u * (t6 * (0.256e3 / 0.3e1 * t50 - 160 * y + 48) - t161 + 0.112e3 / 0.3e1 * t76 + g - 0.11e2 / 0.2e1 * lambda) - 48 * t25 * v * (t6 * (-t208 + 28) - t161 + 32 * t76 + g - 0.25e2 / 0.6e1 * lambda) - 96 * t10 * (t6 * (-0.80e2 / 0.3e1 * t50 + 28 * y - 0.9e1 / 0.2e1) + 8 * t74 + (g - 0.11e2 / 0.3e1 * lambda) * y - t225) * u + 48 * t1 * v * (t6 * (12 * y - 0.5e1 / 0.2e1) + 0.16e2 / 0.3e1 * t74 + y * t149 - t225 - t139) - 6 * t12 * (t6 * (-0.64e2 / 0.3e1 * y + 0.56e2 / 0.3e1) + 0.40e2 / 0.3e1 * t76 + g - t163) * u + 3 * v * y * (t7 + 0.8e1 / 0.3e1 * t76 + g)) / 512;
      t257 = 1536 * t6;
      t269 = v * u;
      t274 = 80 * lambda;
      t278 = 3 * g;
      res__5_3 = 0.1e1 / (32 * t81 + t25 * (-t208 + 18) + t1 * (32 * t50 - 20 * y + 2) + 2 * t50) * (-512 * lambda * t64 + t92 * (1024 * t76 + t257 - 640 * lambda) + t10 * (-512 * t74 + y * (-t257 + 768 * lambda) + 1344 * t6 - 176 * lambda) - 192 * t1 * t269 + x * (-128 * t74 + y * (-384 * t6 + t274) + 168 * t6 + t278 - 8 * lambda) - 24 * t269);
      res__5_4 = 0.1e1 / (64 * t81 + t25 * (-128 * y + 36) + t1 * (64 * t50 - 40 * y + 4) + t144) * (256 * t25 * lambda + t1 * (-256 * t76 - 192 * t6 + t274) - 24 * t6 - 16 * t76 - t278);
      t315 = u * y;
      t327 = y * v;
      res__5_5 = 0.1e1 / (16 * t81 + t25 * (-32 * y + 9) + t1 * (16 * t50 - 10 * y + 1) + t50) * (-256 * t64 * u + t92 * (512 * t315 - 320 * u) + 64 * t25 * v - 256 * t10 * (t50 - 0.3e1 / 0.2e1 * y + 0.11e2 / 0.32e2) * u + t1 * (-64 * t327 + 20 * v) + x * (-64 * t158 + 40 * t315 - 4 * u) - 4 * t327);
      
      % store on output
      res__DfDx = zeros(5,5);
      res__DfDx(1,3) = res__1_3;
      res__DfDx(2,4) = res__2_4;
      res__DfDx(3,1) = res__3_1;
      res__DfDx(3,2) = res__3_2;
      res__DfDx(3,3) = res__3_3;
      res__DfDx(3,5) = res__3_5;
      res__DfDx(4,1) = res__4_1;
      res__DfDx(4,2) = res__4_2;
      res__DfDx(4,3) = res__4_3;
      res__DfDx(4,5) = res__4_5;
      res__DfDx(5,1) = res__5_1;
      res__DfDx(5,2) = res__5_2;
      res__DfDx(5,3) = res__5_3;
      res__DfDx(5,4) = res__5_4;
      res__DfDx(5,5) = res__5_5;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__h = h( self, t, vars__ )
      m = self.mass;
      g = self.gravity;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
      lambda = vars__(5);

      % evaluate function
      t1 = x ^ 2;
      t2 = t1 ^ 2;
      t6 = y ^ 2;
      res__1 = t2 + t1 * (-2 * y + 1) + t6 - 1;
      res__2 = -4 * t1 * x * u + 2 * t1 * v + (4 * y - 2) * u * x - 2 * y * v;
      t24 = u ^ 2;
      t46 = v ^ 2;
      res__3 = -64 * lambda * t2 * t1 + t2 * ((128 * y - 36) * lambda + 64 * t24) + t1 * (lambda * (-64 * t6 + 40 * y - 4) - 64 * y * t24 + 32 * t24 + g) - 8 * u * v * x - 4 * t6 * lambda + y * (-8 * t24 - g) + 2 * t24 + 2 * t46;

      % store on output
      res__h = zeros(3,1);
      res__h(1) = res__1;
      res__h(2) = res__2;
      res__h(3) = res__3;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DhDx = DhDx( self, t, vars__ )
      m = self.mass;
      g = self.gravity;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
      lambda = vars__(5);
  
      % evaluate function
      t1 = x ^ 2;
      t2 = t1 * x;
      res__1_1 = -4 * x * y + 4 * t2 + 2 * x;
      res__1_2 = -2 * t1 + 2 * y;
      t12 = v * x;
      res__2_1 = u * (-12 * t1 + 4 * y - 2) + 4 * t12;
      t14 = u * x;
      res__2_2 = 4 * t14 - 2 * v;
      res__2_3 = -res__1_1;
      res__2_4 = -res__1_2;
      t17 = t1 ^ 2;
      t24 = u ^ 2;
      t28 = y ^ 2;
      t33 = 128 * y;
      t34 = -t33 + 64;
      res__3_1 = -384 * t17 * x * lambda + t2 * ((512 * y - 144) * lambda + 256 * t24) + x * (lambda * (-128 * t28 + 80 * y - 8) + t24 * t34 + 2 * g) - 8 * v * u;
      t41 = 128 * t17;
      res__3_2 = lambda * (t41 + t1 * (-t33 + 40) - 8 * y) - 64 * t1 * t24 - 8 * t24 - g;
      res__3_3 = u * (t1 * t34 + t41 - 16 * y + 4) - 8 * t12;
      res__3_4 = -8 * t14 + 4 * v;
      res__3_5 = -64 * t17 * t1 + t17 * (t33 - 36) + t1 * (-64 * t28 + 40 * y - 4) - 4 * t28;
      
      % store on output
      res__DhDx = zeros(3,5);
      res__DhDx(1,1) = res__1_1;
      res__DhDx(1,2) = res__1_2;
      res__DhDx(2,1) = res__2_1;
      res__DhDx(2,2) = res__2_2;
      res__DhDx(2,3) = res__2_3;
      res__DhDx(2,4) = res__2_4;
      res__DhDx(3,1) = res__3_1;
      res__DhDx(3,2) = res__3_2;
      res__DhDx(3,3) = res__3_3;
      res__DhDx(3,4) = res__3_4;
      res__DhDx(3,5) = res__3_5;  
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function lambda = Lambda( self, x, y, u, v )
      m = self.mass;
      g = self.gravity;

      t1 = u * u;
      t2 = x * x;
      t3 = t2 * t2;
      t6 = t2 * t1;
      t18 = v * v;
      t26 = y * y;
      lambda = 0.1e1 / (16 * t26 * t2 + 16 * t3 * t2 - 10 * y * t2 - 32 * y * t3 + t2 + t26 + 9 * t3) * (-8 * u * v * x + t2 * g - y * g + 64 * t3 * t1 - 8 * y * t1 - 64 * y * t6 + 2 * t1 + 2 * t18 + 32 * t6) / 4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, vars__ )
      x = vars__(1);
      y = vars__(2);

      % extract states
      hold off;
      drawAxes( 2, 0.25, 3, 0, 0 );
      hold on;
      % plot constraint
      xx = -1.3:0.1:1.3;
      yy = xx.^2;
      plot( xx, yy, 'LineWidth', 2, 'Color', 'blue' );
      plot( [0,0], [-1.1,1.6], 'LineWidth', 2, 'Color','blue' );
      xx = -1:0.01:1;
      plot( xx, xx.^2+sqrt(1-xx.^2), '-', 'Linewidth', 1, 'Color','green' );
      plot( xx, xx.^2-sqrt(1-xx.^2), '-', 'Linewidth', 1, 'Color','cyan' );      % get mass position

      plot( [0,x,x], [x^2,x^2,y], 'LineWidth',1,'Color','black' );

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

      plot( [x0,x1], [y0,y1], 'LineWidth', 4, 'Color', 'red' );
      fillCircle( 'red', x0, y0, 0.05 );
      fillCircle( 'blue', x1, y1, 0.05 );
      fillCircle( 'black', x, y, 0.05 );
      title(sprintf('time=%g',t));
      axis equal;
    end
  end
end
