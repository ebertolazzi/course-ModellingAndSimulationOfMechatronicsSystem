% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%                                                                     %
% The DIAL project - Course of MECHATRONICS SYSTEM SIMULATION         %
%                                                                     %
% Copyright (c) 2020, Davide Stocco and Enrico Bertolazzi, Francesco  %
% Biral                                                               %
%                                                                     %
% The DIAL project and its components are supplied under the terms of %
% the open source BSD 2-Clause License. The contents of the DIAL      %
% project and its components may not be copied or disclosed except in %
% accordance with the terms of the BSD 2-Clause License.              %
%                                                                     %
% URL: https://opensource.org/licenses/BSD-2-Clause                   %
%                                                                     %
%    Davide Stocco                                                    %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: davide.stocco@unitn.it                                   %
%                                                                     %
%    Enrico Bertolazzi                                                %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: enrico.bertolazzi@unitn.it                               %
%                                                                     %
%    Francesco Biral                                                  %
%    Department of Industrial Engineering                             %
%    University of Trento                                             %
%    e-mail: francesco.biral@unitn.it                                 %
%                                                                     %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %

%
%> Class container for Gauss–Legendre sixth-order (3 stages)
%
classdef GaussLegendre6 < DIAL_RKimplicit
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Gauss–Legendre sixth-order (3 stages)
    %>
    %> \rst
    %> .. math::
    %>
    %>   \begin{array}{c|ccc}
    %>     1/2-t &     w & z-t_2 & w-t_4 \\
    %>       1/2 & w+t_3 &     z & w-t_3 \\
    %>     1/2+t & w+t_4 & z+t_2 &     w \\
    %>     \hline
    %>           &  5/18 &   4/9 &  5/18
    %>   \end{array}
    %>   \quad t   = \displaystyle\frac{\sqrt{15}}{10}
    %>   \quad t_2 = \displaystyle\frac{\sqrt{15}}{15}
    %>   \quad t_3 = \displaystyle\frac{\sqrt{15}}{24}
    %>   \quad t_4 = \displaystyle\frac{\sqrt{15}}{30}
    %>   \quad w   = \displaystyle\frac{5}{36}
    %>   \quad z   = \displaystyle\frac{2}{9}
    %>
    %> \endrst
    %
    function this = GaussLegendre6( ~ )
      t  = sqrt(15)/10;
      t2 = sqrt(15)/15;
      t3 = sqrt(15)/24;
      t4 = sqrt(15)/30;
      w  = 5/36;
      z  = 2/9;
      this@DIAL_RKimplicit( ...
        'GaussLegendre6', ...
        [w,    z-t2, w-t4; ...
         w+t3, z,    w-t3; ...
         w+t4, z+t2, w ], ...
        [5/18,4/9,5/18], ...
        [1/2-t,1/2,1/2+t]' ...
      );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
