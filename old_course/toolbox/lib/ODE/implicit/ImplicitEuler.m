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
classdef ImplicitEuler < DAC_ODEsolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Implicit Euler
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|c}
    %>       1 & 1 \\
    %>     \hline
    %>         & 1
    %>    \end{array}
    %>
    %> \endrst
    function self = ImplicitEuler()
      self@DAC_ODEsolverRKimplicit('ImplicitEuler',1,1,1);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
