
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_DAE_DAE3baseClass.m:

Program Listing for File DAE3baseClass.m
========================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_DAE_DAE3baseClass.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/DAE/DAE3baseClass.m``)

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
   classdef DAE3baseClass < handle
     properties (SetAccess = protected, Hidden = true)
       name;
       npv; % number of position/velocity coordinates
       nc;  % number of constraints
     end
   
     methods (Abstract)
       %
       %  Abstract functions defining an index-3 DAE
       %
       %  q' = v
       %  M(t,p) v' + Phi_p(t,q)^T lambda = f( t, q, v )
       %  Phi(t,q) = 0
       %
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       M( self, t, q )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function Phi(t,q)
       Phi( self, t, q )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function Phi(t,q)
       dPhiDt( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       Phi_q( self, t, q )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       f( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % d Phi(t,q) / dt     = Phi_q(t,q) v
       % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - B(t,q,v)
       B( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   
     methods
       function self = DAE3baseClass( name, npv, nc )
         self.name = name;
         self.npv  = npv;
         self.nc   = nc;
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function [n,m] = getDim( self )
         n = self.npv; % number of position/velocity coordinates
         m = self.nc;  % number of constraints
       end
     end
   end
