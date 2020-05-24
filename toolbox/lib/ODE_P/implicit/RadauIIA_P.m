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
classdef RadauIIA_P < ODEbaseSolverRKimplicit_P
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % RadauIIA
    %
    % 1/3 | 5/12 -1/12
    %   1 |  3/4   1/4
    % ----+-----------
    %     |  3/4   1/4
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = RadauIIA_P()
      self@ODEbaseSolverRKimplicit_P('RadauIIA_P',...
         [5/12,-1/12;3/4,1/4],[3/4,1/4],[1/3;1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
