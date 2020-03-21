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
classdef Ralston < ODEbaseSolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Ralston tableau
    % (RK with minimal local truncation error)
    %   0 | 0    0
    % 2/3 | 2/3  0
    % ----+-------
    %     | 1/4 3/4
    %
    function self = Ralston( )
      self@ODEbaseSolverRKexplicit('Ralston',[0,0;2/3,0],[1/4,3/4],[0,2/3]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
