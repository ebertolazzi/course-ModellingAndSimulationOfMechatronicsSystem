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
classdef ExplicitEuler < ODEbaseSolverRKexplicit

  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % Explicit Euler tableau
    %
    % 0 | 0
    % --+---
    %   | 1
    %
    function self = ExplicitEuler( )
      self@ODEbaseSolverRKexplicit( 'ExplicitEuler', 1, 1, 0 );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end

end
