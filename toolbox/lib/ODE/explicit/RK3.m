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
classdef RK3 < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Third-order Runge-Kutta's method (RK3)
    %>
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccc}
    %>       0   & 0   & 0 & 0 \\
    %>       1/2 & 1/2 & 0 & 0 \\
    %>        1  & -1  & 2 & 0 \\
    %>     \hline
    %>        & 1/6 & 2/3 & 1/6
    %>    \end{array}
    %>
    %> \endrst
    function self = RK3( )
      self@DAC_ODEsolverRKexplicit('RK3',...
         [0,0,0;1/2,0,0;-1,2,0],[1/6,2/3,1/6],[0,1/2,1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
