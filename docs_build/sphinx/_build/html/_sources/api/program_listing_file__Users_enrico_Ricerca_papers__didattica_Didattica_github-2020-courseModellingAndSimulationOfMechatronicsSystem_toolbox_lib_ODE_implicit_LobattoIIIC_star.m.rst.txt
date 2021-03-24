
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_implicit_LobattoIIIC_star.m:

Program Listing for File LobattoIIIC_star.m
===========================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_implicit_LobattoIIIC_star.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE/implicit/LobattoIIIC_star.m``)

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
   classdef LobattoIIIC_star < ODEbaseSolverRKimplicit
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Lobatto IIIC_star tableau
       %
       % 0   | 0   0   0
       % 1/2 | 1/4 1/4 0
       % 1   | 0   1   0
       % ----+------------
       %     | 1/6 2/3 1/6
       %
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function self = LobattoIIIC_star()
         self@ODEbaseSolverRKimplicit('LobattoIIIC_star',...
           [0,0,0;1/4,1/4,0;0,1,0],...
           [1/6,2/3,1/6],[0;1/2;1]...
         );
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   end
