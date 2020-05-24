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
classdef RadauIA_P < ODEbaseSolverRKimplicit_P
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
    function self = RadauIA_P()
      self@ODEbaseSolverRKimplicit_P('RadauIA_P',...
        [1/4,1/4;1/4,4/12],[1/4,3/4],[0;2/3]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
