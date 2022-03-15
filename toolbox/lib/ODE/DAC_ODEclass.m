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
%>
%> ODE base class describing an ODE
%>
%> *Usage*
%>
%> \rst
%>
%> .. code-block:: matlab
%>
%>      ode = ODE_derived_class() % create an instance of a ODE
%>      res = ode.f(t,x);
%>
%> \endrst
%>
classdef DAC_ODEclass < DAC_base_class
  % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  methods (Abstract)
    %>
    %> Abstract functions defining and ODE
    %>
    %> \f[ \mathbf{x}' = \mathbf{f}( t, \mathbf{x} ) \quad\oplus\quad [\textrm{invariants}] \f]
    %>
    %> invariants are of the form
    %>
    %> \f[ \mathbf{h}( t, \mathbf{x} ) = \mathbf{0} \f]
    %>
    %> The derived function must define the r.h.s. of the ODE
    %> \f$ \mathbf{f}( t, \mathbf{x} ) \f$ where
    %> \f$ \mathbf{x} \f$ are the states of the model described by the ODE.
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    f( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> The derived function must return
    %> the jacobian of the r.h.s. of the ODE:
    %>
    %> \f[ \partial \mathbf{f}( t, \mathbf{x} ) / \partial \mathbf{x} \f]
    %>
    %> Used only in implicit methods
    %>
    DfDx( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %> The invariant/hidden constraints
    %> \f$ \mathbf{h}( t, \mathbf{x} ) = \mathbf{0} \f$
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    h( self, t, x )
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> The derived function must return
    %> the jacobian of the hidden constraints of the ODE:
    %>
    %> \f[ \partial \mathbf{h}( t, \mathbf{x} ) / \partial \mathbf{x} \f]
    %>
    %> Used only in projection method
    %>
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    DhDx( self, t, x )
  end
  % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  methods
    function self = DAC_ODEclass( name, neq, ninv )
      self@DAC_base_class( name, neq, ninv )
    end
  end
end
