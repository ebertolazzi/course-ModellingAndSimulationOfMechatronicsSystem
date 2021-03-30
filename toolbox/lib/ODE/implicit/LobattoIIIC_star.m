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
classdef LobattoIIIC_star < DAC_ODEsolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Lobatto IIIC_star tableau
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccc}
    %>       0   & 0   & 0   & 0  \\
    %>       1/2 & 1/4 & 1/4 & 0 \\
    %>       1   & 0   & 1   & 0 \\
    %>     \hline
    %>        & 1/6 & 2/3 & 1/6
    %>    \end{array}
    %>
    %> \endrst
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = LobattoIIIC_star()
      self@DAC_ODEsolverRKimplicit('LobattoIIIC_star',...
        [0,0,0;1/4,1/4,0;0,1,0],...
        [1/6,2/3,1/6],[0;1/2;1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
