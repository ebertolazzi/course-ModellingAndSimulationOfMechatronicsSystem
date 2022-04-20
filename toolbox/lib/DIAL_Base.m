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
%> Class container for the system of Ordinary Differential Equations (ODEs)
%> or Differential Algebraic Equations (DAEs)
%
classdef DIAL_Base < handle
  %
  properties (SetAccess = protected, Hidden = true)
    %
    %> Name of the system of ODEs/DAEs (used in warning/error messages)
    %
    m_name;
    %
    %> Number of equations of the system of ODEs/DAEs
    %
    m_neqn;
    %
    %> Number of invariants/contraints of the system of ODEs/DAEs
    %
    m_ninv;
  end
  %
  methods (Abstract)
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> (Abstract) Plot the system of ODEs/DAEs model in a defined pose
    %
    plot( this, t, x, ~ )
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Class constructor
    %>
    %> - *name* Name of the system of ODEs/DAEs
    %> - *neqn* Number of equations of the system of ODEs/DAEs
    %> - *ninv* Number of invariants/contraints of the system of ODEs/DAEs
    %
    function this = DIAL_Base( name, neqn, ninv, ~ )
      this.m_name = name;
      this.m_neqn = neqn;
      this.m_ninv = ninv;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Get the number of equations of the system of ODEs/DAEs
    %
    function out = getNeqn( this, ~ )
      out = this.m_neqn;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Get the number of invariants/contraints of the system of ODEs/DAEs
    %
    function out = getNinv( this, ~ )
      out = this.m_ninv;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Set the number of equations of the system of ODEs/DAEs
    %
    function setNeq( this, in, ~ )
      this.m_neqn = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Set the number of invariants/contraints of the system of ODEs/DAEs
    %
    function setNinv( this, in, ~ )
      this.m_ninv = in;
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Animate the system of ODEs/DAEs solution
    %>
    %> - *t*     Vector of sampled time
    %> - *x* Matrix with the solution at sampled time
    %> - *pause*    Pause in ms between two frames
    %> - *step*     Update the plot every `step` time steps
    %
    function animatePlot( this, t, x, pause, step, ~ )
      figure();
      for i = 1:step:size( x, 2 )
        this.plot( t(i), x(:,i) );
        axis equal;
        drawnow;
        pause( pause/1000 );
      end
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Make a movie of the system of ODEs/DAEs solution
    %>
    %> - *path* Path to the filename where to save movie
    %> - *t*    Vector of sampled time
    %> - *x*    Matrix with the solution at sampled time
    %> - *step* Update the plot every `step` time steps
    %
    function makeMovie( this, path, t, x, step, ~ )
      figure();
      video = VideoWriter( path, 'MPEG-4' );
      open( video );
      for i = 1:step:size( x, 2 )
        this.plot( t(i), x(:,i) );
        axis equal;
        drawnow;
        writeVideo( video, getframe(gcf) );
      end
      close( video );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
