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
classdef ExplicitEuler < DAC_ODEsolverRKexplicit

  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Explicit Euler
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|c}
    %>       0 & 0 \\
    %>     \hline
    %>         &  1
    %>    \end{array}
    %>
    %> \endrst
    function self = ExplicitEuler( )
      self@DAC_ODEsolverRKexplicit( 'ExplicitEuler', 1, 1, 0 );
    end
  end

end
