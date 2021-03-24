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
classdef RK3_P < ODEbaseSolverRKexplicit_P
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Third-order Runge-Kutta's method (RK3) tableau
    %
    % 0   | 0   0   0
    % 1/3 | 1/3 0   0
    % 2/3 | 0   2/3 0
    % ----+------------
    %     | 1/4 0   3/4
    %
    function self = RK3_P( )
      self@ODEbaseSolverRKexplicit_P('RK3_P',...
         [0,0,0;1/2,0,0;-1,2,0],[1/6,2/3,1/6],[0,1/2,1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
