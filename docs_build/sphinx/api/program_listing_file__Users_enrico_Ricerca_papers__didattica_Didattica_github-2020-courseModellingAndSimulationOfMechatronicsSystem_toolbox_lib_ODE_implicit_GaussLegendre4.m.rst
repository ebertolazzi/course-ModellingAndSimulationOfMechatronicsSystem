
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_implicit_GaussLegendre4.m:

Program Listing for File GaussLegendre4.m
=========================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_implicit_GaussLegendre4.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE/implicit/GaussLegendre4.m``)

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
   classdef GaussLegendre4 < ODEbaseSolverRKimplicit
     methods
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       % Gauss–Legendre 4th order
       %
       % t = sqrt(3)/6
       %
       % 1/2-t | 1/4   1/4-t
       % 1/2+t | 1/4+t 1/4
       % ------+-------------
       %       | 1/2   1/2
       %
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function self = GaussLegendre4()
         t = sqrt(3)/6;
         self@ODEbaseSolverRKimplicit('GaussLegendre4',...
         [1/4,1/4-t;1/4+t,1/4],[1/2,1/2],[1/2-t,1/2+t]);
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   end
