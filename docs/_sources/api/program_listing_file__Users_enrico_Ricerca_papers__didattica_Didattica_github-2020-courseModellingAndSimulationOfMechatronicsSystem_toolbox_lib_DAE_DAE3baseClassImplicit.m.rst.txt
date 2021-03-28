
.. _program_listing_file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_DAE_DAE3baseClassImplicit.m:

Program Listing for File DAE3baseClassImplicit.m
================================================

|exhale_lsh| :ref:`Return to documentation for file <file__Users_enrico_Ricerca_papers__didattica_Didattica_github-2020-courseModellingAndSimulationOfMechatronicsSystem_toolbox_lib_DAE_DAE3baseClassImplicit.m>` (``/Users/enrico/Ricerca/papers/_didattica/Didattica/github-2020-courseModellingAndSimulationOfMechatronicsSystem/toolbox/lib/DAE/DAE3baseClassImplicit.m``)

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
   classdef DAE3baseClassImplicit < ODEbaseClass
     properties (SetAccess = protected, Hidden = true)
       npv; % number of position/velocity coordinates
       nc;  % number of constraints
     end
   
     methods (Abstract)
       %
       %  Abstract functions defining an index-3 DAE with some derivatives
       %
       %  q' = v
       %  M(t,p) v' + Phi_p(t,q)^T lambda = gforce( t, q, v )
       %  Phi(t,q) = 0
       %
       %  d Phi(t,q) / dt     = A(t,q,v)
       %  d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v - b(t,q,v)
       %
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       M( self, t, q )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function Phi(t,q)
       Phi( self, t, q )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial Phi(t,q) / \partial t
       Phi_t( self, t, q )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial Phi(t,q) / \partial q
       Phi_q( self, t, q )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial Phi_q(t,q)*v / \partial q
       PhiV_q( self, t, q, v_dot )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial Phi_q(t,q)^T*lambda / \partial q
       PhiL_q( self, t, q, lambda )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial ( M(t,q) v_dot ) / \partial q
       W_q( self, t, q, v_dot )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       gforce( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial f( t, q, v ) / \partial q
       gforce_q( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial f( t, q, v ) / \partial v
       gforce_v( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % d Phi(t,q) / dt     = Phi_q(t,q) v
       % d^2 Phi(t,q) / dt^2 = Phi_q(t,q) v' - b(t,q,v)
       b( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial b( t, q, v ) / \partial q
       b_q( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       % return function \partial b( t, q, v ) / \partial q
       b_v( self, t, q, v )
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   
     methods
       function self = DAE3baseClassImplicit( name, npv, nc )
         self@ODEbaseClass(name);
         self.npv = npv;
         self.nc  = nc;
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function delete( self )
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function [n,m] = getDim( self )
         n = self.npv; % number of position/velocity coordinates
         m = self.nc;  % number of constraints
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       function res = f( self, t, x )
         n  = self.npv;
         m  = self.nc;
         q  = x(1:n);
         v  = x(n+1:2*n);
         M  = self.M( t, q );
         Fq = self.Phi_q( t, q );
         f  = self.gforce( t, q, v );
         b  = self.b( t, q, v );
   
         MM    = [ M, Fq.'; Fq, zeros(m,m) ];
         vl    = MM \ [ f; b];
         v_dot = vl(1:n);
   
         res   = [ v; v_dot ];
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       %  return jacobian Df( t, x ) / Dx
       %
       function res = DfDx( self, t, x )
         n  = self.npv;
         m  = self.nc;
         q  = x(1:n);
         v  = x(n+1:2*n);
         M  = self.M( t, q );
         Fq = self.Phi_q( t, q );
         f  = self.gforce( t, q, v );
         b  = self.b( t, q, v );
   
         MM         = [ M, Fq.'; Fq, zeros(m,m) ];
         vl         = MM \ [ f; b];
         v_dot      = vl(1:n);
         lambda_dot = vl(n+1:end);
   
         aa    = self.gforce_t( t, q, v ) - self.W_t( t, q, v_dot ) - self.Phi_qt( t, q, lambda_dot );
         bb    = self.b_t( t, q, v ) - self.Phi_qt( t, q, v_dot );
         col_q = MM \ [ aa; bb ];
         col_v = MM \ [ self.gforce_v( t, q, v ); self.b_v( t, q, v ) ];
   
         res = [ zeros(n,n), eye(n); col_q(1:n,:), col_v(1:n,:) ];
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       %  return jacobian Df( t, x ) / Dt
       %
       function res = DfDt( self, t, x )
         n  = self.npv;
         m  = self.nc;
         q  = x(1:n);
         v  = x(n+1:2*n);
         M  = self.M( t, q );
         Fq = self.Phi_q( t, q );
         f  = self.gforce( t, q, v );
         b  = self.b( t, q, v );
   
         MM = [ M, Fq.'; Fq, zeros(m,m) ];
         vl = MM \ [ f; b];
         v_dot      = vl(1:n);
         lambda_dot = vl(n+1:end);
   
         aa    = self.gforce_t( t, q, v ) - self.W_t( t, q, v_dot ) - self.Phi_qt( t, q, lambda_dot );
         bb    = self.b_t( t, q, v ) - self.Phi_qt( t, q, v_dot );
         col_t = MM \ [ aa; bb ];
   
         res = [ zeros(n,1); col_t(1:n,:) ];
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
       %
       %  return exact solution x(t) such that x(t0) = x0
       %  if exact solution is not available define the function that return NaN
       %
       function res = exact( self, t0, x0, t )
         res = NaN;
       end
       % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
     end
   end
