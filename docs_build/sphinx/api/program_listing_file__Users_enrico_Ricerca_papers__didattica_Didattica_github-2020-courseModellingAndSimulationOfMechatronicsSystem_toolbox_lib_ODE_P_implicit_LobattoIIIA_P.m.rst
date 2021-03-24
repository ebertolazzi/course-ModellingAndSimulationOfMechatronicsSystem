
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_implicit_LobattoIIIA_P.m:

Program Listing for File LobattoIIIA_P.m
========================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_implicit_LobattoIIIA_P.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE_P/implicit/LobattoIIIA_P.m``)

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
   classdef LobattoIIIA_P < ODEbaseSolverRKimplicit_P
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Lobatto IIIA
       %
       % 0   | 0      0      0
       % 1/2 | 5/24 1/3  -1/24
       % 1   | 1/6  2/3    1/6
       % ----+----------------
       %     | 1/6  2/3    1/6
       %
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function self = LobattoIIIA_P()
         self@ODEbaseSolverRKimplicit_P('LobattoIIIA_P',...
           [0,0,0;5/24,1/3,-1/24;1/6,2/3,1/6],...
           [1/6,2/3,1/6],[0;1/2;1]...
         );
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   end
