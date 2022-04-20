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
%> Class container for Runge-Kutta 3/8-rule third-order method (4 stages)
%
classdef RK38 < DIAL_RKexplicit
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Runge-Kutta 3/8-rule fourth-order method (4 stages)
    %>
    %> \rst
    %> .. math::
    %>
    %>   \begin{array}{c|ccccc}
    %>       0 &    0 &   0 &   0 &   0 \\
    %>     1/3 &  1/3 &   0 &   0 &   0 \\
    %>     2/3 & -1/3 &   1 &   0 &   0 \\
    %>       1 &    1 &  -1 &   1 &   0 \\
    %>     \hline
    %>         &  1/8 & 3/8 & 3/8 & 1/8
    %>   \end{array}
    %>
    %> \endrst
    %
    function this = RK38( ~ )
      this@DIAL_RKexplicit( ...
        'RK38',...
        [   0,  0, 0, 0; ...
          1/3,  0, 0, 0; ...
         -1/3,  1, 0, 0; ...
            1, -1, 1, 0 ], ...
        [1/8, 3/8, 3/8, 1/8], ...
        [0, 1/3, 2/3, 1]' ...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
