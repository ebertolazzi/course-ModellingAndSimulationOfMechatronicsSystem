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
classdef Collatz < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Collatz method
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|cc}
    %>       0 & 0   & 0 \\
    %>     1/2 & 1/2 & 0 \\
    %>     \hline
    %>         & 0   & 1
    %>    \end{array}
    %>
    %> \endrst
    function self = Collatz()
      self@DAC_ODEsolverRKexplicit('Collatz',[0,0;1/2,0],[0,1],[0,1/2]);
    end
  end
end
