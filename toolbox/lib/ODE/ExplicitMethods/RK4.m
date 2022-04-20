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
%> Class container for Runge-Kutta fourth-order method (4 stages)
%
classdef RK4 < DIAL_RKexplicit
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Classic fourth-order Runge-Kutta's method (4 stages)
    %>
    %> \rst
    %> .. math::
    %>
    %>   \begin{array}{c|ccccc}
    %>       0 &   0 &   0 &   0 &   0 \\
    %>     1/2 & 1/2 &   0 &   0 &   0 \\
    %>     1/2 &   0 & 1/2 &   0 &   0 \\
    %>       1 &   0 &   0 &   1 &   0 \\
    %>     \hline
    %>         & 1/6 & 1/3 & 1/3 & 1/6
    %>   \end{array}
    %>
    %> \endrst
    %
    function this = RK4( ~ )
      this@DIAL_RKexplicit( ...
        'RK4', ...
        [  0,   0, 0, 0; ...
         1/2,   0, 0, 0; ...
           0, 1/2, 0, 0; ...
           0,   0, 1, 0 ], ...
        [1/6, 1/3, 1/3, 1/6], ...
        [0, 1/2, 1/2, 1]' ...
      );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
