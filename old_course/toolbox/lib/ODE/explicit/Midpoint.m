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
classdef Midpoint < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Midpoint method tableau
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|cc}
    %>       0   & 0   & 0 \\
    %>       1/2 & 1/2 & 0 \\
    %>     \hline
    %>        & 0 & 1
    %>    \end{array}
    %>
    %> \endrst
    function self = Midpoint( )
      self@DAC_ODEsolverRKexplicit('Midpoint',[0,0;1/2,0],[0,1],[0,1/2]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
