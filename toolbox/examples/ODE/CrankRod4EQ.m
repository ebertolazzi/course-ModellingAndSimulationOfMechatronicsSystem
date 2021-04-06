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
%> Implementation of the ODE (Pendulum)
%>
%> \rst
%> .. math::
%> 
%>   \begin{cases}
%>      \theta' = \omega & \\
%>      \omega' = -\displaystyle\frac{g}{\ell}\sin\theta &
%>   \end{cases}
%>
%> \endrst
%
classdef CrankRod4EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    ell;
    m;
    gravity;
  end
  methods
    function self = CrankRod4EQ( ell, m, gravity )
      self@DAC_ODEclass('CrankRod');
      self.ell     = ell;
      self.m       = m;
      self.gravity = gravity;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function ode = f( self, t, Z )
      
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x_1 = Z(1);
      y_1 = Z(2);
      x_2 = Z(3);
      y_2 = Z(4);
      theta = Z(5);
      u_1 = Z(6);
      v_1 = Z(7);
      u_2 = Z(8);
      v_2 = Z(9);
      lambda_1 = Z(10);
      lambda_2 = Z(11);
      lambda_3 = Z(12);
      lambda_4 = Z(13);

      % evaluate function
      res_1 = u_1;
      res_2 = v_1;
      res_3 = u_2;
      res_4 = v_2;
      t3 = sin(theta);
      res_5 = -u_1 / L / t3;
      t6 = lambda_1 - lambda_3;
      t7 = 0.1e1 / m;
      res_6 = t6 * t7;
      t8 = m * g;
      res_7 = (-t8 + lambda_2) * t7;
      res_8 = t7 * lambda_3;
      res_9 = (-t8 + lambda_4) * t7;
      t12 = L * (lambda_1 + lambda_3);
      t13 = cos(theta);
      t14 = t13 ^ 2;
      t15 = t14 ^ 2;
      t19 = lambda_2 * t3;
      t24 = t14 * t13;
      t27 = lambda_2 * L * t3;
      t29 = u_1 ^ 2;
      t30 = t29 * m;
      t41 = t3 ^ 2;
      t42 = t41 ^ 2;
      t44 = L ^ 2;
      t45 = 0.1e1 / t44;
      t49 = 0.1e1 / (4 * t14 - 5);
      t51 = u_1 * (t12 * t15 * t13 + L * t15 * t19 + L * (lambda_1 - 5 * lambda_3) * t24 + (-2 * t27 - 3 * t30) * t14 - 2 * L * (lambda_1 - 2 * lambda_3) * t13 + t27) / t42 * t45 * t49;
      res_10 = -3 * t51;
      res_11 = -u_1 * (t12 * t15 + L * t24 * t19 + 14 * L * (lambda_1 - 0.8e1 / 0.7e1 * lambda_3) * t14 + (-t27 - 15 * t30) * t13 - 15 * L * t6) * t45 / t41 / t3 * t49;
      res_12 = -2 * t51;


      % store on output
      ode = zeros(13,1);
      ode(1) = res_1;
      ode(2) = res_2;
      ode(3) = res_3;
      ode(4) = res_4;
      ode(5) = res_5;
      ode(6) = res_6;
      ode(7) = res_7;
      ode(8) = res_8;
      ode(9) = res_9;
      ode(10) = res_10;
      ode(11) = res_11;
      ode(12) = res_12;

    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac = DfDx( self, t, Z )
        
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x_1 = Z(1);
      y_1 = Z(2);
      x_2 = Z(3);
      y_2 = Z(4);
      theta = Z(5);
      u_1 = Z(6);
      v_1 = Z(7);
      u_2 = Z(8);
      v_2 = Z(9);
      lambda_1 = Z(10);
      lambda_2 = Z(11);
      lambda_3 = Z(12);
      lambda_4 = Z(13);

      % evaluate function
      jac_1_6 = 1;
      jac_2_7 = 1;
      jac_3_8 = 1;
      jac_4_9 = 1;
      t1 = 0.1e1 / L;
      t2 = u_1 * t1;
      t3 = sin(theta);
      t4 = t3 ^ 2;
      t5 = 0.1e1 / t4;
      t6 = cos(theta);
      jac_5_5 = t2 * t5 * t6;
      t8 = 0.1e1 / t3;
      jac_5_6 = -t1 * t8;
      jac_6_10 = 0.1e1 / m;
      jac_6_12 = -jac_6_10;
      jac_7_11 = jac_6_10;
      jac_8_12 = jac_7_11;
      jac_9_13 = jac_8_12;
      t10 = L * t3;
      t11 = t6 ^ 2;
      t12 = t11 * t6;
      t13 = t11 ^ 2;
      t14 = t13 * t12;
      t18 = t13 ^ 2;
      t19 = L * t18;
      t24 = t13 * t6;
      t28 = t13 * t11;
      t29 = L * t28;
      t35 = u_1 ^ 2;
      t38 = L * t12;
      t39 = lambda_2 * t3;
      t40 = t38 * t39;
      t42 = L * t13;
      t53 = L * t11;
      t64 = 30 * t12 * m * t35 - 48 * t24 * m * t35 + 30 * t6 * m * t35 + 4 * t10 * t14 * lambda_2 - 11 * t10 * t24 * lambda_2 - 3 * t10 * t6 * lambda_2 + 10 * L * lambda_1 - 20 * L * lambda_3 + 4 * t19 * lambda_1 + 4 * t19 * lambda_3 + 29 * t29 * lambda_1 - 43 * t29 * lambda_3 - 66 * t42 * lambda_1 + 60 * t42 * lambda_3 + 23 * t53 * lambda_1 - t53 * lambda_3 + 10 * t40;
      t66 = t4 ^ 2;
      t69 = L ^ 2;
      t70 = 0.1e1 / t69;
      t73 = 4 * t11 - 5;
      t74 = t73 ^ 2;
      t75 = 0.1e1 / t74;
      t77 = u_1 * t64 / t66 / t3 * t70 * t75;
      jac_10_5 = 3 * t77;
      t79 = L * (lambda_1 + lambda_3);
      t80 = t79 * t24;
      t82 = t42 * t39;
      t83 = 3 * t82;
      t87 = L * (lambda_1 - 5 * lambda_3) * t12;
      t90 = lambda_2 * L * t3;
      t92 = t35 * m;
      t99 = L * (lambda_1 - 2 * lambda_3) * t6;
      t104 = 0.1e1 / t66;
      t105 = 0.1e1 / t73;
      t106 = t104 * t105;
      jac_10_6 = (-3 * t80 - t83 - 3 * t87 + (6 * t90 + 27 * t92) * t11 + 6 * t99 - 3 * t90) * t70 * t106;
      t107 = t2 * t6;
      t111 = t107 * (t11 + 2) * t5 * t105;
      jac_10_10 = 3 * t111;
      t113 = t2 * t3 * t105;
      jac_10_11 = -3 * t113;
      t118 = t107 * (t11 - 4) * t5 * t105;
      jac_10_12 = 3 * t118;
      t122 = L * t14;
      t127 = L * t24;
      t146 = L * t6;
      t152 = 210 * t11 * m * t35 - 240 * t13 * m * t35 - 6 * t10 * t11 * lambda_2 + 4 * t10 * t28 * lambda_2 + 4 * t122 * lambda_1 + 4 * t122 * lambda_3 + 181 * t127 * lambda_1 - 179 * t127 * lambda_3 + 205 * t146 * lambda_1 - 185 * t146 * lambda_3 - 390 * t38 * lambda_1 + 360 * t38 * lambda_3 - t83 + 5 * t90 + 75 * t92;
      jac_11_5 = u_1 * t152 * t70 * t104 * t75;
      jac_11_6 = (-t79 * t13 - t40 - 14 * L * (lambda_1 - 0.8e1 / 0.7e1 * lambda_3) * t11 + (t90 + 45 * t92) * t6 + 15 * L * (lambda_1 - lambda_3)) * t70 / t4 / t3 * t105;
      jac_11_10 = t2 * (t11 + 15) * t8 * t105;
      jac_11_11 = t2 * t6 * t105;
      jac_11_12 = t2 * (t11 - 15) * t8 * t105;
      jac_12_5 = 2 * t77;
      jac_12_6 = (-2 * t80 - 2 * t82 - 2 * t87 + (4 * t90 + 18 * t92) * t11 + 4 * t99 - 2 * t90) * t70 * t106;
      jac_12_10 = 2 * t111;
      jac_12_11 = -2 * t113;
      jac_12_12 = 2 * t118;

      % store on output
      jac = zeros(13,13);
      jac(1,6) = jac_1_6;
      jac(2,7) = jac_2_7;
      jac(3,8) = jac_3_8;
      jac(4,9) = jac_4_9;
      jac(5,5) = jac_5_5;
      jac(5,6) = jac_5_6;
      jac(6,10) = jac_6_10;
      jac(6,12) = jac_6_12;
      jac(7,11) = jac_7_11;
      jac(8,12) = jac_8_12;
      jac(9,13) = jac_9_13;
      jac(10,5) = jac_10_5;
      jac(10,6) = jac_10_6;
      jac(10,10) = jac_10_10;
      jac(10,11) = jac_10_11;
      jac(10,12) = jac_10_12;
      jac(11,5) = jac_11_5;
      jac(11,6) = jac_11_6;
      jac(11,10) = jac_11_10;
      jac(11,11) = jac_11_11;
      jac(11,12) = jac_11_12;
      jac(12,5) = jac_12_5;
      jac(12,6) = jac_12_6;
      jac(12,10) = jac_12_10;
      jac(12,11) = jac_12_11;
      jac(12,12) = jac_12_12;

    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
      
      g = self.gravity;
      m = self.m;
      L = self.ell;
       
      % extract states
      x_1 = Z(1);
      y_1 = Z(2);
      x_2 = Z(3);
      y_2 = Z(4);
      theta = Z(5);
      u_1 = Z(6);
      v_1 = Z(7);
      u_2 = Z(8);
      v_2 = Z(9);
      lambda_1 = Z(10);
      lambda_2 = Z(11);
      lambda_3 = Z(12);
      lambda_4 = Z(13);

      % plot
      x_0 = 0;
      y_0 = 0;
      xc1 = L*cos(0:pi/100:2*pi);
      yc1 = L*sin(0:pi/100:2*pi);
      hold off;
      plot( xc1, yc1, '-r', 'Linewidth', 1 );
      hold on
      axis_lim = L*2.5;
      xc2 = -axis_lim:0.05:axis_lim;
      yc2 = 0.0*(-axis_lim:0.05:axis_lim);
      plot( xc2, yc2, '-r', 'Linewidth', 1 );
      axis equal
      drawLine( x_0, y_0, x_1, y_1, 'LineWidth', 8, 'Color', 'r' );
      drawLine( x_1, y_1, x_2, y_2, 'LineWidth', 8, 'Color', 'r' );
      drawCOG(0.1*self.ell,x_0,y_0);
      fillCircle( 'b', x_1, y_1, 0.1*self.ell );
      fillCircle( 'b', x_2, y_2, 0.1*self.ell );
      xlim([ -axis_lim axis_lim ]);
      ylim([ -axis_lim axis_lim ]);
      title('x,y');
    end
  end
end