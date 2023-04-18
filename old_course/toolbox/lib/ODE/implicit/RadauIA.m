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
classdef RadauIA < DAC_ODEsolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> RadauIA (2 stage order 3)
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|cc}
    %>       0   & 1/4 & -1/4 \\
    %>       2/3 & 1/4 & 5/12   \\
    %>     \hline
    %>           & 1/4 & 3/4
    %>    \end{array}
    %>
    %> \endrst
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = RadauIA()
      self@DAC_ODEsolverRKimplicit('RadauIA',...
        [1/4,-1/4;1/4,5/12],[1/4,3/4],[0;2/3]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
