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
classdef GaussLegendre4 < DAC_ODEsolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Gauss–Legendre 4th order
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|cc}
    %>       1/2-t & 1/4   & 1/4-t \\
    %>       1/2+t & 1/4+t & 1/4   \\
    %>     \hline
    %>             & 1/2 & 1/2
    %>    \end{array}
    %>    \qquad t = \dfrac{\sqrt{3}}{6}
    %>
    %> \endrst
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = GaussLegendre4()
      t = sqrt(3)/6;
      self@DAC_ODEsolverRKimplicit('GaussLegendre4',...
      [1/4,1/4-t;1/4+t,1/4],[1/2,1/2],[1/2-t,1/2+t]);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
