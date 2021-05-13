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
classdef DAC_ODEsolver < handle
  properties (SetAccess = protected, Hidden = true)
    %>
    %> Should contain the name of the numerical method used
    %>
    solverName; 
    %>
    %> The object storing the ODE
    %>
    odeClass;
  end

  methods (Abstract)
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Generic advancing step for a generic numerical methods.
    %>
    %> given x0 = \f$ x(t_0) \f$ and a time step dt = \f$ \Delta t\f$
    %> return the approximation of \f$ x(t_0+\Delta t) \f$
    %>
    step( self, x0, t0, dt )
  end

  methods
    function self = DAC_ODEsolver( solverName )
      self.solverName = solverName;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Return the name of the numerical method used to advance solution
    %>
    function name = getName( self )
      name = self.solverName;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Set the ODE class used in the advancing step
    %>
    function setODE( self, odeClass )
      self.odeClass = odeClass;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Compute approximate solution on a series of point given by the
    %> vector `t` = \f$ (t_0, t_1, \ldots, t_n) \f$
    %> starting at initial point `x0` =  \f$ x_0 \f$
    %>
    function x = advance( self, t, x0 )
      neq = self.odeClass.getNeq();
      if neq ~= length(x0)
        error('length(x0) = %d expected %d\n',length(x0),neq);
      end
      x      = zeros(neq,length(t));
      x(:,1) = x0(:);
      pp     = 0;
      nn     = length(t)-1;
      for k=1:nn
        newpp = ceil(100*k/nn);
        if newpp > pp+4
          pp = newpp;
          fprintf('%3d%%\n',pp);
        end
        x(:,k+1) = self.step( t(k), x(:,k), t(k+1)-t(k) );
      end
    end
  end
end
