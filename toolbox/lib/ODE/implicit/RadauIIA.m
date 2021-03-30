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
classdef RadauIIA < DAC_ODEsolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> RadauIIA
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|cc}
    %>       1/3 & 5/12/4 & -1/12 \\
    %>         1 &    3/4 &  1/4  \\
    %>     \hline
    %>           & 3/4 & 1/4
    %>    \end{array}
    %>
    %> \endrst
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = RadauIIA()
      self@DAC_ODEsolverRKimplicit('RadauIIA',...
         [5/12,-1/12;3/4,1/4],[3/4,1/4],[1/3;1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
