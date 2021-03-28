
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_explicit_Heun3_P.m:

Program Listing for File Heun3_P.m
==================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_explicit_Heun3_P.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE_P/explicit/Heun3_P.m``)

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
   classdef Heun3_P < ODEbaseSolverRKexplicit_P
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Heun's third-order method tableau
       %
       % 0   | 0   0   0
       % 1/3 | 1/3 0   0
       % 2/3 | 0   2/3 0
       % ----+------------
       %     | 1/4 0   3/4
       %
       function self = Heun3_P( )
         self@ODEbaseSolverRKexplicit_P('Heun3_P',...
            [0,0,0;1/3,0,0;0,2/3,0],[1/4,0,3/4],[0,1/3,2/3]...
         );
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
     end
   end
