
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_explicit_RK3_P.m:

Program Listing for File RK3_P.m
================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_explicit_RK3_P.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE_P/explicit/RK3_P.m``)

.. |exhale_lsh| unicode:: U+021B0 .. UPWARDS ARROW WITH TIP LEFTWARDS

.. code-block:: cpp

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
   classdef RK3_P < ODEbaseSolverRKexplicit_P
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Third-order Runge-Kutta's method (RK3) tableau
       %
       % 0   | 0   0   0
       % 1/3 | 1/3 0   0
       % 2/3 | 0   2/3 0
       % ----+------------
       %     | 1/4 0   3/4
       %
       function self = RK3_P( )
         self@ODEbaseSolverRKexplicit_P('RK3_P',...
            [0,0,0;1/2,0,0;-1,2,0],[1/6,2/3,1/6],[0,1/2,1]...
         );
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
     end
   end
