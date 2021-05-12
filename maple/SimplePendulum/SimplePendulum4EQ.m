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
classdef SimplePendulum4EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    ell;
    mass;
    gravity;
  end
  methods (Access = private)
    function res__bigRHS = bigRHS( self, t, vars__ )
      % extract parameters
      g = self.gravity;
      m = self.mass;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
    
      % evaluate function
      res__2 = -m * g;
      t2     = u ^ 2;
      t3     = v ^ 2;
      res__3 = -2 * t2 - 2 * t3;

      % store on output
      res__bigRHS    = zeros(3,1);
      res__bigRHS(2) = res__2;
      res__bigRHS(3) = res__3;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__JbigRHS = JbigRHS( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      jac__3_3 = -4 * u;
      jac__3_4 = -4 * v;
      
      % store on output
      jac__JbigRHS      = zeros(3,4);
      jac__JbigRHS(3,3) = jac__3_3;
      jac__JbigRHS(3,4) = jac__3_4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__bigM = bigM( self, t, vars__ )
      % extract parameters
      g = self.gravity;
      m = self.mass;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);
    
      % evaluate function
      jac__1_1 = m;
      jac__1_3 = 2 * x;
      jac__2_2 = m;
      jac__2_3 = 2 * y;
      jac__3_1 = jac__1_3;
      jac__3_2 = jac__2_3;

      % store on output
      jac__bigM      = zeros(3,3);
      jac__bigM(1,1) = jac__1_1;
      jac__bigM(1,3) = jac__1_3;
      jac__bigM(2,2) = jac__2_2;
      jac__bigM(2,3) = jac__2_3;
      jac__bigM(3,1) = jac__3_1;
      jac__bigM(3,2) = jac__3_2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__bigETA = bigETA( self, t, vars__, mu )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      mu1 = mu(1);
      mu2 = mu(2);
      mu3 = mu(3);

      % evaluate function
      res__1 = m * mu1 + 2 * x * mu3;
      res__2 = m * mu2 + 2 * y * mu3;
      res__3 = 2 * x * mu1 + 2 * y * mu2;

      % store on output
      res__bigETA = zeros(3,1);
      res__bigETA(1) = res__1;
      res__bigETA(2) = res__2;
      res__bigETA(3) = res__3;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac__JbigETA = JbigETA( self, t, vars__, mu )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      mu1 = mu(1);
      mu2 = mu(2);
      mu3 = mu(3);

      % evaluate function
      jac__1_1 = 2 * mu3;
      jac__2_2 = jac__1_1;
      jac__3_1 = 2 * mu1;
      jac__3_2 = 2 * mu2;
      
      % store on output
      jac__JbigETA      = zeros(3,4);
      jac__JbigETA(1,1) = jac__1_1;
      jac__JbigETA(2,2) = jac__2_2;
      jac__JbigETA(3,1) = jac__3_1;
      jac__JbigETA(3,2) = jac__3_2;
    end
  end

  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = SimplePendulum4EQ( mass, ell, gravity )
      self@DAC_ODEclass('SimplePendulum4EQ',4);
      self.mass    = mass;
      self.ell     = ell;
      self.gravity = gravity;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__rhs = f( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate u__d, v__d
      RHS  = self.bigRHS( t, vars__ );
      M    = self.bigM( t, vars__ );
      SOL  = M\RHS;
      u__d = SOL(1);
      v__d = SOL(2);
    
      % evaluate function
      res__1 = u;
      res__2 = v;
      res__3 = u__d;
      res__4 = v__d;

      % store on output
      res__rhs = zeros(4,1);
      res__rhs(1) = res__1;
      res__rhs(2) = res__2;
      res__rhs(3) = res__3;
      res__rhs(4) = res__4;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac = DfDx( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate u__d, v__d
      %
      %  M(p) v' = RHS(p,v)
      %
      RHS = self.bigRHS( t, vars__ );
      M   = self.bigM( t, vars__ );
      SOL = M\RHS;

      u__d   = SOL(1);
      v__d   = SOL(2);
      lambda = SOL(3);

      vdot   = [u__d,v__d,lambda];

      %ETA  = self.bigETA( t, vars__, vdot );
      JETA = self.JbigETA( t, vars__, vdot );
      JRHS = self.JbigRHS( t, vars__ );
      
      % find jacobian of u__d, v__d
      JM = M\(JRHS-JETA);
      
      % combine all jacobians
      jac = [ zeros(2,2) eye(2); JM(1:2,:) ];

    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      tt = 0:pi/30:2*pi;
      xx = self.ell*cos(tt);
      yy = self.ell*sin(tt);
      hold off;
      plot(xx,yy,'LineWidth',2,'Color','red');
      LL = 1-self.ell/hypot(x,y);
      x0 = LL*x;
      y0 = LL*y;
      hold on;
      L = 1.5*self.ell;
      drawLine(-L,0,L,0,'LineWidth',2,'Color','k');
      drawLine(0,-L,0,L,'LineWidth',2,'Color','k');
      drawAxes(2,0.25,1,0,0);
      drawLine(x0,y0,x,y,'LineWidth',8,'Color','b');
      drawCOG( 0.1*self.ell, x0, y0 );
      fillCircle( 'r', x, y, 0.1*self.ell );
      axis([-L L -L L]);
      axis equal;
    end
  end
end
