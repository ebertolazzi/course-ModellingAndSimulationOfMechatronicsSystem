
ODE/DAE library
===============

Library use to test numerical solver for ODE and DAE for the course ...


ODE solver
----------

- **ODEbaseClass**
  base class to define the Ordinary Differential equation to be integrated
- **ODEbaseSolver**
  base class to define the solver for ODE
- **ODEbaseSolverRKexplicit**
  base class to define the explicit Runge Kutta solver.
  A list of already implemented available in the library is the following:
  - *ExplicitEuler*
  - *MidPoint*
  - *Collatz*
  - *Heun*
  - *Heun3*
  - *Ralston*
  - *Ralston3*
  - *Ralston4*
  - *RK3_8*
  - *RK3*
  - *RK4*
  - *SSPRK3*
- **ODEbaseSolverRKimplicit**
  - *ImplicitEuler*
  - *CrankNicolson*
  - *GaussLegendre4*
  - *GaussLegendre6*
  - *LobattoIIIA*
  - *LobattoIIIB*
  - *LobattoIIIC*
  - *LobattoIIIC_star*
  - *RadauIA*
  - *RadauIIA*


DAE solver (projection based)
-----------------------------

The same classes with _P at the end are the

- **ODEbaseClass_P**
   class to define the ODE with hidden constraints (invariants)

- **ODEbaseSolver_P**
  base class to define the solver for ODE with hidden constraints (invariants)

- **ODEbaseSolverRKexplicit_P**
  
  base class to define the explicit Runge Kutta solver with projection to the hidden constraints. 
  A list of already implemented available in the library is the following:
  
  - *ExplicitEuler_P*
  - *MidPoint_P*
  - *Collatz_P*
  - *Heun_P*
  - *Heun3_P*
  - *Ralston_P*
  - *Ralston3_P*
  - *Ralston4_P*
  - *RK3_8_P*
  - *RK3_P*
  - *RK4_P*
  - *SSPRK3_P*
  
- **ODEbaseSolverRKimplicit_P**
  
  - *ImplicitEuler_P*
  - *CrankNicolson_P*
  - *GaussLegendre4_P*
  - *GaussLegendre6_P*
  - *LobattoIIIA_P*
  - *LobattoIIIB_P*
  - *LobattoIIIC_P*
  - *LobattoIIIC_star_P*
  - *RadauIA_P*
  - *RadauIIA_P*

Installation mex/MATLAB interface
---------------------------------

Download the toolbox at the link

- [https://github.com/ebertolazzi/course-ModellingAndSimulationOfMechatronicsSystem/releases]
(https://github.com/ebertolazzi/course-ModellingAndSimulationOfMechatronicsSystem/releases)

and follows the instruction.

Author
------

    Enrico Bertolazzi (<enrico.bertolazzi@unitn.it>)
    Department of Industrial Engineering  
    University of Trento

References
----------

1. *Claus Bendtsen, Per Grove Thomsen*,
   **Numerical Solution of Differential Algebraic Equations**,  
   Technical report IMM-REP-1999-8,  
   [https://scholar.google.it/citations?user=P1s91j0AAAAJ&hl=en&oi=sra]
   (https://scholar.google.it/citations?user=P1s91j0AAAAJ&hl=en&oi=sra)

2. *John C.Butcher*,  
   **Introduction to Runge–Kutta methods**  
   [https://www.math.auckland.ac.nz/~butcher/ODE-book-2008/Tutorials/RK-methods.pdf](https://www.math.auckland.ac.nz/~butcher/ODE-book-2008/Tutorials/RK-methods.pdf)

3. *John C.Butcher*,
   **The Numerical Analysis of Ordinary Differential Differential Equations: Runge-Kutta and General Linear Methods**
   Wiley, Chichester (1964)
   [https://doi.org/10.1137/1031147](https://doi.org/10.1137/1031147)

4. *E. Hairer, G. Wanner*,  
   **Solving Ordinary Differential Equations II: Stiff and Differential-Algebraic Problems**,
   Springer, Berlin (1991)
   [https://www.springer.com/gp/book/9783540604525](https://www.springer.com/gp/book/9783540604525)
