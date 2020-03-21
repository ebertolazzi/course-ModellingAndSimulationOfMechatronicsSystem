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
classdef Ralston3 < ODEbaseSolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Ralston's third-order method tableau
    %
    % 0   | 0   0   0
    % 1/2 | 1/2 0   0
    % 3/4 | 0   3/4 0
    % ----+------------
    %     | 2/9 1/3 4/9
    %
    function self = Ralston3( )
      self@ODEbaseSolverRKexplicit('Ralston3',...
         [0,0,0;1/2,0,0;0,3/4,0],[2/9,1/3,4/9],[0,1/2,3/4]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
