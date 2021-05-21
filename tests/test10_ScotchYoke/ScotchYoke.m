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
classdef ScotchYoke < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
      m1;
      m2;
      iz1;
      iz2;
      R;
      H;
      L;
      alpha;
      X30;
      k;
      c;
      T;
  end
  methods
    function self = ScotchYoke( m1, m2, iz1, iz2, R, H, L, alpha, X30, k, c, T )
      neq  = 8;
      ninv = 6;
      self@DAC_ODEclass( 'CrankRod17EQ', neq, ninv );
      self.m1    = m1;
      self.m2    = m2;
      self.iz1   = iz1;
      self.iz2   = iz2;
      self.R     = R;
      self.H     = H;
      self.L     = L;
      self.alpha = alpha;
      self.X30   = X30;
      self.k     = k;
      self.c     = c;
      self.T     = T;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__f = f( self, t, vars__ )
      % extract parameters
      m1    = self.m1;
      m2    = self.m2;
      iz1   = self.iz1;
      iz2   = self.iz2;
      R     = self.R;
      H     = self.H;
      L     = self.L;
      alpha = self.alpha;
      X30   = self.X30;
      k     = self.k;
      c     = self.c;
      T     = self.T;
      
      % extract states
      x2         = vars__(1);
      s          = vars__(2);
      theta      = vars__(3);
      x2__dot    = vars__(4);
      s__dot     = vars__(5);
      theta__dot = vars__(6);
      lambda__1  = vars__(7);
      lambda__2  = vars__(8);

      % evaluate function
      res__1 = x2__dot;
      res__2 = s__dot;
      res__3 = theta__dot;
      t5 = min(0, (-L - x2 + X30) * k - x2__dot * c);
      t7 = 0.1e1 / m2;
      res__4 = t7 * (-lambda__1 + t5);
      t9 = cos(theta);
      t10 = t9 ^ 2;
      t12 = R ^ 2;
      t13 = m2 * t12;
      t16 = R * lambda__2;
      t17 = sin(theta);
      t18 = t17 * t16;
      t19 = theta__dot ^ 2;
      t20 = iz1 * t19;
      t24 = R * t17;
      t30 = 0.1e1 / iz1;
      t32 = sin(alpha);
      res__5 = 0.1e1 / t32 * t7 * t30 * (t5 * iz1 + t13 * lambda__1 * t10 + t9 * (t18 + t20) * m2 * R + T * m2 * t24 - (t13 + iz1) * lambda__1);
      t37 = lambda__1 * t24;
      res__6 = t30 * (lambda__2 * R * t9 + T - t37);
      t39 = cos(alpha);
      t62 = t39 * (t10 * t16 + t9 * (-t37 + 0.3e1 / 0.4e1 * T) - iz1 * t17 * t19 / 4 - t16 / 4) + (lambda__1 * R * t10 + t9 * (t18 + t20 / 4) - 0.3e1 / 0.4e1 * R * lambda__1 + 0.3e1 / 0.4e1 * T * t17) * t32;
      t65 = t10 * t13;
      t68 = t39 ^ 2;
      t78 = 0.1e1 / (t68 * (2 * t65 - t13 - iz1) + 2 * m2 * t12 * t32 * t17 * t9 * t39 - t65) * m2 * theta__dot;
      res__7 = -4 * t78 * t62 * R * t39;
      res__8 = -4 * t78 * t62 * R * t32;
      

      % store on output
      res__f    = zeros(8,1);
      res__f(1) = res__1;
      res__f(2) = res__2;
      res__f(3) = res__3;
      res__f(4) = res__4;
      res__f(5) = res__5;
      res__f(6) = res__6;
      res__f(7) = res__7;
      res__f(8) = res__8;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DfDx = DfDx( self, t, vars__ )
      % extract parameters
      m1    = self.m1;
      m2    = self.m2;
      iz1   = self.iz1;
      iz2   = self.iz2;
      R     = self.R;
      H     = self.H;
      L     = self.L;
      alpha = self.alpha;
      X30   = self.X30;
      k     = self.k;
      c     = self.c;
      T     = self.T;
      
      % extract states
      x2         = vars__(1);
      s          = vars__(2);
      theta      = vars__(3);
      x2__dot    = vars__(4);
      s__dot     = vars__(5);
      theta__dot = vars__(6);
      lambda__1  = vars__(7);
      lambda__2  = vars__(8);

      % evaluate function
      res__1_1 = x2__dot;
      res__2_1 = s__dot;
      res__3_1 = theta__dot;
      t5 = min(0, (-L - x2 + X30) * k - x2__dot * c);
      t7 = 0.1e1 / m2;
      res__4_1 = t7 * (-lambda__1 + t5);
      t9 = cos(theta);
      t10 = t9 ^ 2;
      t12 = R ^ 2;
      t13 = m2 * t12;
      t16 = R * lambda__2;
      t17 = sin(theta);
      t18 = t17 * t16;
      t19 = theta__dot ^ 2;
      t20 = iz1 * t19;
      t24 = R * t17;
      t30 = 0.1e1 / iz1;
      t32 = sin(alpha);
      res__5_1 = 0.1e1 / t32 * t7 * t30 * (t5 * iz1 + t13 * lambda__1 * t10 + t9 * (t18 + t20) * m2 * R + T * m2 * t24 - (t13 + iz1) * lambda__1);
      t37 = lambda__1 * t24;
      res__6_1 = t30 * (lambda__2 * R * t9 + T - t37);
      t39 = cos(alpha);
      t62 = t39 * (t10 * t16 + t9 * (-t37 + 0.3e1 / 0.4e1 * T) - iz1 * t17 * t19 / 4 - t16 / 4) + (lambda__1 * R * t10 + t9 * (t18 + t20 / 4) - 0.3e1 / 0.4e1 * R * lambda__1 + 0.3e1 / 0.4e1 * T * t17) * t32;
      t65 = t10 * t13;
      t68 = t39 ^ 2;
      t78 = 0.1e1 / (t68 * (2 * t65 - t13 - iz1) + 2 * m2 * t12 * t32 * t17 * t9 * t39 - t65) * m2 * theta__dot;
      res__7_1 = -4 * t78 * t62 * R * t39;
      res__8_1 = -4 * t78 * t62 * R * t32;
      
      % store on output
      res__DfDx      = zeros(8,1);
      res__DfDx(1,1) = res__1_1;
      res__DfDx(2,1) = res__2_1;
      res__DfDx(3,1) = res__3_1;
      res__DfDx(4,1) = res__4_1;
      res__DfDx(5,1) = res__5_1;
      res__DfDx(6,1) = res__6_1;
      res__DfDx(7,1) = res__7_1;
      res__DfDx(8,1) = res__8_1;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DfDt = DfDt( self, t, vars__ )
      res = zeros(8,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__h = h( self, t, vars__ )
      % extract parameters
      m1    = self.m1;
      m2    = self.m2;
      iz1   = self.iz1;
      iz2   = self.iz2;
      R     = self.R;
      H     = self.H;
      L     = self.L;
      alpha = self.alpha;
      X30   = self.X30;
      k     = self.k;
      c     = self.c;
      T     = self.T;
      
      % extract states
      x2         = vars__(1);
      s          = vars__(2);
      theta      = vars__(3);
      x2__dot    = vars__(4);
      s__dot     = vars__(5);
      theta__dot = vars__(6);
      lambda__1  = vars__(7);
      lambda__2  = vars__(8);
      
      % evaluate function
      t1 = sin(alpha);
      t3 = cos(alpha);
      res__1 = lambda__1 * t1 - lambda__2 * t3;
      t5 = cos(theta);
      res__2 = R * t5 + t1 * s - x2;
      t8 = sin(theta);
      t9 = R * t8;
      res__3 = -t3 * s - H + t9;
      res__4 = R * t8 * theta__dot - t1 * s__dot + x2__dot;
      res__5 = -R * t5 * theta__dot + t3 * s__dot;
      t22 = min(0, (-L - x2 + X30) * k - x2__dot * c);
      t24 = t5 ^ 2;
      t26 = R ^ 2;
      t27 = m2 * t26;
      t29 = R * m2;
      t30 = R * lambda__2;
      t32 = theta__dot ^ 2;
      res__6 = 0.1e1 / t1 / m2 / iz1 * (-t22 * iz1 * t3 + t3 * (-t27 * lambda__1 * t24 - t5 * (iz1 * t32 + t8 * t30) * t29 - T * m2 * t9 + (t27 + iz1) * lambda__1) - t29 * t1 * (-t24 * t30 + t5 * (lambda__1 * t9 - T) + iz1 * t8 * t32));

      % store on output
      res__h    = zeros(6,1);
      res__h(1) = res__1;
      res__h(2) = res__2;
      res__h(3) = res__3;
      res__h(4) = res__4;
      res__h(5) = res__5;
      res__h(6) = res__6;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DhDx = DhDx( self, t, vars__ )
      % extract parameters
      m1    = self.m1;
      m2    = self.m2;
      iz1   = self.iz1;
      iz2   = self.iz2;
      R     = self.R;
      H     = self.H;
      L     = self.L;
      alpha = self.alpha;
      X30   = self.X30;
      k     = self.k;
      c     = self.c;
      T     = self.T;
      
      % extract states
      x2         = vars__(1);
      s          = vars__(2);
      theta      = vars__(3);
      x2__dot    = vars__(4);
      s__dot     = vars__(5);
      theta__dot = vars__(6);
      lambda__1  = vars__(7);
      lambda__2  = vars__(8);
      
      % evaluate function
      res__1_7 = sin(alpha);
      t1 = cos(alpha);
      res__1_8 = -t1;
      res__2_1 = -1;
      res__2_2 = res__1_7;
      t2 = sin(theta);
      t3 = R * t2;
      res__2_3 = -t3;
      res__3_2 = res__1_8;
      t4 = cos(theta);
      res__3_3 = R * t4;
      res__4_3 = R * t4 * theta__dot;
      res__4_4 = 1;
      res__4_5 = -res__2_2;
      res__4_6 = t3;
      res__5_3 = R * t2 * theta__dot;
      res__5_5 = t1;
      res__5_6 = -res__3_3;
      t7 = 0.1e1 / res__2_2;
      t8 = res__5_5 * t7;
      t9 = 0.1e1 / m2;
      t13 = (L + x2 - X30) * k + x2__dot * c;
      t14 = 0 <= t13;
      t15 = t13 < 0;
      t16 = piecewise(t14, k, t15, 0);
      res__6_1 = t16 * t9 * t8;
      t18 = res__5_5 * t2;
      t19 = theta__dot ^ 2;
      t22 = t4 ^ 2;
      t27 = res__5_5 * t4;
      t38 = t2 * t4;
      t39 = R * res__2_2;
      t46 = res__2_2 * t2;
      t51 = 0.1e1 / iz1;
      t52 = t51 * t7;
      res__6_3 = t52 * (-2 * R * lambda__1 * res__2_2 * t22 - 2 * R * lambda__2 * t22 * res__5_5 - iz1 * res__2_2 * t19 * t4 + lambda__2 * R * res__5_5 + iz1 * t19 * t18 + 2 * lambda__1 * t3 * t27 - 2 * lambda__2 * t39 * t38 - T * t27 - T * t46 + lambda__1 * t39) * R;
      t53 = piecewise(t14, c, t15, 0);
      res__6_4 = t53 * t9 * t8;
      res__6_6 = -2 * t7 * (t46 + t27) * theta__dot * R;
      t60 = R ^ 2;
      t61 = m2 * t60;
      res__6_7 = t7 * t9 * t51 * (res__5_5 * (-t22 * t61 + iz1 + t61) - m2 * t60 * res__2_2 * t38);
      res__6_8 = -t4 * t52 * (-res__2_2 * t4 + t18) * t60;
      
      % store on output
      res__DhDx      = zeros(6,8);
      res__DhDx(1,7) = res__1_7;
      res__DhDx(1,8) = res__1_8;
      res__DhDx(2,1) = res__2_1;
      res__DhDx(2,2) = res__2_2;
      res__DhDx(2,3) = res__2_3;
      res__DhDx(3,2) = res__3_2;
      res__DhDx(3,3) = res__3_3;
      res__DhDx(4,3) = res__4_3;
      res__DhDx(4,4) = res__4_4;
      res__DhDx(4,5) = res__4_5;
      res__DhDx(4,6) = res__4_6;
      res__DhDx(5,3) = res__5_3;
      res__DhDx(5,5) = res__5_5;
      res__DhDx(5,6) = res__5_6;
      res__DhDx(6,1) = res__6_1;
      res__DhDx(6,3) = res__6_3;
      res__DhDx(6,4) = res__6_4;
      res__DhDx(6,6) = res__6_6;
      res__DhDx(6,7) = res__6_7;
      res__DhDx(6,8) = res__6_8;  
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DhDt = DhDt( self, t, vars__ )
      res__DhDt = zeros(6,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
      ScotchYokePlot( t, Z(1), Z(2), Z(3), self.R, self.H, self.L, self.alpha );
    end
  end
end