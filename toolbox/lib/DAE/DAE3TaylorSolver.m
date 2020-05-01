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
classdef DAE3TaylorSolver < handle
  properties (SetAccess = protected, Hidden = true)
    solverName; % should contain the name of the numerical method used
    DAEclass;   % the object storing the DAE
  end

  methods
    function self = DAE3TaylorSolver()
      self.solverName = 'TaylorSolver';
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function name = getName( self )
      name = self.solverName;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function setDAE( self, DAEclass )
      self.DAEclass = DAEclass;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  compute approximate solution on a series of point given by the vector t
    %  starting at initial point [p0,v0]
    %
    function [pos,vel,lambda] = advance_simple( self, t, p0, v0 )
      [n,m]    = self.DAEclass.getDim();
      pos      = zeros(n,length(t));
      vel      = zeros(n,length(t));
      lambda   = zeros(m,length(t));
      pos(:,1) = p0(:);
      vel(:,1) = v0(:);
      for k=1:length(t)-1
        tt = t(:,k);
        pp = pos(:,k);
        vv = vel(:,k);
        % get M, Phi, Phi_q, f and b
        M     = self.DAEclass.M( tt, pp );
        Phi_q = self.DAEclass.Phi_q( tt, pp );
        f     = self.DAEclass.gforce( tt, pp, vv );
        b     = self.DAEclass.b( tt, pp, vv );
        % solve for v' and lambda
        vl    = [ M,     Phi_q.'; ...
                  Phi_q, zeros(m,m) ]\[f;b];
        vp    = vl(1:n);
        % update using Taylor
        DT = t(k+1)-t(k);
        pos(:,k+1)    = pp + DT*vv + (DT^2/2)*vp;
        vel(:,k+1)    = vv + DT*vp;
        lambda(:,k+1) = vl(n+1:n+m);
      end
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  compute approximate solution on a series of point given by the vector t
    %  starting at initial point [p0,v0] with Baumgarte stabilization
    %
    function [pos,vel,lambda] = advance_Baumgarte( self, t, p0, v0, eta, omega )
      [n,m] = self.DAEclass.getDim();
      pos      = zeros(n,length(t));
      vel      = zeros(n,length(t));
      lambda   = zeros(m,length(t));
      pos(:,1) = p0(:);
      vel(:,1) = v0(:);
      t1       = -2*eta*omega;
      t2       = -omega^2;
      for k=1:length(t)-1
        tt = t(:,k);
        pp = pos(:,k);
        vv = vel(:,k);
        % get M, Phi, Phi_q, f and b
        M     = self.DAEclass.M( tt, pp );
        Phi   = self.DAEclass.Phi( tt, pp );
        Phi_t = self.DAEclass.Phi_t( tt, pp );
        Phi_q = self.DAEclass.Phi_q( tt, pp );
        f     = self.DAEclass.gforce( tt, pp, vv );
        b     = self.DAEclass.b( tt, pp, vv ) + t1 * ( Phi_t + Phi_q * vv ) + t2 * Phi;
        % solve for v' and lambda
        vl    = [ M,     Phi_q.'; ...
                  Phi_q, zeros(m,m) ]\[f;b];
        vp    = vl(1:n);
        % update using Taylor
        DT = t(k+1)-t(k);
        pos(:,k+1)    = pp + DT*vv + (DT^2/2)*vp;
        vel(:,k+1)    = vv + DT*vp;
        lambda(:,k+1) = vl(n+1:n+m);
      end
    end
  end
end
