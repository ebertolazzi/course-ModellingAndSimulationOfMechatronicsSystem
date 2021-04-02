ODE solve example 2
===================

Load ODE
--------

Consider a crank-rod system decribed by the following DAE:

.. math::

  \begin{cases}
    x_1' = u_1 & \\
    y_1' = v_1 & \\
    x_2' = u_2 & \\
    y_2' = v_2 & \\
    \theta_2' = \omega_1 & \\
    \theta_2' = \omega_1 & \\
    m u_1' - \lambda_1 + \lambda_3 = 0 & \\
    m v_1' + mg-lambda_2 = 0 & \\
    m u_2' - \lambda_3 = 0 & \\
    m v_2' + mg-\lambda_4 = 0 & \\
    -\lambda_1\ell\sin(\theta_1)-\lambda_2\ell\sin(\theta_1) = 0 & \\
    -\lambda_3\ell\sin(\theta_2) = 0 & \\
    x_1 - \ell\cos(\theta_1) = 0 & \\
    y_1 - \ell\cos(\theta_1) = 0 & \\
    x_2 - x_1-\ell\cos(\theta_2) = 0 & \\
    y_2 = 0 &
  \end{cases}

If index is reduced, we obtain the ODE:

.. math::

  \begin{cases}
    x_1' = u_1 & \\
    y_1' = v_1 & \\
    x_2' = u_2 & \\
    y_2' = v_2 & \\
    \theta_2' = \omega_1 & \\
    \theta_2' = \omega_1 & \\
    u_1' = \dfrac{\lambda_3-\lambda_1}{m} & \\
    v_1' = \dfrac{lambda_2 - mg}{m} & \\
    u_2' = \dfrac{\lambda_3}{m} & \\
    v_2' = \dfrac{\lambda_4 - mg}{m}  & \\
    \omeega_1' = \omega_1' & \\
    \omeega_2' = \omega_2' & \\
    \lambda_3' = -\dfrac{\cos(\theta_2) \lambda_3 omega_2}{\sin(\theta_2)} & \\
    \lambda_1' = -\dfrac{1}{2\sin(\theta_1)\sin(\theta_2)} \omega_1\cos(\theta_1)\sin(\theta_2)\lambda_1+\omega_1\cos(theta_1)\sin(theta_2)\lambda_2 + \cos(\theta_2)\lambda_3\omega_2\sin(\theta_1) & \\
    \lambda_2' = -\dfrac{1}{2\sin(\theta_1)\sin(\theta_2)} \omega_1\cos(\theta_1)\sin(\theta_2)\lambda_1+\omega_1\cos(theta_1)\sin(theta_2)\lambda_2 - \cos(\theta_2)\lambda_3\omega_2\sin(\theta_1) & \\
    \lambda_4' = 0 &
  \end{cases}

Define the class for the ODE to be integrated.
In this case the class ``CrankRod`` derived from
the base class ``DAC_ODEclass``.
The following is the contents of the file `CrankRod.m`

.. code:: matlab

    bla

Instantiate the ODE
-------------------

Having `CrankRod.m` now can instantiate the ODE

.. code:: matlab

  % load the Pendulum model in the variable ode
  ell     = 1;
  m       = 0.1;
  gravity = 9.81;
  ode     = CrankRod( ell, m, gravity );

Choose solver
-------------

Choose `ExplicitEuler` as solver and attach the
instantiated ode to it.

.. code:: matlab

  solver = ExplicitEuler(); % initialize solver
  solver.setODE(ode);       % Attach ode to the solver


Integrate
---------

Select the range and the sampling point for the numerical solution

.. code:: matlab

  Tmax = 10.0;
  h    = 0.05;
  tt   = 0:h:Tmax;

setup initial condition, use hidden constraint

.. math::

  \begin{cases}

  \end{cases}

to set consistent initial consdition

.. code:: matlab

  angle     = -pi/3;
  speed     = 0.0;
  x_10      = ell*cos(angle);
  y_10      = ell*sin(angle);
  x_20      = 2*ell*cos(angle);
  y_20      = 0;
  theta_10  = angle;
  u_10      = -speed*ell*sin(angle);
  v_10      = speed*ell*cos(angle);
  u_20      = -2*speed*ell*sin(angle);
  v_20      = 0;
  lambda_10 = -3*cos(angle)*m*(ell*speed^2-sin(angle)*gravity)/(4*sin(angle)^2+1);
  lambda_20 = -5*sin(angle)*m*(ell*speed^2-sin(angle)*gravity)/(4*sin(angle)^2+1);
  lambda_30 = -2*cos(angle)*m*(ell*speed^2-sin(angle)*gravity)/(4*sin(angle)^2+1);
  lambda_40 = m*gravity;
  ini      = [ x_10; y_10; x_20; y_20; theta_10; ...
               u_10; v_10; u_20; v_20; ...
               lambda_10; lambda_20; lambda_30; lambda_40 ];

compute numerical solution

.. code:: matlab

  sol = solver.advance( tt, ini );

now the matrix ``sol`` contain the solution.
The first column contain \(\theta\) the second column
contains  \(\omega\).

Extract solution
----------------

.. code:: matlab

  x_1     = sol(1,:);
  y_1     = sol(2,:);
  x_2     = sol(3,:);
  y_2     = sol(4,:);
  theta_1 = sol(5,:);
  u_1     = sol(7,:);
  v_1     = sol(8,:);
  u_2     = sol(9,:);
  v_2     = sol(10,:);

Plot the solution
-----------------

.. code:: matlab

  % sample a circle and plot (the constraint)
  xc1 = ell*cos(0:pi/100:2*pi);
  yc1 = ell*sin(0:pi/100:2*pi);
  plot( xc1, yc1, '-r', 'Linewidth', 1 );
  hold on
  xc2 = ell*(-2.2:0.05:2.2);
  yc2 = 0.0*(-2.2:0.05:2.2);
  plot( xc2, yc2, '-r', 'Linewidth', 1 );
  axis equal
  plot( x_1, y_1, '-o', 'MarkerSize', 6, 'Linewidth', 2, 'Color', 'blue' );
  plot( x_2, y_2, '-o', 'MarkerSize', 6, 'Linewidth', 2, 'Color', 'green' );
  xlim([-2.2 2.2])
  ylim([-2.2 2.2])
  title('x,y');

.. image:: ./images/Manual_ODE_TEST2_fig1.png
   :width: 90%
   :align: center

.. code:: matlab

  ode.animate_plot( tt, sol, 10, 1 );

.. image:: ./images/Manual_ODE_TEST2_mov1.mp4
   :width: 90%
   :align: center
