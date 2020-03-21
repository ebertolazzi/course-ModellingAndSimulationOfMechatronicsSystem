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
classdef Heun3 < ODEbaseSolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Heun's third-order method tableau
    %
    % 0   | 0   0   0
    % 1/3 | 1/3 0   0
    % 2/3 | 0   2/3 0
    % ----+------------
    %     | 1/4 0   3/4
    %
    function self = Heun3( )
      self@ODEbaseSolverRKexplicit('Heun3',...
         [0,0,0;1/3,0,0;0,2/3,0],[1/4,0,3/4],[0,1/3,2/3]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
