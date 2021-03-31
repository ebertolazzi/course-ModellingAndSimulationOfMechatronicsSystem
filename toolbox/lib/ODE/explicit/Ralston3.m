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
classdef Ralston3 < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Ralston's third-order method
    %>
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccc}
    %>       0   & 0   & 0 & 0 \\
    %>       1/2 & 1/2 & 0 & 0 \\
    %>       3/4 & 0   & 3/4 & 0 \\
    %>     \hline
    %>        & 2/9 & 1/3 & 4/9
    %>    \end{array}
    %>
    %> \endrst
    function self = Ralston3( )
      self@DAC_ODEsolverRKexplicit('Ralston3',...
         [0,0,0;1/2,0,0;0,3/4,0],[2/9,1/3,4/9],[0,1/2,3/4]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
