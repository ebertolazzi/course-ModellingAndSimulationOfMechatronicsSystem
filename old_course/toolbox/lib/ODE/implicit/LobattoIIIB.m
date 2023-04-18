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
classdef LobattoIIIB < DAC_ODEsolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Lobatto IIIB
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccc}
    %>       0   & 1/6 & -1/6 & 0  \\
    %>       1/2 & 1/6 &  1/3 & 0 \\
    %>       1   & 1/6 &  5/6 & 0 \\
    %>     \hline
    %>        & 1/6 & 2/3 & 1/6
    %>    \end{array}
    %>
    %> \endrst
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = LobattoIIIB()
      self@DAC_ODEsolverRKimplicit('LobattoIIIB',...
        [1/6,-1/6,0;1/6,1/3,0;1/6,5/6,0],...
        [1/6,2/3,1/6],[0;1/2;1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
