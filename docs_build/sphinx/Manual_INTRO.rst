Introduction
============

Library for the course *Mechatronics System Simulation*

Installation
------------

Download the toolbox from
`here <https://github.com/ebertolazzi/course-ModellingAndSimulationOfMechatronicsSystem/releases>`__
and follows the instruction.

Library structure
-----------------

- **DIAL_ODEsystem**
  base class to define the system of Ordinary Differential Equations (ODEs) to be integrated.
- **DIAL_ODEsolver**
  base class to define the solver for the system of ODEs.
- **DIAL_RKexplicit**
  base class to define the explicit Runge-Kutta solver.

  .. list-table:: Available explicit solvers
    :width: 80%

    * - *ExplicitEuler*
      - *ExplicitMidpoint*
      - *Collatz*
      - *Heun2*
    * - *Heun3*
      - *Ralston2*
      - *Ralston3*
      - *Ralston4*
    * - *RK3*
      - *RK4*
      - *RK38*
      - *SSPRK3*

- **DIAL_RKimplicit**
    base class to define the miplicit Runge-Kutta solver.

  .. list-table:: Available implicit solvers
    :width: 80%

    * - *CrankNicolson*
      - *GaussLegendre2*
      - *GaussLegendre4*
      - *GaussLegendre6*
    * - *ImplicitEuler*
      - *ImplicitMidpoint*
      - *LobattoIIIA2*
      - *LobattoIIIA4*
    * - *LobattoIIIB2*
      - *LobattoIIIB4*
      - *LobattoIIIC2*
      - *LobattoIIIC4*
    * - *LobattoIIICS2*
      - *LobattoIIICS4*
      - *LobattoIIID2*
      - *LobattoIIID4*
    * - *RadauIA3*
      - *RadauIA5*
      - *RadauIIA3*
      - *RadauIIA5*


