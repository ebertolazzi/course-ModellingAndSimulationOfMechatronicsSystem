
Introduction
============

Library for the course ....

Installation
------------

Download the toolbox from
`here <https://github.com/ebertolazzi/course-ModellingAndSimulationOfMechatronicsSystem/releases>`__
and follows the instruction.

ODE solvers
-----------

- **ODEbaseClass**
  base class to define the Ordinary Differential equation to be integrated
- **ODEbaseSolver**
  base class to define the solver for ODE
- **ODEbaseSolverRKexplicit**
  base class to define the explicit Runge Kutta solver.
  A list of already implemented available in the library is the following:

  .. list-table:: Available explicit solvers

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

- **ODEbaseSolverRKimplicit**

  .. list-table:: Available implicit solvers

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


DAE solvers (projection based)
------------------------------

The same classes with _P at the end are the

- **ODEbaseClass_P**
   class to define the ODE with hidden constraints (invariants)

- **ODEbaseSolver_P**
  base class to define the solver for ODE with hidden constraints (invariants)

- **ODEbaseSolverRKexplicit_P**

  base class to define the explicit Runge Kutta solver with projection to the hidden constraints.
  A list of already implemented available in the library is the following:

  .. list-table:: Available explicit solvers

    * - *ExplicitEuler_P*
      - *MidPoint_P*
      - *Collatz_P*
    * - *Heun_P*
      - *Heun3_P*
      -
    * - *Ralston_P*
      - *Ralston3_P*
      - *Ralston4_P*
    * - *RK3_8_P*
      - *RK3_P*
      - *RK4_P*
    * - *SSPRK3_P*
      -
      -

- **ODEbaseSolverRKimplicit_P**


  .. list-table:: Available implicit solvers

    * - *ImplicitEuler_P*
      - *CrankNicolson_P*
    * - *GaussLegendre4_P*
      - *GaussLegendre6_P*
    * - *LobattoIIIA_P*
      - *LobattoIIIB_P*
    * - *LobattoIIIC_P*
      - *LobattoIIIC_star_P*
    * - *RadauIA_P*
      - *RadauIIA_P*
