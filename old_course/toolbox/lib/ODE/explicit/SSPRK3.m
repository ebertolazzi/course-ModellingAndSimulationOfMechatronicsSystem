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
classdef SSPRK3 < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Third-order Strong Stability Preserving Runge-Kutta (SSPRK3)
    %
    % 0   | 0   0   0
    % 1   | 1   0   0
    % 1/2 | 1/4 1/4 0
    % ----+------------
    %     | 1/6 1/6 2/3
    %
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccc}
    %>       0   & 0   & 0   & 0 \\
    %>       1   & 1   & 0   & 0 \\
    %>       1/2 & 1/4 & 1/4 & 0 \\
    %>     \hline
    %>        & 1/6 & 1/6 & 2/3
    %>    \end{array}
    %>
    %> \endrst
    function self = SSPRK3( )
      self@DAC_ODEsolverRKexplicit('SSPRK3',...
         [0,0,0;1,0,0;1/4,1/4,0],[1/6,1/6,2/3],[0,1,1/2]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
