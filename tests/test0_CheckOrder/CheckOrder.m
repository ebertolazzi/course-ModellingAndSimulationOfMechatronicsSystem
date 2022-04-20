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

%> Implementation of ODE for assessing the integration method order
%>
%> \rst
%> .. math::
%> 
%>   \begin{cases}
%>      x' =  x+y & \quad x(0)=0 \\
%>      y' = -x+y & \quad y(0)=1
%>   \end{cases}
%>
%> \endrst
%
classdef CheckOrder < DIAL_ODEsystem
  %
  properties (SetAccess = protected, Hidden = true)
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function this = CheckOrder()
      neqn = 2;
      ninv = 0;
      this@DIAL_ODEsystem( 'CheckOrder', neqn, ninv );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = f( ~, ~, X )
      out    = zeros(2,1);
      out(1) =  X(1) + X(2);
      out(2) = -X(1) + X(2);
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = DfDx( ~, ~, ~ )
      out = [ 1.0, 1.0; ...
             -1.0, 1.0 ];
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function h( ~, ~, ~ )
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function DhDx( ~, ~, ~ )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function plot( ~, ~, ~ )
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    function out = exact( ~, x_i, t )
      out      = zeros(2,length(t));
      out(1,:) = exp(t) .* (x_i(1) .* cos(t) + x_i(2) .* sin(t));
      out(2,:) = exp(t) .* (x_i(2) .* cos(t) - x_i(1) .* sin(t));
    end
    %
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
