
ODE/DAE library
===============

LIbrary use to test numerical solver for ODE and DAE for the course ...

## ODE solve example

### Load ODE

Consider the ODE:

```math
  \begin{cases}
     \theta' = \omega & \\
     \omega' = -\displaystyle\frac{g}{\ell}\sin\theta &
  \end{cases}
```

Define the class for the ODE to be integrated.
In this case the class ``Pendulum2EQ`` derived from the base class ``ODEbaseClass``. The following is the contents of the file `Pendulum2EQ.m`

```matlab
classdef Pendulum2EQ < ODEbaseClass
  properties (SetAccess = protected, Hidden = true)
    ell;
    gravity;
  end
  methods
    function self = Pendulum2EQ( ell, gravity )
      self@ODEbaseClass('Pendulum2EQ');
      self.ell     = ell;
      self.gravity = gravity;
    end
    function ode = f( self, t, Z )
      % extract components
      theta  = Z(1);
      omega  = Z(2);
      % get parameters of the ODE
      g      = self.gravity; 
      ell    = self.ell;
      ode    = zeros(2,1);
      % build rhs
      ode(1) = omega;
      ode(2) = -(g/ell)*sin(theta);
    end
    function jac = DfDx( self, t, Z )
      % evaluate Jacobian of rhs.
      % Necessary only for implicit solver
      theta    = Z(1);
      omega    = Z(2);
      g        = self.gravity;
      ell      = self.ell;
      jac      = zeros(2,2);
      jac(1,2) = 1;
      jac(2,1) = -(g/ell)*cos(theta);
    end
    function res = DfDt( self, t, x )
      res = zeros(2,1);
    end
    function res = exact( self, t0, x0, t )
      res = []; % no exact solution known
    end
  end
end
```

### Instantiate the ODE

Having `Pendulum2EQ.m` now can instantiate the ODE

```matlab
% load the Pendulum model in the variable ode
ell     = 2;
gravity = 9.81;
ode     = Pendulum2EQ( ell, gravity );
```

### Choose solver

Choose `ExplicitEuler` as solver and attach the
instantiated ode to it.

```matlab
solver = ExplicitEuler(); % initialize solver
solver.setODE(ode);       % Attach ode to the solver
```

### Integrate

Select the range and the sam pling point for the numerical solution

```matlab
Tmax = 5;
h    = 0.05;
tt   = 0:h:Tmax;
```
setup initial condition

```matlab
theta0  = pi/6;
omega0  = 0;
ini     = [theta0;omega0];
```

compute numerical solution

```matlab
sol = solver.advance( tt, ini );
```

now the matrix ``sol`` contain the solution.
The first column contain \(\theta\) the second column
contains  \(\omega\).

### Extract solution

```matlab
theta = sol(1,:);
omega = sol(2,:);
x = ell*sin(theta);
y = -ell*cos(theta);
```

### Plot the solution

```matlab
% sample a circle and plot (the constraint) 
xx = ell*cos(0:pi/100:2*pi);
yy = ell*sin(0:pi/100:2*pi);
plot( xx, yy, '-r', 'Linewidth', 1 );
hold on
axis equal
plot( x, y, '-o', 'MarkerSize', 6, 'Linewidth', 2, 'Color', 'blue' );
title('x,y');
```

![fig1](./images/fig1.jpg)

```matlab
plot( tt, theta, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
legend('Explicit Euler');
title('theta');
```

![fig2](./images/fig2.jpg)

```matlab
plot( tt, omega, '-o', 'MarkerSize', 6, 'Linewidth', 2 );
hold on;
legend('Explicit Euler');
title('omega');
```

![fig3](./images/fig3.jpg)
