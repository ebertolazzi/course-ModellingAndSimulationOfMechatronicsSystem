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
classdef SSPRK3 < ODEbaseSolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Third-order Strong Stability Preserving Runge-Kutta (SSPRK3)
    %
    % 0   | 0   0   0
    % 1   | 1   0   0
    % 1/2 | 1/4 1/4 0
    % ----+------------
    %     | 1/6 1/6 2/3
    %
    function self = SSPRK3( )
      self@ODEbaseSolverRKexplicit('SSPRK3',...
         [0,0,0;1,0,0;1/4,1/4,0],[1/6,1/6,2/3],[0,1,1/2]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
