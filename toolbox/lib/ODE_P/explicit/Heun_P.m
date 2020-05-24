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
classdef Heun_P < ODEbaseSolverRKexplicit_P
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Heun tableau
    %
    % 0 | 0   0
    % 1 | 1   0
    % --+-------
    %   | 1/2 1/2
    %
    function self = Heun_P( )
      self@ODEbaseSolverRKexplicit_P('Heun_P',[0,0;1,0],[1/2,1/2],[0,1]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
