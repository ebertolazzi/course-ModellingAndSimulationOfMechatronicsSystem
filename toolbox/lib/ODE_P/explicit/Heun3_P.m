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
classdef Heun3_P < ODEbaseSolverRKexplicit_P
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
    function self = Heun3_P( )
      self@ODEbaseSolverRKexplicit_P('Heun3_P',...
         [0,0,0;1/3,0,0;0,2/3,0],[1/4,0,3/4],[0,1/3,2/3]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
