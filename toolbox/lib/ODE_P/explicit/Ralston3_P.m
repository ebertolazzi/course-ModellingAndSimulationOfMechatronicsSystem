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
classdef Ralston3_P < ODEbaseSolverRKexplicit_P
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
    function self = Ralston3_P( )
      self@ODEbaseSolverRKexplicit_P('Ralston3_P',...
         [0,0,0;1/2,0,0;0,3/4,0],[2/9,1/3,4/9],[0,1/2,3/4]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
