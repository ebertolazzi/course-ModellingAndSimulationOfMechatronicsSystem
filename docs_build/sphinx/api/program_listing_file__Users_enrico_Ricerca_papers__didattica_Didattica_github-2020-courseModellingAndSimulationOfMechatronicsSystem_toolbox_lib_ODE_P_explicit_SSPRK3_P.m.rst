
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_explicit_SSPRK3_P.m:

Program Listing for File SSPRK3_P.m
===================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_explicit_SSPRK3_P.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE_P/explicit/SSPRK3_P.m``)

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
   classdef SSPRK3_P < ODEbaseSolverRKexplicit_P
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Third-order Strong Stability Preserving Runge-Kutta (SSPRK3)
       %
       % 0   | 0   0   0
       % 1   | 1   0   0
       % 1/2 | 1/4 1/4 0
       % ----+------------
       %     | 1/6 1/6 2/3
       %
       function self = SSPRK3_P( )
         self@ODEbaseSolverRKexplicit_P('SSPRK3_P',...
            [0,0,0;1,0,0;1/4,1/4,0],[1/6,1/6,2/3],[0,1,1/2]...
         );
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
     end
   end
