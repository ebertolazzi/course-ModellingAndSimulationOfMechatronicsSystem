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
classdef Midpoint_P < ODEbaseSolverRKexplicit_P
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Midpoint method tableau
    %
    % 0   | 0   0
    % 1/2 | 1/2 0
    % ----+------
    %     | 0   1
    %
    function self = Midpoint_P( )
      self@ODEbaseSolverRKexplicit_P('Midpoint_P',[0,0;1/2,0],[0,1],[0,1/2]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end

end
