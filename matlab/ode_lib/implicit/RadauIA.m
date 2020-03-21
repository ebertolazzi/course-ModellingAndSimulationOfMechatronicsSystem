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
classdef RadauIA < ODEbaseSolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % RadauIA
    %
    % 0   | 1/4  1/4
    % 2/3 | 1/4 4/12
    % ----+---------
    %     | 1/4  3/4
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = RadauIA()
      self@ODEbaseSolverRKimplicit('RadauIA',...
        [1/4,1/4;1/4,4/12],[1/4,3/4],[0;2/3]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
