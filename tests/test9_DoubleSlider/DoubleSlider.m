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
classdef DoubleSlider < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    ell;
    m;
    gravity;
  end
  methods
    function self = DoubleSlider( ell, m, gravity )
      neq  = 8;
      ninv = 6;
      self@DAC_ODEclass( 'DoubleSlider', neq, ninv );
      self.ell     = ell;
      self.m       = m;
      self.gravity = gravity;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__f = f( self, t, vars__ )
      % extract parameters
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x         = vars__(1);
      y         = vars__(2);
      theta     = vars__(3);
      u         = vars__(4);
      v         = vars__(5);
      omega     = vars__(6);
      lambda__1 = vars__(7);
      lambda__2 = vars__(8);
      
      % evaluate function
      res__1 = u;
      res__2 = v;
      res__3 = omega;
      t1 = 0.1e1 / m;
      res__4 = 2 * lambda__2 * t1;
      t3 = m * g;
      res__5 = t1 * (-t3 + 2 * lambda__1);
      t6 = cos(theta);
      t8 = omega ^ 2;
      t9 = t8 * m;
      t10 = t9 * t6 * L;
      t16 = sin(theta);
      t17 = 0.1e1 / t16;
      res__6 = t1 * t17 / L * (-t10 + 2 * t3 - 4 * lambda__1);
      t19 = t6 ^ 2;
      res__7 = t17 * (3 * t9 * t19 * L - 6 * m * g * t6 - 4 * t16 * t19 * lambda__2 + 4 * t19 * t6 * lambda__1 + 4 * t16 * lambda__2 + 8 * t6 * lambda__1) * omega / 4;
      res__8 = -(-4 * t16 * t6 * lambda__2 + 4 * t19 * lambda__1 + 3 * t10 - 6 * t3 + 12 * lambda__1) * omega / 4;
      
      % store on output
      res__f = zeros(8,1);
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
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x         = vars__(1);
      y         = vars__(2);
      theta     = vars__(3);
      u         = vars__(4);
      v         = vars__(5);
      omega     = vars__(6);
      lambda__1 = vars__(7);
      lambda__2 = vars__(8);
      
      % evaluate function
      res__1_1 = u;
      res__2_1 = v;
      res__3_1 = omega;
      t1 = 0.1e1 / m;
      res__4_1 = 2 * lambda__2 * t1;
      t3 = m * g;
      res__5_1 = t1 * (-t3 + 2 * lambda__1);
      t6 = cos(theta);
      t8 = omega ^ 2;
      t9 = t8 * m;
      t10 = t9 * t6 * L;
      t16 = sin(theta);
      t17 = 0.1e1 / t16;
      res__6_1 = t1 * t17 / L * (-t10 + 2 * t3 - 4 * lambda__1);
      t19 = t6 ^ 2;
      res__7_1 = t17 * (3 * t9 * t19 * L - 6 * m * g * t6 - 4 * t16 * t19 * lambda__2 + 4 * t19 * t6 * lambda__1 + 4 * t16 * lambda__2 + 8 * t6 * lambda__1) * omega / 4;
      res__8_1 = -(-4 * t16 * t6 * lambda__2 + 4 * t19 * lambda__1 + 3 * t10 - 6 * t3 + 12 * lambda__1) * omega / 4;
      
      % store on output
      res__DfDx = zeros(8,1);
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
      res__DfDt = zeros(8,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__h = h( self, t, vars__ )
      % extract parameters
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x         = vars__(1);
      y         = vars__(2);
      theta     = vars__(3);
      u         = vars__(4);
      v         = vars__(5);
      omega     = vars__(6);
      lambda__1 = vars__(7);
      lambda__2 = vars__(8);
      
      % evaluate function
      t1 = cos(theta);
      t3 = sin(theta);
      res__1 = (lambda__2 * t1 + lambda__1 * t3) * L;
      res__2 = t1 * L - 2 * y;
      res__3 = -t3 * L - 2 * x;
      t11 = L * omega;
      res__4 = t3 * t11 + 2 * v;
      res__5 = t1 * t11 + 2 * u;
      t21 = omega ^ 2;
      res__6 = 0.1e1 / m / t3 * (t1 * (-2 * m * g + 4 * lambda__1) + t21 * m * L - 4 * t3 * lambda__2);
      
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
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x         = vars__(1);
      y         = vars__(2);
      theta     = vars__(3);
      u         = vars__(4);
      v         = vars__(5);
      omega     = vars__(6);
      lambda__1 = vars__(7);
      lambda__2 = vars__(8);

      % evaluate function
      t1 = cos(theta);
      t3 = sin(theta);
      res__1_3 = (t1 * lambda__1 - t3 * lambda__2) * L;
      res__1_7 = t3 * L;
      res__1_8 = t1 * L;
      res__2_2 = -2;
      res__2_3 = -res__1_7;
      res__3_1 = -2;
      res__3_3 = -res__1_8;
      t6 = L * omega;
      res__4_3 = t1 * t6;
      res__4_5 = 2;
      res__4_6 = res__1_7;
      res__5_3 = -t3 * t6;
      res__5_4 = 2;
      res__5_6 = res__1_8;
      t8 = omega ^ 2;
      t15 = t3 ^ 2;
      t18 = 0.1e1 / m;
      res__6_3 = t18 / t15 * (-t8 * m * res__5_6 + 2 * m * g - 4 * lambda__1);
      t19 = 0.1e1 / t3;
      res__6_6 = 2 * t19 * t6;
      res__6_7 = 4 * t18 * t19 * t1;
      res__6_8 = -4 * t18;
      
      % store on output
      res__DhDx      = zeros(6,8);
      res__DhDx(1,3) = res__1_3;
      res__DhDx(1,7) = res__1_7;
      res__DhDx(1,8) = res__1_8;
      res__DhDx(2,2) = res__2_2;
      res__DhDx(2,3) = res__2_3;
      res__DhDx(3,1) = res__3_1;
      res__DhDx(3,3) = res__3_3;
      res__DhDx(4,3) = res__4_3;
      res__DhDx(4,5) = res__4_5;
      res__DhDx(4,6) = res__4_6;
      res__DhDx(5,3) = res__5_3;
      res__DhDx(5,4) = res__5_4;
      res__DhDx(5,6) = res__5_6;
      res__DhDx(6,3) = res__6_3;
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
      DoubleSliderPlot( t, Z(1), Z(2), Z(3), self.ell );
    end
  end
end