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
classdef Collatz < ODEbaseSolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Collatz tableau
    %
    % 0   | 0   0
    % 1/2 | 1/2 0
    % ----+-------
    %     | 0   1
    %
    function self = Collatz()
      self@ODEbaseSolverRKexplicit('Collatz',[0,0;1/2,0],[0,1],[0,1/2]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
