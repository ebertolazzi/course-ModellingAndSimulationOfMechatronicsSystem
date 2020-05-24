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
classdef LobattoIIIB_P < ODEbaseSolverRKimplicit_P
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Lobatto IIIB
    %
    % 0   | 1/6 -1/6      0
    % 1/2 | 1/6  1/3      0
    % 1   | 1/6  5/6      0
    % ----+----------------
    %     | 1/6  2/3    1/6
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = LobattoIIIB_P()
      self@ODEbaseSolverRKimplicit_P('LobattoIIIB_P',...
        [1/6,-1/6,0;1/6,1/3,0;1/6,5/6,0],...
        [1/6,2/3,1/6],[0;1/2;1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
