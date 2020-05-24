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
classdef ExplicitEuler_P < ODEbaseSolverRKexplicit_P

  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % Explicit Euler tableau
    %
    % 0 | 0
    % --+---
    %   | 1
    %
    function self = ExplicitEuler_P( )
      self@ODEbaseSolverRKexplicit_P( 'ExplicitEuler_P', 1, 1, 0 );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end

end
