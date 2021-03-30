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
classdef GaussLegendre6 < DAC_ODEsolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Gauss–Legendre 6th order
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccc}
    %>       1/2-t & w     & z-t & w-t/3\\
    %>       1/2   & w+r   & z   & w-r \\
    %>       1/2+t & w+t/3 & z+t & w \\
    %>     \hline
    %>        & 5/18 & 4/9 & 5/18
    %>    \end{array}
    %>    \quad t = \displaystyle\frac{\sqrt{15}}{10}
    %>    \quad r = \displaystyle\frac{\sqrt{15}}{24}
    %>    \quad w = \displaystyle\frac{5}{36}
    %>    \quad z = \displaystyle\frac{2}{9}
    %>
    %> \endrst
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = GaussLegendre6()
      t  = sqrt(15)/10;
      tt = sqrt(15)/24;
      w  = 5/36;
      z  = 2/9;
      self@DAC_ODEsolverRKimplicit('GaussLegendre6',...
        [w,z-t,w-t/3;w+tt,z,w-tt;w+t/3,z+t,w],...
        [5/18,4/9,5/18],[1/2-t,1/2,1/2+t]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
