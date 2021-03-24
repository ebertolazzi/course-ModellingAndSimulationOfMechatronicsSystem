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
classdef Heun < ODEbaseSolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Heun's second-order method tableau
    %
    % 0 | 0   0
    % 1 | 1   0
    % --+-------
    %   | 1/2 1/2
    %
    function self = Heun( )
      self@ODEbaseSolverRKexplicit('Heun',[0,0;1,0],[1/2,1/2],[0,1]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
