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
%> Class container for Ralston's fourth-order method (4 stages)
%
classdef Ralston4 < DIAL_RKexplicit
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Ralston's fourth-order method (4 stages)
    %>
    %> \rst
    %> .. math::
    %>
    %>   \begin{array}{c|ccccc}
    %>     0           & 0   & 0 & 0 & 0 \\
    %>     \frac{2}{5} & 0.4 & 0 & 0 & 0 \\
    %>     \frac{7}{8}-\frac{3}{16}\sqrt{5} &
    %>     \frac{357}{256}\sqrt{5}-\frac{2889}{1024} &
    %>     \frac{3785}{1024}-\frac{405}{256}\sqrt{5} &
    %>      0 &
    %>      0 \\
    %>     1 & 
    %>     \frac{1047}{3020}\sqrt{5}-\frac{673}{1208} &
    %>     -\frac{975}{2552}-\frac{1523}{1276}\sqrt{5} &
    %>     \frac{93408}{48169}+\frac{203968}{240845}\sqrt{5} &
    %>     0 \\
    %>     \hline
    %>       & \frac{263}{1812}+\frac{2}{151}\sqrt{5} & 
    %>       \frac{125}{3828}-\frac{250}{957}\sqrt{5} & 
    %>       \frac{3426304}{5924787}+\frac{553984}{1974929}\sqrt{5} & 
    %>       \frac{10}{41}-\frac{4}{123}\sqrt{5}
    %>   \end{array}
    %>
    %> \endrst
    %
    function this = Ralston4( ~ )
      S5  = sqrt(5);
      A31 = (357/256)*S5-2889/1024;
      A32 = 3785/1024-(405/256)*S5;
      A41 = (1047/3020)*S5-673/1208;
      A42 = -975/2552-(1523/1276)*S5;
      A43 = 93408/48169+(203968/240845)*S5;
      B1  = 263/1812+(2/151)*S5;
      B2  = 125/3828-(250/957)*S5;
      B3  = 3426304/5924787+(553984/1974929)*S5;
      B4  = 10/41-(4/123)*S5;
      C2  = 2/5;
      C3  = 7/8-(3/16)*S5;
      this@DIAL_RKexplicit( ...
        'Ralston4', ...
        [ 0,   0,    0,   0; ...
          0.4, 0,    0,   0; ...
          A31, A32,  0,   0; ...
          A41, A42,  A43, 0 ], ...
        [ B1, B2, B3, B4 ], ...
        [ 0, C2, C3, 1 ]' ...
      );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
