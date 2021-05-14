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
classdef LobattoIIIC < DAC_ODEsolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Lobatto IIIC
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccc}
    %>       0   & 1/6 & -1/3 & 1/6  \\
    %>       1/2 & 1/6 & 5/12 & -1/12 \\
    %>       1   & 1/6 & 2/3  &  1/6  \\
    %>     \hline
    %>           & 1/6 & 2/3 & 1/6
    %>    \end{array}
    %>
    %> \endrst
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = LobattoIIIC()
      self@DAC_ODEsolverRKimplicit('LobattoIIIC',...
        [ 1/6, -1/3,   1/6;  ...
          1/6, 5/12, -1/12; ...
          1/6, 2/3,   1/6], ...
        [1/6,2/3,1/6],      ...
        [0;1/2;1]           ...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
