ODE solve example 2
===================

Load ODE
--------

Consider the ODE:

.. math::

  \begin{cases}
     x' = u & \\
     y' = v & \\
     u' = -\lambda x& \\
     v' = -\lambda y - g& \\
     \lambda' = -\displaystyle\frac{4\lambda(xu+yv)+3vg}{x^2+y^2}; &
  \end{cases}

Define the class for the ODE to be integrated.
In this case the class ``Pendulum5EQ`` derived from 
the base class ``DAC_ODEclass``.
The following is the contents of the file `Pendulum5EQ.m`

.. code:: matlab

  classdef Pendulum5EQ < DAC_ODEclass
    properties (SetAccess = protected, Hidden = true)
      ell;
      gravity;
    end
    methods
      function self = Pendulum5EQ( ell, gravity )
        self@DAC_ODEclass('Pendulum5E');
        self.ell     = ell;
        self.gravity = gravity;
      end
      % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      function ode = f( self, t, Z )
        x      = Z(1);
        y      = Z(2);
        u      = Z(3);
        v      = Z(4);
        lambda = Z(5);
        g      = self.gravity;
        ell    = self.ell;
        ode    = zeros(5,1);
        ode(1) = u;
        ode(2) = v;
        ode(3) = -lambda*x;
        ode(4) = -lambda*y-g;
        ode(5) = -(4*lambda*(x*u+y*v)+3*v*g)/(x^2+y^2);
      end
      % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      function jac = DfDx( self, t, Z )
        x      = Z(1);
        y      = Z(2);
        u      = Z(3);
        v      = Z(4);
        lambda = Z(5);
        g      = self.gravity;
        ell    = self.ell;
        jac      = zeros(5,5);
        jac(1,3) = 1;
        jac(2,4) = 1;
        jac(3,1) = -lambda;
        jac(3,5) = -x;
        jac(4,2) = -lambda;
        jac(4,5) = -y;
  
        tmp  = x ^ 2 + y ^ 2;
        tmp2 = tmp^2;
        tmp3 = ( 6 * g * v) / tmp2;
        tmp4 = x ^ 2 - y ^ 2;
        xy   = x*y;
  
        jac(5,1) = lambda*( 8 * v * xy + 4 * u * tmp4 ) / tmp2 + tmp3 * x;
        jac(5,2) = lambda*( 8 * u * xy - 4 * v * tmp4 ) / tmp2 + tmp3 * y;
        jac(5,3) = -4 * lambda * x / tmp;
        jac(5,4) = (-4 * y * lambda - 3 * g) / tmp;
        jac(5,5) = -4*(x * u+y * v) / tmp;
      end
      % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
      function plot( self, t, Z )
        tt = 0:pi/30:2*pi;
        xx = self.ell*cos(tt);
        yy = self.ell*sin(tt);
        hold off;
        plot(xx,yy,'LineWidth',2,'Color','red');
        x  = Z(1);
        y  = Z(2);
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

Instantiate the ODE
-------------------

Having `Pendulum5EQ.m` now can instantiate the ODE

.. code:: matlab

  % load the Pendulum model in the variable ode
  ell     = 2;
  gravity = 9.81;
  ode     = Pendulum5EQ( ell, gravity );

Choose solver
-------------

Choose `ExplicitEuler` as solver and attach the
instantiated ode to it.

.. code:: matlab

  solver = ExplicitEuler(); % initialize solver
  solver.setODE(ode);       % Attach ode to the solver


Integrate
---------

Select the range and the sam pling point for the numerical solution

.. code:: matlab

  Tmax = 5;
  h    = 0.05;
  tt   = 0:h:Tmax;

setup initial condition, use hidden constraint


.. math::

  \begin{cases}
     2(xu+yv)=0&\\
     2\left(u^2+v^2-(x^2+y^2)-yg\right)=0&
  \end{cases}
  
to set consistent initial consdition

.. code:: matlab

  theta0  = pi/6;
  omega0  = 0;
  x0      = ell*sin(theta0);
  y0      = -ell*cos(theta0);
  u0      = 0;
  v0      = 0;
  lambda0 = -(y0*gravity+u0^2+v0^2)/(x0^2+y0^2);
  ini     = [x0;y0;u0;v0;lambda0];


compute numerical solution

.. code:: matlab
  
  sol = solver.advance( tt, ini );

now the matrix ``sol`` contain the solution.
The first column contain \(\theta\) the second column
contains  \(\omega\).

Extract solution
----------------

.. code:: matlab

  x = sol(1,:);
  y = sol(2,:);

Plot the solution
-----------------

.. code:: matlab

  % sample a circle and plot (the constraint) 
  xx = ell*cos(0:pi/100:2*pi);
  yy = ell*sin(0:pi/100:2*pi);
  plot( xx, yy, '-r', 'Linewidth', 1 );
  hold on
  axis equal
  plot( x, y, '-o', 'MarkerSize', 6, 'Linewidth', 2, 'Color', 'blue' );
  title('x,y');

.. image:: ./images/Manual_ODE_TEST2_fig1.png
   :width: 90%
   :align: center

.. code:: matlab

  ode.animate_plot( tt, sol, 10, 1 );

.. image:: ./images/Manual_ODE_TEST2_mov1.mp4
   :width: 90%
   :align: center
