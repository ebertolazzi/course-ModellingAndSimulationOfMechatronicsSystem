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
classdef Ralston < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Ralston (RK with minimal local truncation error)
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|cc}
    %>       0   & 0   & 0 \\
    %>       2/3 & 2/3 & 0 \\
    %>     \hline
    %>        & 1/4 & 3/4
    %>    \end{array}
    %>
    %> \endrst
    function self = Ralston( )
      self@DAC_ODEsolverRKexplicit('Ralston',[0,0;2/3,0],[1/4,3/4],[0,2/3]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
