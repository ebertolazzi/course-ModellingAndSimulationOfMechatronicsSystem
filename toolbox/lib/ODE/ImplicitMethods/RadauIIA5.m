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
%> Class container for Radau IIA fifth-order method (3 stages)
%
classdef RadauIIA5 < DIAL_RKimplicit
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Radau IIA fifth-order method (3 stages)
    %>
    %> \rst
    %> .. math::
    %>
    %>  \begin{array}{c|ccc}
    %>    0 & \frac{1}{9} & \frac{-1 - \sqrt{6}}{18} & \frac{-1 + \sqrt{6}}{18} \\
    %>    \frac{3}{5} - \frac{\sqrt{6}}{10} & \frac{1}{9} & \frac{11}{45} + \frac{7\sqrt{6}}{360} & \frac{11}{45} - \frac{43\sqrt{6}}{360} \\
    %>    \frac{3}{5} + \frac{\sqrt{6}}{10} & \frac{1}{9} & \frac{11}{45} + \frac{43\sqrt{6}}{360} & \frac{11}{45} - \frac{7\sqrt{6}}{360} \\
    %>    \hline
    %>      & \frac{1}{9} & \frac{4}{9} + \frac{\sqrt{6}}{36} & \frac{4}{9} - \frac{\sqrt{6}}{36} \\
    %>  \end{array}
    %>
    %> \endrst
    %
    function this = RadauIIA5( ~ )
      this@DIAL_RKimplicit( ...
        'RadauIIA5', ...
        [11/45-7*sqrt(6)/360,    37/225-169*sqrt(6)/1800, -2/225+sqrt(6)/75; ...
         37/45+169*sqrt(6)/1800, 11/45+7*sqrt(6)/360,     -2/225-sqrt(6)/75; ...
         4/9-sqrt(6)/36,         4/9+sqrt(6)/36,          1/9 ], ...
        [4/9-sqrt(6)/36, 4/9+sqrt(6)/36, 1/9], ...
        [2/5-sqrt(6)/10, 2/5+sqrt(6)/10, 1]' ...
      );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
