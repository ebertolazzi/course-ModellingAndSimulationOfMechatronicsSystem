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
classdef Ralston4 < DAC_ODEsolverRKexplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %>
    %> Ralston's fourth-order method tableau
    %>
    %> \rst
    %> .. math::
    %>
    %>    \begin{array}{c|ccccc}
    %>       0          & 0          & 0           & 0          & 0 \\
    %>       \frac{2}{5} & 0.4        & 0           & 0          & 0 \\
    %>       \frac{7}{8}-\frac{3}{16}\sqrt{5} & 
    %>       \frac{357}{256}\sqrt{5}-\frac{2889}{1024} &
    %>       \frac{3785}{1024}-\frac{405}{256}\sqrt{5}  & 0          & 0 \\
    %>       1          & 
    %>       \frac{1047}{3020}\sqrt{5}-\frac{673}{1208} &
    %>       -\frac{975}{2552}-\frac{1523}{1276}\sqrt{5} &
    %>        \frac{93408}{48169}+\frac{203968}{240845}\sqrt{5} & 0 \\
    %>     \hline
    %>        & \frac{263}{1812}+\frac{2}{151}\sqrt{5} & 
    %>        \frac{125}{3828}-\frac{250}{957}\sqrt{5} & 
    %>        \frac{3426304}{5924787}+\frac{553984}{1974929}\sqrt{5} & 
    %>        \frac{10}{41}-\frac{4}{123}\sqrt{5}
    %>    \end{array}
    %>
    %> \endrst
    function self = Ralston4( )
      SQRT5 = sqrt(5);
      a2    = 2/5;
      a3    = 7/8-(3/16)*SQRT5;
      b31   = (357/256)*SQRT5-2889/1024;
      b32   = 3785/1024-(405/256)*SQRT5;
      b41   = (1047/3020)*SQRT5-673/1208;
      b42   = -975/2552-(1523/1276)*SQRT5;
      b43   = 93408/48169+(203968/240845)*SQRT5;
      g1    = 263/1812+(2/151)*SQRT5;
      g2    = 125/3828-(250/957)*SQRT5;
      g3    = 3426304/5924787+(553984/1974929)*SQRT5;
      g4    = 10/41-(4/123)*SQRT5;
      self@DAC_ODEsolverRKexplicit('Ralston4',...
         [ 0,   0,    0,   0;   ...
           0.4, 0,    0,   0;   ...
           b31, b32,  0,   0;   ...
           b41, b42,  b43, 0 ], ...
         [ g1, g2, g3, g4 ],    ...
         [ 0, a2, a3, 1 ]       ...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
