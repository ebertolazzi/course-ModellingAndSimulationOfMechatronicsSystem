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
classdef CrankRod14EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    ell;
    m;
    gravity;
  end
  methods
    function self = CrankRod14EQ( ell, m, gravity )
      neq  = 14;
      ninv = 12;
      self@DAC_ODEclass( 'CrankRod14EQ', neq, ninv );
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
      x__1 = vars__(1);
      y__1 = vars__(2);
      x__2 = vars__(3);
      y__2 = vars__(4);
      theta = vars__(5);
      u__1 = vars__(6);
      v__1 = vars__(7);
      u__2 = vars__(8);
      v__2 = vars__(9);
      omega = vars__(10);
      lambda__1 = vars__(11);
      lambda__2 = vars__(12);
      lambda__3 = vars__(13);
      lambda__4 = vars__(14);

      % evaluate function
      res__1 = u__1;
      res__2 = v__1;
      res__3 = u__2;
      res__4 = v__2;
      res__5 = omega;
      t2 = 0.1e1 / m;
      res__6 = t2 * (-lambda__3 + lambda__1);
      t3 = m * g;
      res__7 = t2 * (-t3 + lambda__2);
      res__8 = lambda__3 * t2;
      res__9 = t2 * (-t3 + lambda__4);
      t6 = omega ^ 2;
      t7 = cos(theta);
      t10 = L * m * t7 * t6;
      t14 = sin(theta);
      t15 = 0.1e1 / t14;
      res__10 = t2 * t15 / L * (-t10 - lambda__1 + lambda__3);
      t18 = t7 ^ 2;
      t22 = t14 * lambda__2;
      t24 = t18 * t7;
      t35 = 0.1e1 / (4 * t18 - 5);
      t37 = t15 * t35 * (3 * m * t18 * L * t6 + t18 * t22 + t24 * lambda__1 + t24 * lambda__3 + 2 * t7 * lambda__1 - 4 * t7 * lambda__3 - t22) * omega;
      res__11 = -3 * t37;
      res__12 = -t35 * (t18 * lambda__1 + t18 * lambda__3 + t7 * t22 + 15 * t10 + 15 * lambda__1 - 15 * lambda__3) * omega;
      res__13 = -2 * t37;
      
      % store on output
      res__f = zeros(14,1);
      res__f(1) = res__1;
      res__f(2) = res__2;
      res__f(3) = res__3;
      res__f(4) = res__4;
      res__f(5) = res__5;
      res__f(6) = res__6;
      res__f(7) = res__7;
      res__f(8) = res__8;
      res__f(9) = res__9;
      res__f(10) = res__10;
      res__f(11) = res__11;
      res__f(12) = res__12;
      res__f(13) = res__13;
   end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DfDx = DfDx( self, t, vars__ )
      % extract parameters
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x__1  = vars__(1);
      y__1  = vars__(2);
      x__2  = vars__(3);
      y__2  = vars__(4);
      theta = vars__(5);
      u__1  = vars__(6);
      v__1  = vars__(7);
      u__2  = vars__(8);
      v__2  = vars__(9);
      omega = vars__(10);
      lambda__1 = vars__(11);
      lambda__2 = vars__(12);
      lambda__3 = vars__(13);
      lambda__4 = vars__(14);

      % evaluate function
      res__1_1 = u__1;
      res__2_1 = v__1;
      res__3_1 = u__2;
      res__4_1 = v__2;
      res__5_1 = omega;
      t2 = 0.1e1 / m;
      res__6_1 = t2 * (lambda__1 - lambda__3);
      t3 = m * g;
      res__7_1 = t2 * (-t3 + lambda__2);
      res__8_1 = lambda__3 * t2;
      res__9_1 = t2 * (-t3 + lambda__4);
      t6 = omega ^ 2;
      t7 = cos(theta);
      t10 = L * m * t7 * t6;
      t14 = sin(theta);
      t15 = 0.1e1 / t14;
      res__10_1 = t2 * t15 / L * (-t10 - lambda__1 + lambda__3);
      t18 = t7 ^ 2;
      t24 = t18 * t7;
      t36 = 0.1e1 / (4 * t18 - 5);
      t38 = t15 * t36 * (3 * m * t18 * L * t6 + lambda__2 * t14 * t18 - lambda__2 * t14 + lambda__1 * t24 + lambda__3 * t24 + 2 * lambda__1 * t7 - 4 * lambda__3 * t7) * omega;
      res__11_1 = -3 * t38;
      res__12_1 = -t36 * (lambda__2 * t14 * t7 + lambda__1 * t18 + lambda__3 * t18 + 15 * t10 + 15 * lambda__1 - 15 * lambda__3) * omega;
      res__13_1 = -2 * t38;
      
      % store on output
      res__DfDx       = zeros(14,1);
      res__DfDx(1,1)  = res__1_1;
      res__DfDx(2,1)  = res__2_1;
      res__DfDx(3,1)  = res__3_1;
      res__DfDx(4,1)  = res__4_1;
      res__DfDx(5,1)  = res__5_1;
      res__DfDx(6,1)  = res__6_1;
      res__DfDx(7,1)  = res__7_1;
      res__DfDx(8,1)  = res__8_1;
      res__DfDx(9,1)  = res__9_1;
      res__DfDx(10,1) = res__10_1;
      res__DfDx(11,1) = res__11_1;
      res__DfDx(12,1) = res__12_1;
      res__DfDx(13,1) = res__13_1;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DfDt = DfDt( self, t, vars__ )
      res__DfDt = zeros(14,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__h = h( self, t, vars__ )
      % extract parameters
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x__1  = vars__(1);
      y__1  = vars__(2);
      x__2  = vars__(3);
      y__2  = vars__(4);
      theta = vars__(5);
      u__1  = vars__(6);
      v__1  = vars__(7);
      u__2  = vars__(8);
      v__2  = vars__(9);
      omega = vars__(10);
      lambda__1 = vars__(11);
      lambda__2 = vars__(12);
      lambda__3 = vars__(13);
      lambda__4 = vars__(14);

      % evaluate function
      t2 = sin(theta);
      t4 = cos(theta);
      res__1 = (t2 * (lambda__1 + lambda__3) - lambda__2 * t4) * L;
      t7 = t4 * L;
      res__2 = -x__1 + t7;
      res__3 = t2 * L - y__1;
      res__4 = -x__2 + x__1 + t7;
      res__5 = -y__2;
      t9 = L * omega;
      t10 = t2 * t9;
      res__6 = u__1 + t10;
      res__7 = -t4 * t9 + v__1;
      res__8 = u__2 - u__1 + t10;
      res__9 = v__2;
      t12 = m * g;
      t17 = omega ^ 2;
      t23 = 0.1e1 / m;
      res__10 = t23 / t2 * (t2 * (t12 - lambda__2) + t4 * (lambda__3 - lambda__1) - m * t17 * L);
      res__11 = t23 * (2 * lambda__1 - 3 * lambda__3);
      res__12 = t23 * (t12 - lambda__4);
      
      % store on output
      res__h     = zeros(12,1);
      res__h(1)  = res__1;
      res__h(2)  = res__2;
      res__h(3)  = res__3;
      res__h(4)  = res__4;
      res__h(5)  = res__5;
      res__h(6)  = res__6;
      res__h(7)  = res__7;
      res__h(8)  = res__8;
      res__h(9)  = res__9;
      res__h(10) = res__10;
      res__h(11) = res__11;
      res__h(12) = res__12;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DhDx = DhDx( self, t, vars__ )
      % extract parameters
      g = self.gravity;
      m = self.m;
      L = self.ell;
      
      % extract states
      x__1 = vars__(1);
      y__1 = vars__(2);
      x__2 = vars__(3);
      y__2 = vars__(4);
      theta = vars__(5);
      u__1 = vars__(6);
      v__1 = vars__(7);
      u__2 = vars__(8);
      v__2 = vars__(9);
      omega = vars__(10);
      lambda__1 = vars__(11);
      lambda__2 = vars__(12);
      lambda__3 = vars__(13);
      lambda__4 = vars__(14);

      % evaluate function
      t2 = cos(theta);
      t4 = sin(theta);
      res__1_5 = (t2 * (lambda__1 + lambda__3) + lambda__2 * t4) * L;
      res__1_11 = t4 * L;
      t7 = t2 * L;
      res__1_12 = -t7;
      res__1_13 = res__1_11;
      res__2_1 = -1;
      res__2_5 = -res__1_13;
      res__3_2 = -1;
      res__3_5 = t7;
      res__4_1 = 1;
      res__4_3 = -1;
      res__4_5 = res__2_5;
      res__5_4 = -1;
      t8 = L * omega;
      res__6_5 = t2 * t8;
      res__6_6 = 1;
      res__6_10 = res__1_13;
      res__7_5 = t4 * t8;
      res__7_7 = 1;
      res__7_10 = res__1_12;
      res__8_5 = res__6_5;
      res__8_6 = -1;
      res__8_8 = 1;
      res__8_10 = res__6_10;
      res__9_9 = 1;
      t9 = omega ^ 2;
      t14 = t4 ^ 2;
      t17 = 0.1e1 / m;
      res__10_5 = t17 / t14 * (L * m * t2 * t9 + lambda__1 - lambda__3);
      t18 = 0.1e1 / t4;
      res__10_10 = -2 * t18 * t8;
      t22 = t17 * t18 * t2;
      res__10_11 = -t22;
      res__10_12 = -t17;
      res__10_13 = t22;
      res__11_11 = 2 * t17;
      res__11_13 = -3 * t17;
      res__12_14 = res__10_12;
      
      % store on output
      res__DhDx = zeros(12,14);
      res__DhDx(1,5) = res__1_5;
      res__DhDx(1,11) = res__1_11;
      res__DhDx(1,12) = res__1_12;
      res__DhDx(1,13) = res__1_13;
      res__DhDx(2,1) = res__2_1;
      res__DhDx(2,5) = res__2_5;
      res__DhDx(3,2) = res__3_2;
      res__DhDx(3,5) = res__3_5;
      res__DhDx(4,1) = res__4_1;
      res__DhDx(4,3) = res__4_3;
      res__DhDx(4,5) = res__4_5;
      res__DhDx(5,4) = res__5_4;
      res__DhDx(6,5) = res__6_5;
      res__DhDx(6,6) = res__6_6;
      res__DhDx(6,10) = res__6_10;
      res__DhDx(7,5) = res__7_5;
      res__DhDx(7,7) = res__7_7;
      res__DhDx(7,10) = res__7_10;
      res__DhDx(8,5) = res__8_5;
      res__DhDx(8,6) = res__8_6;
      res__DhDx(8,8) = res__8_8;
      res__DhDx(8,10) = res__8_10;
      res__DhDx(9,9) = res__9_9;
      res__DhDx(10,5) = res__10_5;
      res__DhDx(10,10) = res__10_10;
      res__DhDx(10,11) = res__10_11;
      res__DhDx(10,12) = res__10_12;
      res__DhDx(10,13) = res__10_13;
      res__DhDx(11,11) = res__11_11;
      res__DhDx(11,13) = res__11_13;
      res__DhDx(12,14) = res__12_14;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__DhDt = DhDt( self, t, vars__ )
      res__DhDt = zeros(12,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
      CrankRod14EQPlot( t, Z(1), Z(2), Z(3), Z(4), self.ell );
    end
  end
end