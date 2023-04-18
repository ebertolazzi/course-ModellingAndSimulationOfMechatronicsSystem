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
classdef Heun3 < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Heun's third-order method
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccc}
    %>       0   & 0   & 0 & 0 \\
    %>       1/3 & 1/3 & 0 & 0 \\
    %>       2/3 & 0   & 2/3 & 0 \\
    %>     \hline
    %>        & 1/4 & 0 & 3/4
    %>    \end{array}
    %>
    %> \endrst
    function self = Heun3( )
      self@DAC_ODEsolverRKexplicit('Heun3',...
         [0,0,0;1/3,0,0;0,2/3,0],[1/4,0,3/4],[0,1/3,2/3]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
