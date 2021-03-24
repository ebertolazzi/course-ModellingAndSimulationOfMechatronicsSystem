
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_ODEbaseClass.m:

Program Listing for File ODEbaseClass.m
=======================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_ODE_ODEbaseClass.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/ODE/ODEbaseClass.m``)

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
   classdef ODEbaseClass < handle
     properties (SetAccess = protected, Hidden = true)
       name;
     end
   
     methods (Abstract)
       %
       %  Abstract functions defining and ODE
       %
       %  x' = f( t, x )
       %
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       f( self, t, x )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       %  return jacobian Df( t, x ) / Dx
       %
       DfDx( self, t, x )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       %  return jacobian Df( t, x ) / Dt
       %
       DfDt( self, t, x )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       %  return exact solution x(t) such that x(t0) = x0
       %  if exact solution is not available define the function that return NaN
       %
       exact( self, t0, x0, t )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   
     methods
       function self = ODEbaseClass( name )
         self.name = name;
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
     end
   end
