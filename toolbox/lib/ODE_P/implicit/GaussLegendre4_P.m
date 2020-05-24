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
classdef GaussLegendre4_P < ODEbaseSolverRKimplicit_P
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Gauss–Legendre 4th order
    %
    % t = sqrt(3)/6
    %
    % 1/2-t | 1/4   1/4-t
    % 1/2+t | 1/4+t 1/4
    % ------+-------------
    %       | 1/2   1/2
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = GaussLegendre4_P()
      t = sqrt(3)/6;
      self@ODEbaseSolverRKimplicit_P('GaussLegendre4_P',...
      [1/4,1/4-t;1/4+t,1/4],[1/2,1/2],[1/2-t,1/2+t]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
