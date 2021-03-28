
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_explicit_Collatz_P.m:

Program Listing for File Collatz_P.m
====================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_explicit_Collatz_P.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE_P/explicit/Collatz_P.m``)

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
   classdef Collatz_P < ODEbaseSolverRKexplicit_P
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Collatz tableau
       %
       % 0   | 0   0
       % 1/2 | 1/2 0
       % ----+-------
       %     | 0   1
       %
       function self = Collatz_P()
         self@ODEbaseSolverRKexplicit_P('Collatz_P',[0,0;1/2,0],[0,1],[0,1/2]);
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
     end
   end
