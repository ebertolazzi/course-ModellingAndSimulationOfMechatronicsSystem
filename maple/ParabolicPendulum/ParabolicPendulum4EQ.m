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
classdef ParabolicPendulum4EQ < DAC_ODEclass
  properties (SetAccess = protected, Hidden = true)
    mass;
    gravity;
    % baumgarte stabilization
    omega;
    eta;
    npos;
  end
  methods (Access = private)
    function res__bigRHS = bigRHS( self, t, vars__ )
      % extract parameters
      g     = self.gravity;
      m     = self.mass;
      omega = self.omega;
      eta   = self.eta;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      t1 = u ^ 2;
      res__1 = (4 * t1 + g) * x;
      res__2 = 2 * t1 - g / 2;
      t6 = x ^ 2;
      t7 = t6 ^ 2;
      t11 = y ^ 2;
      t13 = omega ^ 2;
      t36 = v ^ 2;
      res__3 = t13 * (-t7 + t6 * (2 * y - 1) - t11 + 1) - 8 * omega * eta * (t6 * x * u - t6 * v / 2 - (y - 0.1e1 / 0.2e1) * u * x + v * y / 2) - 12 * t6 * t1 + 8 * u * v * x + t1 * (4 * y - 2) - 2 * t36;
  
      % store on output
      res__bigRHS = zeros(3,1);
      res__bigRHS(1) = res__1;
      res__bigRHS(2) = res__2;
      res__bigRHS(3) = res__3;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__JbigRHS = JbigRHS( self, t, vars__ )
      % extract parameters
      omega = self.omega;
      eta   = self.eta;
      g     = self.gravity;

      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      t1 = u ^ 2;
      t2 = 4 * t1;
      res__1_1 = t2 + g;
      t3 = x * u;
      res__1_3 = 8 * t3;
      res__2_3 = 4 * u;
      t4 = x ^ 2;
      t5 = t4 * x;
      t11 = omega ^ 2;
      t13 = t4 * u;
      res__3_1 = t11 * (-4 * t5 + (4 * y - 2) * x) - 24 * omega * (t13 - v * x / 3 - (y - 0.1e1 / 0.2e1) * u / 3) * eta - 24 * t1 * x + 8 * u * v;
      t27 = t4 - y;
      res__3_2 = 2 * t11 * t27 + 8 * omega * eta * (t3 - v / 2) + t2;
      t40 = 8 * y - 4;
      res__3_3 = -8 * t5 * omega * eta - 24 * t13 + x * (omega * eta * t40 + 8 * v) + u * t40;
      res__3_4 = 4 * omega * t27 * eta - 4 * v + res__1_3;
      
      % store on output
      res__JbigRHS = zeros(3,4);
      res__JbigRHS(1,1) = res__1_1;
      res__JbigRHS(1,3) = res__1_3;
      res__JbigRHS(2,3) = res__2_3;
      res__JbigRHS(3,1) = res__3_1;
      res__JbigRHS(3,2) = res__3_2;
      res__JbigRHS(3,3) = res__3_3;
      res__JbigRHS(3,4) = res__3_4;

    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__bigM = bigM( self, t, vars__ )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      % evaluate function
      t1 = x ^ 2;
      res__1_1 = 4 * t1 + 1;
      res__1_2 = 2 * x;
      res__1_3 = 4 * t1 * x - 4 * x * y + res__1_2;
      res__2_1 = res__1_2;
      res__2_2 = 1;
      res__2_3 = -2 * t1 + 2 * y;
      res__3_1 = res__1_3;
      res__3_2 = res__2_3;
      
      % store on output
      res__bigM = zeros(3,3);
      res__bigM(1,1) = res__1_1;
      res__bigM(1,2) = res__1_2;
      res__bigM(1,3) = res__1_3;
      res__bigM(2,1) = res__2_1;
      res__bigM(2,2) = res__2_2;
      res__bigM(2,3) = res__2_3;
      res__bigM(3,1) = res__3_1;
      res__bigM(3,2) = res__3_2;
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

      omega = self.omega;
      eta   = self.eta;

      % evaluate function
      t1 = u ^ 2;
      res__1 = -(4 * t1 + g) * x;
      res__2 = -2 * t1 + g / 2;
      t7 = x ^ 2;
      t8 = t7 ^ 2;
      t12 = y ^ 2;
      t14 = omega ^ 2;
      t37 = v ^ 2;
      res__3 = t14 * (-t8 + t7 * (2 * y - 1) - t12 + 1) - 8 * omega * eta * (t7 * x * u - t7 * v / 2 - u * (y - 0.1e1 / 0.2e1) * x + v * y / 2) - 12 * t7 * t1 + 8 * u * v * x + t1 * (4 * y - 2) - 2 * t37;

      % store on output
      res__bigRHS    = zeros(3,1);
      res__bigRHS(1) = res__1;
      res__bigRHS(2) = res__2;
      res__bigRHS(3) = res__3;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__JbigETA = JbigETA( self, t, vars__, mu )
      % extract states
      x = vars__(1);
      y = vars__(2);
      u = vars__(3);
      v = vars__(4);

      mu1 = mu(1);
      mu2 = mu(2);
      mu3 = mu(3);

      omega = self.omega;
      eta   = self.eta;
      g     = self.gravity;

      % evaluate function
      t1 = u ^ 2;
      t2 = 4 * t1;
      res__1_1 = -t2 - g;
      t3 = x * u;
      t4 = 8 * t3;
      res__1_3 = -t4;
      res__2_3 = -4 * u;
      t6 = x ^ 2;
      t7 = t6 * x;
      t13 = omega ^ 2;
      t15 = t6 * u;
      res__3_1 = t13 * (-4 * t7 + (4 * y - 2) * x) - 24 * omega * eta * (t15 - v * x / 3 - u * (y - 0.1e1 / 0.2e1) / 3) - 24 * t1 * x + 8 * u * v;
      t29 = t6 - y;
      res__3_2 = 2 * t13 * t29 + 8 * omega * eta * (t3 - v / 2) + t2;
      t42 = 8 * y - 4;
      res__3_3 = -8 * t7 * omega * eta - 24 * t15 + x * (omega * eta * t42 + 8 * v) + u * t42;
      res__3_4 = 4 * omega * t29 * eta + t4 - 4 * v;
      
      % store on output
      res__JbigETA      = zeros(3,4);
      res__JbigETA(1,1) = res__1_1;
      res__JbigETA(1,3) = res__1_3;
      res__JbigETA(2,3) = res__2_3;
      res__JbigETA(3,1) = res__3_1;
      res__JbigETA(3,2) = res__3_2;
      res__JbigETA(3,3) = res__3_3;
      res__JbigETA(3,4) = res__3_4;
    end
  end

  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = ParabolicPendulum4EQ( mass, gravity )
      % call the constructor of the basic class
      self@DAC_ODEclass('ParabolicPendulum4EQ',4);
      % setup of the parmater of the ODE
      self.mass    = mass;
      self.gravity = gravity;
      self.eta     = 0;
      self.omega   = 0;
      self.npos    = 2;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function setBaumgarte( self, eta, omega )
      self.eta   = eta;
      self.omega = omega;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function res__rhs = f( self, t, vars__ )
      npos = self.npos;
      %
      %       / f(q,v,t) \
      % RHS = |          |
      %       \ g(q,v,t) /
      %
      RHS = self.bigRHS( t, vars__ );
      %
      %
      %        / M(q,v,t)  Phi_q(q,t)^T \
      % BIGM = |                        |
      %        \ Phi_q(q,t)     0       /
      %
      BIGM = self.bigM( t, vars__ );
      SOL  = BIGM\RHS;
    
      % evaluate function
      res__rhs = zeros(2*npos,1);
      res__rhs(1:npos)        = vars__(npos+1:2*npos);
      res__rhs(npos+1:2*npos) = SOL(1:npos);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function jac = DfDx( self, t, vars__ )
      %
      %       / f(q,v,t) \
      % RHS = |          |
      %       \ g(q,v,t) /
      %
      RHS = self.bigRHS( t, vars__ );
      %
      %
      %        / M(q,v,t)  Phi_q(q,t)^T \
      % BIGM = |                        |
      %        \ Phi_q(q,t)     0       /
      %
      BIGM = self.bigM( t, vars__ );

      SOL  = BIGM\RHS;
      JETA = self.JbigETA( t, vars__, SOL );
      JRHS = self.JbigRHS( t, vars__ );
      JM   = BIGM\(JRHS-JETA);
      
      % combine all jacobians
      npos = self.npos;
      jac  = [ zeros(npos,npos) eye(npos); JM(1:npos,:) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function plot( self, t, Z )
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
      x = Z(1);
      y = Z(2);

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
