%
% Matlab code for the Course:
%
%     Modelling and Simulation Mechatronics System
%
% by
% Enrico Bertolazzi
% Dipartimento di Ingegneria Industriale
% Universita` degli Studi di Trento
% email: enrico.bertolazzi@unitn.it
%
classdef ODEbaseSolver < handle
  properties (SetAccess = protected, Hidden = true)
    solverName; % should contain the name of the numerical method used
    odeClass;   % the object storing the ODE
  end

  methods (Abstract)
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  step is a generic advancing step for a generic numerical methods
    %
    %  given x0 = x(t0) return the approximation of x(t0+dt)
    %
    step( self, x0, t0, dt )
  end

  methods
    function self = ODEbaseSolver( solverName )
      self.solverName = solverName;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function name = getName( self )
      name = self.solverName
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function setODE( self, odeClass )
      self.odeClass = odeClass;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  compute approximate solution on a series of point given by the vector t
    %  starting at initial point x0
    %
    function x = advance( self, t, x0 )
      x      = zeros(length(x0),length(t));
      x(:,1) = x0(:);
      for k=1:length(t)-1
        x(:,k+1) = self.step( t(k), x(:,k), t(k+1)-t(k) );
      end
    end
  end
end
