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
classdef Ralston4_P < ODEbaseSolverRKexplicit_P
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Ralston's fourth-order method tableau
    %
    % 0          | 0          | 0           | 0          | 0
    % 0.4        | 0.4        | 0           | 0          | 0
    % 0.45573725 | 0.29697761 | 0.15875964  | 0          | 0
    % 1          | 0.21810040 | -3.05096516 | 3.83286476 | 0
    % -----------+---------------------------------------------------
    %            | 0.17476028 | -0.55148066 | 1.20553560 | 0.17118478
    %
    function self = Ralston4_P( )
      self@ODEbaseSolverRKexplicit_P('Ralston4_P',...
         [ 0,          0,            0,          0;...
           0.4,        0,            0,          0;...
           0.29697761, 0.15875964,   0,          0;...
           0.21810040, -3.05096516,  3.83286476, 0 ],...
         [ 0.17476028 , -0.55148066, 1.20553560, 0.17118478 ],...
         [ 0,           0.4,         0.45573725, 1 ]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
