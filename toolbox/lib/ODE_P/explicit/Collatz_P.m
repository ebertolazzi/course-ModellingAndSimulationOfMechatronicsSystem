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
classdef Collatz_P < ODEbaseSolverRKexplicit_P
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
    function self = Collatz_P()
      self@ODEbaseSolverRKexplicit_P('Collatz_P',[0,0;1/2,0],[0,1],[0,1/2]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
