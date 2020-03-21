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
classdef LobattoIIIA < ODEbaseSolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Lobatto IIIA
    %
    % 0   | 0      0      0
    % 1/2 | 5/24 1/3  -1/24
    % 1   | 1/6  2/3    1/6
    % ----+----------------
    %     | 1/6  2/3    1/6
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = LobattoIIIA()
      self@ODEbaseSolverRKimplicit('LobattoIIIA',...
        [0,0,0;5/24,1/3,-1/24;1/6,2/3,1/6],...
        [1/6,2/3,1/6],[0;1/2;1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
