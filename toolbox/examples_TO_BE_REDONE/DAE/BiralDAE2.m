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
%
classdef BiralDAE2 < DAE3baseClassImplicit
  properties (SetAccess = protected, Hidden = true)
    I1;
    R;
    L;
    x30;
    m2;
    kappa;
    c;
    H;
    alpha;
  end

  methods
    function self = BiralDAE2( kappa, c, alpha )
      % 2 pos/vel, 1 constraints
      self@DAE3baseClassImplicit('BiralDAE1',2,1);
      self.I1    = 0.01;
      self.R     = 0.1;
      self.L     = 0.4;
      self.x30   = 0.5;
      self.m2    = 0.2;
      self.H     = 0.05;
      self.kappa = kappa;
      self.c     = c;
      self.alpha = (alpha*pi)/180;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function Mass = M( self, ~, ~ )
      I1   = self.I1;
      m2   = self.m2;
      Mass = [ I1, 0; 0, m2 ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = Phi( self, t, pos )
      theta1 = pos(1);
      x2     = pos(2);
      alpha  = self.alpha;
      H      = self.H;
      R      = self.R;
      t1     = cos(alpha);
      t4     = cos(alpha + theta1);
      t6     = sin(alpha);
      rhs    = t1 * x2 - t6 * H - t4 * R;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = Phi_t( self, t, pos )
      rhs = zeros(1,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = Phi_q( self, t, pos )
      R      = self.R;
      alpha  = self.alpha;
      theta1 = pos(1);
      J = [  R*sin(alpha+theta1), cos(alpha) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function H = PhiL_q( self, t, pos, lambda )
      theta1 = pos(1);
      x2     = pos(2);
      alpha  = self.alpha;
      R      = self.R;
      H      = [ R*cos(alpha+theta1), 0; 0, 0];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function H = PhiV_q( self, t, pos, v_dot )
      theta1 = pos(1);
      x2     = pos(2);
      alpha  = self.alpha;
      R      = self.R;
      H      = [ R*cos(alpha+theta1)*v_dot(1), 0 ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce( self, t, pos, vel )
      theta1 = pos(1); x2 = pos(2);
      omega1 = vel(1); u2 = vel(2);

      L     = self.L;
      x30   = self.x30;
      kappa = self.kappa;
      c     = self.c;
      pos   = self.positive_part( (L + x2 - x30) * kappa - u2 * c);
      rhs   = [ self.T(t); -pos ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce_q( self, t, pos, vel )
      theta1 = pos(1); x2 = pos(2);
      omega1 = vel(1); u2 = vel(2);
      L     = self.L;
      x30   = self.x30;
      kappa = self.kappa;
      c     = self.c;
      pos_D = self.positive_part_D( (L + x2 - x30) * kappa - u2 * c);
      rhs   = pos_D * [ 0, 0; 0, -kappa ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = gforce_v( self, t, pos, vel )
      theta1 = pos(1); x2 = pos(2);
      omega1 = vel(1); u2 = vel(2);
      L     = self.L;
      x30   = self.x30;
      kappa = self.kappa;
      c     = self.c;
      pos_D = self.positive_part_D( (L + x2 - x30) * kappa - u2 * c);
      rhs   = pos_D * [ 0, 0; 0, c ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - B(t,q,v)
    function rhs = b( self, t, pos, vel )
      theta1 = pos(1); x2 = pos(2);
      omega1 = vel(1); u2 = vel(2);
      R      = self.R;
      alpha  = self.alpha;
      t1     = omega1^2;
      t4     = cos(alpha + theta1);
      rhs    = -t4 * t1 * R;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = b_q( self, t, pos, vel )
      theta1 = pos(1); x2 = pos(2);
      omega1 = vel(1); u2 = vel(2);
      R      = self.R;
      alpha  = self.alpha;
      rhs    = [sin(alpha+theta1)*omega1^2*R;0];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function rhs = b_v( self, t, pos, vel )
      theta1 = pos(1); x2 = pos(2);
      omega1 = vel(1); u2 = vel(2);
      R      = self.R;
      alpha  = self.alpha;
      rhs    = [-2*cos(alpha+theta1)*omega1*R;0];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function J = W_q( self, t, pos, v_dot )
      J = [R*cos(alpha+theta1)*v1, 0];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = T( self, t )
      res = 1;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = positive_part( self, x )
      res = max(x,0);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res = positive_part_D( self, x )
      if x > 0
        res = 1;
      else
        res = 0;
      end;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function x2 = theta_to_x2( self, theta1 )
      alpha = self.alpha;
      R     = self.R;
      H     = self.H;
      x2    = (sin(alpha) * H + cos(alpha + theta1) * R)/cos(alpha);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, pos )
      theta1 = pos(1);
      x2     = pos(2);
      R      = self.R;
      x30    = self.x30;
      H      = self.H;
      alpha  = self.alpha;
      ell    = R;
      xx1    = x2+ell*sin(alpha);
      yy1    = H+ell*cos(alpha);
      xx2    = x2-(ell+2*H)*sin(alpha);
      yy2    = H-(ell+2*H)*cos(alpha);
      hh     = R/4;

      hold off;
      drawAxes(2,0.25,0.5,0,0);
      hold on;
      fillRect( 'blue', xx1-xx2+2*hh, yy1-yy2+2*hh, xx2-hh, yy2-hh );
      fillRect( 'blue', x30, 2*hh, x2, H-hh );
      drawLine( xx1, yy1, xx2, yy2, 'LineWidth', 4, 'Color', 'white' );
      %drawLine( x2, H, x2+x30, H, 'LineWidth', 4, 'Color', 'blue' );
      drawLine( 0, 0, R*cos(theta1), R*sin(theta1), 'LineWidth', 2, 'Color', 'red' );
      drawCircle( 0, 0, R, 'LineWidth', 2, 'Color', 'k' ); % 0, 180*theta1/pi,
      drawCOG( R/10, 0, 0 );
      drawCOG( R/10, R*cos(theta1), R*sin(theta1) );
      drawCOG( R/10, x2, H );
      xlim([-0.2,0.8]);
      ylim([-0.2,0.2]);
    end
  end
end
