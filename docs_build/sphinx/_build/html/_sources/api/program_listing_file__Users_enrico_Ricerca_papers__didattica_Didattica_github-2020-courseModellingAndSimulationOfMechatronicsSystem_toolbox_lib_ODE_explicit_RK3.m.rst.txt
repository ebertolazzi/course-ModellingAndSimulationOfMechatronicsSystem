
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_explicit_RK3.m:

Program Listing for File RK3.m
==============================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_explicit_RK3.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE/explicit/RK3.m``)

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
   classdef RK3 < ODEbaseSolverRKexplicit
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Third-order Runge-Kutta's method (RK3) tableau
       %
       % 0   | 0   0   0
       % 1/2 | 1/2 0   0
       % 1   | -1  2   0
       % ----+------------
       %     | 1/4 4/6 1/6
       %
       function self = RK3( )
         self@ODEbaseSolverRKexplicit('RK3',...
            [0,0,0;1/2,0,0;-1,2,0],[1/6,2/3,1/6],[0,1/2,1]...
         );
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
     end
   end
