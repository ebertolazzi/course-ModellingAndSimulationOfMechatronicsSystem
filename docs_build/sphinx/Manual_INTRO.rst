Introduction
============

Library for the course *Modelling And Simulation Of Mechatronics System*

Installation
------------

Download the toolbox from
`here <https://github.com/ebertolazzi/course-ModellingAndSimulationOfMechatronicsSystem/releases>`__
and follows the instruction.

ODE solvers
-----------

- **DAC_ODEclass**
  base class to define the Ordinary Differential equation to be integrated
- **DAC_ODEsolver**
  base class to define the solver for ODE
- **DAC_ODEsolverRKexplicit**
  base class to define the explicit Runge Kutta solver.
  A list of already implemented available in the library is the following:

  .. list-table:: Available explicit solvers
    :width: 80%

    * - *ExplicitEuler*
      - *MidPoint*
      - *Collatz*
    * - *Heun*
      - *Heun3*
      -
    * - *Ralston*
      - *Ralston3*
      - *Ralston4*
    * - *RK3_8*
      - *RK3*
      - *RK4*
    * - *SSPRK3*
      -
      -

- **DAC_ODEsolverRKimplicit**

  .. list-table:: Available implicit solvers
    :width: 80%

    * - *ImplicitEuler*
      - *CrankNicolson*
      - *GaussLegendre4*
      - *GaussLegendre6*
    * - *LobattoIIIA*
      - *LobattoIIIB*
      - *LobattoIIIC*
      - *LobattoIIIC_star*
    * - *RadauIA*
      - *RadauIIA*
      -
      -
