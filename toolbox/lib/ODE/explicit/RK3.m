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
classdef RK3 < ODEbaseSolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Third-order Runge-Kutta's method (RK3) tableau
    %
    % 0   | 0   0   0
    % 1/2 | 1/2 0   0
    % 1   | -1  2   0
    % ----+------------
    %     | 1/4 4/6 1/6
    %
    function self = RK3( )
      self@ODEbaseSolverRKexplicit('RK3',...
         [0,0,0;1/2,0,0;-1,2,0],[1/6,2/3,1/6],[0,1/2,1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
