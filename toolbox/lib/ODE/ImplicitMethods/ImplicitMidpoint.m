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
%> Class container for Implicit midpoint second-order method (1 stage)
%
classdef ImplicitMidpoint < DIAL_RKimplicit
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Implicit midpoint second-order method (1 stage)
    %>
    %> \rst
    %> .. math::
    %>
    %>   \begin{array}{c|c}
    %>     1/2 & 1/2 \\
    %>     \hline
    %>         &   1
    %>   \end{array}
    %>
    %> \endrst
    %
    function this = ImplicitMidpoint( ~ )
      this@DIAL_RKimplicit( ...
        'ImplicitMidpoint', ...
        [1/2], ...
        [1], ...
        [1/2]' ...
      );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
