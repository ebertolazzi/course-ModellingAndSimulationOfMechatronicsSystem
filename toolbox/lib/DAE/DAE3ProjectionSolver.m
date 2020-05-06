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
classdef DAE3ProjectionSolver < handle
  properties (SetAccess = protected, Hidden = true)
    solverName; % should contain the name of the numerical method used
    DAEclass;   % the object storing the DAE
    RKclass;    % the object storing the RK solver
  end

  methods
    function self = DAE3ProjectionSolver()
      self.solverName = 'DAE3ProjectionSolver';
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
    function setRK( self, RKclass )
      self.RKclass = RKclass;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  form the index 1 DAE
    %  q' = v
    %  v' = v_dot
    %  M(t,p) v_dot + Phi_p(t,q)^T lambda = f( t, q, v )
    %  Phi_q(t,q)v_dot = b( t, q, v )
    %
    %  solve the linear system
    %
    %  / M(t,q)      Phi_p(t,q)^T \ /   v'   \   / f( t, q, v ) \
    %  |                          | |        | = |              |
    %  \ Phi_p(t,q)      0        / \ lambda /   \ b( t, q, v ) /
    %
    %  To obtain the ODE
    %
    %  q' = v
    %  v' = v_dot(t,q,v)
    %
    function rhs = f( self, t, x )
      [n,m] = self.DAEclass.getDim();
      pos   = x(1:n);
      vel   = x(n+1:end);
      M     = self.DAEclass.M( t, pos );
      Phi_q = self.DAEclass.Phi_q( t, pos );
      f     = self.DAEclass.gforce( t, pos, vel );
      b     = self.DAEclass.b( t, pos, vel );
      % solve for v' and lambda
      vl    = [ M, Phi_q.'; Phi_q, zeros(m,m) ]\[f;b];
      rhs   = [ vel; vl(1:n) ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  form the index 1 DAE
    %  q' = v
    %  v' = v_dot
    %  M(t,p) v_dot + Phi_p(t,q)^T lambda = f( t, q, v )
    %  Phi_q(t,q)v_dot = b( t, q, v )
    %
    %  solve the linear system
    %
    %  / M(t,q)      Phi_p(t,q)^T \ /   v'   \   / f( t, q, v ) \
    %  |                          | |        | = |              |
    %  \ Phi_p(t,q)      0        / \ lambda /   \ b( t, q, v ) /
    %
    %  To obtain the ODE
    %
    %  q' = v
    %  v' = v_dot(t,q,v)
    %
    function Jac = DfDx( self, t, x )
      [n,m]  = self.DAEclass.getDim();
      pos    = x(1:n);
      vel    = x(n+1:end);
      M      = self.DAEclass.M( t, pos );
      Phi_q  = self.DAEclass.Phi_q( t, pos );
      f      = self.DAEclass.gforce( t, pos, vel );
      b      = self.DAEclass.b( t, pos, vel );
      % solve for v' and lambda
      Mat    = [ M, Phi_q.'; Phi_q, zeros(m,m) ];
      vl     = Mat\[f;b];
      v_dot  = vl(1:n);
      lambda = vl(n+1:end);
      aa     = self.DAEclass.gforce_q( t, pos, vel ) ...
             - self.DAEclass.W_q( t, pos, v_dot ) ...
             - self.DAEclass.PhiL_q( t, pos, lambda );
      bb     = self.DAEclass.b_q( t, pos, vel ) ...
             - self.DAEclass.PhiV_q( t, pos, v_dot );
      vl     = Mat\[aa;bb];
      v_D_q  = vl(1:n,:);
      aa     = self.DAEclass.gforce_v( t, pos, vel );
      bb     = self.DAEclass.b_v( t, pos, vel );
      vl     = Mat\[aa;bb];
      v_D_v  = vl(1:n,:);
      Jac    = [ zeros(n,n), eye(n); v_D_q, v_D_v ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %  form the index 1 DAE
    %  q' = v
    %  M(t,p) v' + Phi_p(t,q)^T lambda = f( t, q, v )
    %  Phi_q(t,q) v' = b( t, q, v )
    %
    %  solve the linear system
    %
    %  / M(t,q)      Phi_p(t,q)^T \ /   v'   \   / f( t, q, v ) \
    %  |                          | |        | = |              |
    %  \ Phi_p(t,q)      0        / \ lambda /   \ b( t, q, v ) /
    %
    %  To obtain lambda
    %
    function lbd = lambda( self, t, x )
      [n,m] = self.DAEclass.getDim();
      pos   = x(1:n);
      vel   = x(n+1:end);
      M     = self.DAEclass.M( t, pos );
      Phi_q = self.DAEclass.Phi_q( t, pos );
      f     = self.DAEclass.gforce( t, pos, vel );
      b     = self.DAEclass.b( t, pos, vel );
      % solve for v' and lambda
      vl    = [ M, Phi_q.'; Phi_q, zeros(m,m) ]\[f;b];
      lbd   = vl(n+1,end);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  Solve the problem
    %
    %  minimize      1/2 * (q-qbar)^2
    %  subject to    Phi( q, tbar ) = 0
    %
    function projected_pos = project_position( self, t, pos )
      [n,m] = self.DAEclass.getDim();
      q   = pos;
      mu  = zeros(m,1);
      tol = norm(pos,inf)*sqrt(eps);
      for k=1:10
        phi = self.DAEclass.Phi( t, q );
        M   = self.DAEclass.Phi_q( t, q );
        Dql = [ eye(n), M.'; M, zeros(m,m) ] \ [ (pos-q) - (M.' * mu);-phi];
        q   = q + Dql(1:n);
        mu  = mu + Dql(n+1:end);
        if max(abs(Dql)) < tol
          break;
        end
      end
      projected_pos = q;
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  Solve the problem
    %
    %  minimize      1/2 * (v-vbar)^2
    %  subject to    Phi_q( tbar, q ) v + Phi_t( tbar, t ) = 0
    %
    function projected_vel = project_velocity( self, t, pos, vel )
      [n,m] = self.DAEclass.getDim();
      A   = self.DAEclass.Phi_q( t, pos );
      b   = self.DAEclass.Phi_t( t, pos ) + A*vel;
      vmu = [ eye(n), A.'; A, zeros(m,m) ] \ [ vel; -b ];
      projected_vel = vmu(1:n);
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  step is a generic advancing step for a generic numerical methods
    %
    %  given x0 = x(t0) return the approximation of x(t0+dt)
    %
    function x1 = step( self, x0, t0, dt )
      [n,m] = self.DAEclass.getDim();
      % advance using RK Method
      x1    = self.RKclass.step( x0, t0, dt );
      t1    = t0+dt;
      % project solution
      pos   = self.project_position( t1, x1(1:n) );
      vel   = self.project_velocity( t1, pos, x1(n+1:end) );
      x1    = [ pos; vel ];
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %  compute approximate solution on a series of point given by the vector t
    %  starting at initial point pos0, vel0
    %
    function [ pos, vel, varargout ] = advance( self, t, pos0, vel0 )
      self.RKclass.setODE( self );
      [n,m]  = self.DAEclass.getDim();
      x      = zeros(2*n,length(t));
      x(:,1) = [pos0(:);vel0(:)];
      for k=1:length(t)-1
        x(:,k+1) = self.step( t(k), x(:,k), t(k+1)-t(k) );
      end
      pos = x(1:n,:);
      vel = x(n+1:end,:);
      % if required compute lambda
      if nargout > 2
        lambda = zeros(m,length(t));
        for k=1:length(t)
          lambda(:,k) = self.lambda( t(k), x(:,k) );
        end
      end
    end
  end
end
