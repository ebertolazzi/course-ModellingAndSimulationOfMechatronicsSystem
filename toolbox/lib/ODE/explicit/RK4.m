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
classdef RK4 < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Classical fourth-order Runge-Kutta's method (RK4)
    %
    % 0   | 0   0   0   0
    % 1/2 | 1/2 0   0   0
    % 1/2 | 0   1/2 0   0
    % 1   | 0   0   1   0
    % ----+----------------
    %     | 1/6 1/3 1/3 1/6
    %
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccccc}
    %>       0   & 0   & 0   & 0 & 0 \\
    %>       1/2 & 1/2 & 0   & 0 & 0 \\
    %>       1/2 & 0   & 1/2 & 0 & 0 \\
    %>       1   & 0   &   0 & 1 & 0 \\
    %>     \hline
    %>        & 1/6 & 1/3 & 1/3 & 1/6
    %>    \end{array}
    %>
    %> \endrst
    function self = RK4( )
      self@DAC_ODEsolverRKexplicit('RK4',...
         [  0,  0, 0, 0;...
          1/2,  0, 0, 0;...
            0,1/2, 0, 0;...
            0,  0, 1, 0 ],...
         [1/6,1/3,1/3,1/6],[0,1/2,1/2,1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
