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
%%addpath('../ode_lib');
classdef ParabolicPendulum < ODEbaseClass_P
  properties (SetAccess = protected, Hidden = true)
    gravity;
  end
  methods
    function self = ParabolicPendulum( gravity )
      self@ODEbaseClass_P('ParabolicPendulum',5,3); % 5 equation 3 invariant
      self.gravity = gravity;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__ode = f( self, t, vars__ )
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
      t3 = 4 * y;
      res__3 = -2 * x * (lambda * (4 * t1 - t3 + 1) + g);
      t9 = t1 ^ 2;
      t19 = u ^ 2;
      res__4 = lambda * (32 * t9 + t1 * (-32 * y + 12) - t3) / 2 + 4 * g * t1 - 2 * t19 + g / 2;
      t45 = y ^ 2;
      t46 = 4 * t45;
      res__5 = 0.1e1 / (64 * t9 * t1 + t9 * (-128 * y + 36) + t1 * (64 * t45 - 40 * y + 4) + t46) * (-768 * lambda * u * t9 * x + 256 * v * lambda * t9 - 160 * t1 * x * u * ((-0.32e2 / 0.5e1 * y + 0.9e1 / 0.5e1) * lambda + g) + 48 * t1 * ((-0.16e2 / 0.3e1 * y + 0.5e1 / 0.3e1) * lambda + g) * v + 64 * x * (0.3e1 / 0.4e1 * t19 + lambda * (-t46 + 0.5e1 / 0.2e1 * y - 0.1e1 / 0.4e1) + g * (y - 0.11e2 / 0.32e2)) * u + 3 * v * (-8 * t19 - 0.16e2 / 0.3e1 * y * lambda + g));

      % store on output
      res_ode = zeros(1,5);
      res__ode(1) = res__1;
      res__ode(2) = res__2;
      res__ode(3) = res__3;
      res__ode(4) = res__4;
      res__ode(5) = res__5;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__jode = DfDx( self, t, vars__ )
      g = self.gravity;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
      lambda = vars__(5);

      % evaluate function
      jac__1_3 = 1;
      jac__2_4 = 1;
      t1 = x ^ 2;
      t3 = 8 * y;
      jac__3_1 = lambda * (-24 * t1 + t3 - 2) - 2 * g;
      jac__3_2 = 8 * lambda * x;
      t8 = t1 * x;
      jac__3_5 = -8 * t8 + x * (t3 - 2);
      jac__4_1 = 8 * (lambda * (8 * t1 - 4 * y + 0.3e1 / 0.2e1) + g) * x;
      t20 = 2 * lambda;
      jac__4_2 = -16 * lambda * t1 - t20;
      jac__4_3 = -4 * u;
      t22 = t1 ^ 2;
      t27 = 2 * y;
      jac__4_5 = 16 * t22 + t1 * (-16 * y + 6) - t27;
      t28 = u * lambda;
      t29 = t22 ^ 2;
      t33 = lambda * v;
      t34 = t29 * x;
      t37 = y * lambda;
      t47 = (-0.16e2 / 0.3e1 * t37 + 0.5e1 / 0.3e1 * lambda + g) * v;
      t48 = t22 * t8;
      t51 = u ^ 2;
      t53 = y ^ 2;
      t54 = t53 * lambda;
      t55 = 0.8e1 / 0.5e1 * t54;
      t63 = t22 * t1;
      t66 = 0.3e1 / 0.4e1 * t51;
      t67 = 0.8e1 / 0.3e1 * t54;
      t68 = g + t20;
      t69 = y * t68;
      t70 = 0.3e1 / 0.8e1 * g;
      t74 = t22 * x;
      t80 = t53 * y;
      t84 = t53 * (g + lambda);
      t109 = t53 ^ 2;
      t141 = (g + 0.5e1 / 0.2e1 * lambda) * y;
      t148 = 6144 * t29 * t1 * t28 - 4096 * t34 * t33 + 3840 * t29 * (-0.16e2 / 0.5e1 * t37 + g + 0.9e1 / 0.10e2 * lambda) * u - 1536 * t48 * t47 - 5120 * t63 * u * (0.3e1 / 0.8e1 * t51 - t55 + (g + 0.4e1 / 0.5e1 * lambda) * y - 0.5e1 / 0.16e2 * g - 0.49e2 / 0.320e3 * lambda) + 1536 * t74 * v * (t66 - t67 + t69 - t70 - 0.29e2 / 0.96e2 * lambda) + 1792 * t22 * u * (t51 * (0.9e1 / 0.7e1 * y - 0.81e2 / 0.224e3) - 0.16e2 / 0.7e1 * lambda * t80 + t84 + (-0.5e1 / 0.8e1 * g - 0.61e2 / 0.112e3 * lambda) * y + 0.31e2 / 0.256e3 * g + 0.9e1 / 0.224e3 * lambda) + 192 * t8 * v * (t51 * (-t3 + 0.9e1 / 0.4e1) - t67 + (g + 0.3e1 / 0.2e1 * lambda) * y - 0.9e1 / 0.32e2 * g) - 512 * t1 * (t51 * (0.3e1 / 0.4e1 * t53 - 0.15e2 / 0.32e2 * y + 0.3e1 / 0.64e2) - 4 * lambda * t109 + t80 * t68 + t53 * (-g / 2 - 0.39e2 / 0.32e2 * lambda) + (0.71e2 / 0.256e3 * g + 0.5e1 / 0.16e2 * lambda) * y - 0.11e2 / 0.512e3 * g - lambda / 64) * u + 30 * x * (t51 * (0.64e2 / 0.5e1 * t53 - t3 + 0.4e1 / 0.5e1) - t67 + (g + 0.8e1 / 0.15e2 * lambda) * y - g / 10) * v + 32 * t53 * (t66 - 4 * t54 + t141 - 0.11e2 / 0.32e2 * g - lambda / 4) * u;
      t156 = (t63 + t22 * (-t27 + 0.9e1 / 0.16e2) + t1 * (t53 - 0.5e1 / 0.8e1 * y + 0.1e1 / 0.16e2) + t53 / 16) ^ 2;
      t157 = 0.1e1 / t156;
      jac__5_1 = t157 * t148 / 512;
      t187 = 0.3e1 / 0.2e1 * t51;
      jac__5_2 = t157 * (-4096 * t34 * t28 + 2048 * t29 * t33 - 2048 * t48 * (-4 * t37 + g + 0.5e1 / 0.4e1 * lambda) * u + 768 * t63 * t47 + 2560 * t74 * (-t55 + (g + 0.6e1 / 0.5e1 * lambda) * y + 0.3e1 / 0.10e2 * t51 - 0.27e2 / 0.80e2 * g - 0.29e2 / 0.160e3 * lambda) * u - 768 * t22 * (-t67 + t69 + t51 / 2 - t70 - 0.25e2 / 0.96e2 * lambda) * v - 512 * t8 * u * (t84 + y * (t187 - g - 0.9e1 / 0.16e2 * lambda) - 0.15e2 / 0.32e2 * t51 + 0.39e2 / 0.256e3 * g) - 96 * t1 * v * (-t67 + y * (-4 * t51 + g + 0.5e1 / 0.6e1 * lambda) + 0.5e1 / 0.4e1 * t51 - 0.5e1 / 0.32e2 * g + lambda / 12) - 32 * y * x * (t141 + t187 - 0.11e2 / 0.16e2 * g - lambda / 2) * u - 3 * y * v * (-8 * t51 - 0.8e1 / 0.3e1 * t37 + g)) / 512;
      t232 = 80 * lambda;
      jac__5_3 = 0.1e1 / (32 * t63 + t22 * (-64 * y + 18) + t1 * (32 * t53 - 20 * y + 2) + 2 * t53) * (-384 * t74 * lambda + t8 * (512 * t37 - 80 * g - 144 * lambda) + x * (-128 * t54 + y * (32 * g + t232) + 72 * t51 - 11 * g - 8 * lambda) - 24 * u * v);
      jac__5_4 = 0.1e1 / (64 * t63 + t22 * (-128 * y + 36) + t1 * (64 * t53 - 40 * y + 4) + 4 * t53) * (256 * lambda * t22 + t1 * (-256 * t37 + 48 * g + t232) - 24 * t51 - 16 * t37 + 3 * g);
      t279 = u * y;
      t284 = v * y;
      jac__5_5 = 0.1e1 / (16 * t63 + t22 * (-32 * y + 9) + t1 * (16 * t53 - 10 * y + 1) + t53) * (-192 * t74 * u + 64 * t22 * v + t8 * (256 * t279 - 72 * u) + t1 * (-64 * t284 + 20 * v) + x * (-64 * t53 * u + 40 * t279 + jac__4_3) - 4 * t284);

      % store on output
      jac__jode = zeros(5,5);
      jac__jode(1,3) = jac__1_3;
      jac__jode(2,4) = jac__2_4;
      jac__jode(3,1) = jac__3_1;
      jac__jode(3,2) = jac__3_2;
      jac__jode(3,5) = jac__3_5;
      jac__jode(4,1) = jac__4_1;
      jac__jode(4,2) = jac__4_2;
      jac__jode(4,3) = jac__4_3;
      jac__jode(4,5) = jac__4_5;
      jac__jode(5,1) = jac__5_1;
      jac__jode(5,2) = jac__5_2;
      jac__jode(5,3) = jac__5_3;
      jac__jode(5,4) = jac__5_4;
      jac__jode(5,5) = jac__5_5;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = DfDt( self, t, vars___)
      res = zeros(5,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = exact( self, t0, x0, t )
      res = []; % no exact solution
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__h = h( self, t, vars__ )
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
      res__1 = -t2 + t1 * (2 * y - 1) - t6 + 1;
      res__2 = 4 * t1 * x * u - 2 * t1 * v + (-4 * y + 2) * u * x + 2 * v * y;
      t33 = u ^ 2;
      t47 = v ^ 2;
      res__3 = 64 * t2 * t1 * lambda + t2 * ((-128 * y + 36) * lambda + 16 * g) + t1 * (lambda * (64 * t6 - 40 *     y + 4) - 16 * g * y - 16 * t33 + 5 * g) + 8 * u * v * x + 4 * t6 * lambda + y * (8 * t33 - g) - 2 * t33 - 2     * t47;

      % store on output
      res__h = zeros(3,1);
      res__h(1) = res__1;
      res__h(2) = res__2;
      res__h(3) = res__3;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__jh = DhDx( self, t, vars__ )
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
      jac__1_1 = 4 * x * y - 4 * t2 - 2 * x;
      jac__1_2 = 2 * t1 - 2 * y;
      t12 = x * v;
      jac__2_1 = u * (12 * t1 - 4 * y + 2) - 4 * t12;
      t14 = x * u;
      jac__2_2 = -4 * t14 + 2 * v;
      jac__2_3 = -jac__1_1;
      jac__2_4 = -jac__1_2;
      t17 = t1 ^ 2;
      t27 = y ^ 2;
      t34 = u ^ 2;
      jac__3_1 = 384 * t17 * x * lambda + t2 * ((-512 * y + 144) * lambda + 64 * g) + x * (lambda * (128 * t27 -      80 * y + 8) - 32 * g * y - 32 * t34 + 10 * g) + 8 * u * v;
      t42 = 128 * y;
      jac__3_2 = lambda * (-128 * t17 + t1 * (t42 - 40) + 8 * y) - 16 * g * t1 + 8 * t34 - g;
      jac__3_3 = u * (-32 * t1 + 16 * y - 4) + 8 * t12;
      jac__3_4 = 8 * t14 - 4 * v;
      jac__3_5 = 64 * t17 * t1 + t17 * (-t42 + 36) + t1 * (64 * t27 - 40 * y + 4) + 4 * t27;

      % store on output
      jac__jh = zeros(3,5);
      jac__jh(1,1) = jac__1_1;
      jac__jh(1,2) = jac__1_2;
      jac__jh(2,1) = jac__2_1;
      jac__jh(2,2) = jac__2_2;
      jac__jh(2,3) = jac__2_3;
      jac__jh(2,4) = jac__2_4;
      jac__jh(3,1) = jac__3_1;
      jac__jh(3,2) = jac__3_2;
      jac__jh(3,3) = jac__3_3;
      jac__jh(3,4) = jac__3_4;
      jac__jh(3,5) = jac__3_5;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = DhDt( self, t, vars__ )
      res = zeros(3,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, Z )
      hold off;
      drawAxes( 2, 0.25, 3, 0, 0 );
      hold on;
      % plot constraint
      xx    = -1.3:0.1:1.3;
      yy    = xx.^2;
      plot( xx, yy, 'LineWidth',2,'Color','blue');
      plot( [0,0], [-1.1,1.6], 'LineWidth',2,'Color','blue');
      xx = -1:0.01:1;
      plot( xx, xx.^2+sqrt(1-xx.^2), '-', 'Linewidth', 1, 'Color','green');
      plot( xx, xx.^2-sqrt(1-xx.^2), '-', 'Linewidth', 1, 'Color','cyan');      % get mass position
      x = Z(1);
      y = Z(2);

      plot( [0,x,x], [x^2,x^2,y], 'LineWidth',1,'Color','black');

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

      plot( [x0,x1], [y0,y1], 'LineWidth',4,'Color','red');
      fillCircle( 'red', x0, y0, 0.05 );
      fillCircle( 'red', x1, y1, 0.05 );
      fillCircle( 'black', x, y, 0.05 );
      axis equal;
    end
  end
end
