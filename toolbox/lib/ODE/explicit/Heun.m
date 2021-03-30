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
classdef Heun < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Heun's second-order method
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|cc}
    %>       0 & 0 & 0 \\
    %>       1 & 1 & 0 \\
    %>     \hline
    %>        & 1/2 & 1/2
    %>    \end{array}
    %>
    %> \endrst
    function self = Heun( )
      self@DAC_ODEsolverRKexplicit('Heun',[0,0;1,0],[1/2,1/2],[0,1]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
