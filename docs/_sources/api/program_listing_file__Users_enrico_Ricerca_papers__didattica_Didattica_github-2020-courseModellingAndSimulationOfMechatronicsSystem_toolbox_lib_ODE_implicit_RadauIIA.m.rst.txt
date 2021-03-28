
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_implicit_RadauIIA.m:

Program Listing for File RadauIIA.m
===================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_implicit_RadauIIA.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE/implicit/RadauIIA.m``)

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
   classdef RadauIIA < ODEbaseSolverRKimplicit
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % RadauIIA
       %
       % 1/3 | 5/12 -1/12
       %   1 |  3/4   1/4
       % ----+-----------
       %     |  3/4   1/4
       %
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function self = RadauIIA()
         self@ODEbaseSolverRKimplicit('RadauIIA',...
            [5/12,-1/12;3/4,1/4],[3/4,1/4],[1/3;1]...
         );
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   end
