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
classdef RK3_8 < ODEbaseSolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % 3/8 rule tableau
    %
    % 0   |  0   0   0   0
    % 1/3 |  1/3 0   0   0
    % 2/3 | -1/3 1   0   0
    % 1   |  1  -1   1   0
    % ----+-----------------
    %     |  1/8 3/8 3/8 1/8
    %
    function self = RK3_8( )
      self@ODEbaseSolverRKexplicit('RK3_8',...
         [  0,   0, 0, 0;...
          1/3,   0, 0, 0;...
            0,-1/3, 0, 0;...
            1,  -1, 1, 0 ],...
         [1/8,3/8,3/8,1/8],[0,1/3,2/3,1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
  end
end
