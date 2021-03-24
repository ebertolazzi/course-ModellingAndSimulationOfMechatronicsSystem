
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_implicit_LobattoIIIB_P.m:

Program Listing for File LobattoIIIB_P.m
========================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_P_implicit_LobattoIIIB_P.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE_P/implicit/LobattoIIIB_P.m``)

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
   classdef LobattoIIIB_P < ODEbaseSolverRKimplicit_P
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Lobatto IIIB
       %
       % 0   | 1/6 -1/6      0
       % 1/2 | 1/6  1/3      0
       % 1   | 1/6  5/6      0
       % ----+----------------
       %     | 1/6  2/3    1/6
       %
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function self = LobattoIIIB_P()
         self@ODEbaseSolverRKimplicit_P('LobattoIIIB_P',...
           [1/6,-1/6,0;1/6,1/3,0;1/6,5/6,0],...
           [1/6,2/3,1/6],[0;1/2;1]...
         );
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   end
