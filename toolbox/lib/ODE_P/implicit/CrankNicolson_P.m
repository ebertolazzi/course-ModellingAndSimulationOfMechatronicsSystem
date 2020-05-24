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
classdef CrankNicolson_P < ODEbaseSolverRKimplicit_P
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Crank Nicolson tableau
    %
    % 0 | 0   0
    % 1 | 1/2 1/2
    % --+-------
    %   | 1/2 1/2
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = CrankNicolson_P()
      self@ODEbaseSolverRKimplicit_P('CrankNicolson_P',[0,0;1/2,1/2],[1/2,1/2],[0;1]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
