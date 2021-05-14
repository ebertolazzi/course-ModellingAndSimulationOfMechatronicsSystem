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
classdef RK3_8 < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> 3/8 rule
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccccc}
    %>       0     & 0    &  0  & 0 & 0 \\
    %>       1/3   & 1/3  &  0  & 0 & 0 \\
    %>       2/3   & -1/3 &  1  & 0 & 0 \\
    %>       1     & 1    & -1  & 1 & 0 \\
    %>     \hline
    %>        & 1/8 & 3/8 & 3/8 & 1/8
    %>    \end{array}
    %>
    %> \endrst
    function self = RK3_8( )
      self@DAC_ODEsolverRKexplicit('RK3_8',...
         [  0,   0, 0, 0;...
          1/3,   0, 0, 0;...
         -1/3,   1, 0, 0;...
            1,  -1, 1, 0 ],...
         [1/8,3/8,3/8,1/8],[0,1/3,2/3,1]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
