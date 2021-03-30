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
%> 
%> ODE base class describing an ODE
%>
%> *Usage*
%>
%>      ode = ODE_derived_class() % create an instance of a ODE
%>      res = ode.f(t,x);
%>
classdef DAC_base_class < handle
  properties (SetAccess = protected, Hidden = true)
    %> the name of the ODE or DAE, used in warning/error messages
    name;
  end

  methods (Abstract)
    %>
    %> Abstract functions.
    %> The derived function must plot the ODE/DAE model
    %>
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    plot( self, t, x )
  end

  methods
    function self = DAC_base_class( name )
      %> Construct object with stored `name`
      self.name = name;
    end
    %>
    %> Animate solution
    %>
    %> - *t*     vector of sampled time
    %> - *x*     matrix with the solution at sampled time
    %> - *ms*    pause in ms between two plotted frames
    %> - *fstep* plot every `fstep` frames
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function animate_plot( self, t, x, ms, fstep )
      figure();
      for k=1:fstep:size(x,2)
        self.plot(t(k),x(:,k));
        axis equal
        drawnow;
        pause(ms/1000);
      end
    end
    %>
    %> Make a movie of the solution
    %>
    %> - *fname* file name where to save movie
    %> - *t*     vector of sampled time
    %> - *x*     matrix with the solution at sampled time
    %> - *fstep* plot every `fstep` frames
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function make_movie( self, fname, t, x, fstep )
      figure();
      vidfile = VideoWriter(fname,'MPEG-4');
      open(vidfile);
      for k=1:fstep:size(x,2)
        self.plot(t(k),x(:,k));
        axis equal
        drawnow;
        writeVideo(vidfile,getframe(gcf));
      end
      close(vidfile);
    end
  end
end
