% Class container for the non-linear pendulum (ODE version)
classdef addition < handle
  properties (SetAccess = public, Hidden = false)
    a; % first addition term
    b; % second addition term
  end
  methods
    % constructor
    function this = addition( varargin )
      % can do anything, normally initialize the class
      if nargin == 0
        this.a = 0;
        this.b = 0;
      elseif nargin == 2
        this.a = varargin{1};
        this.b = varargin{2};
      else
        error('addition, constructor expect 0 or 2 arguments\n');
      end
      fprintf('passing by constructor\n');
    end
    %
    % methods
    %
    function set_a( this, a )
      this.a = a;
    end
    function set_b( this, b )
      this.b = b;
    end
    function res = do_add( this )
      res = this.a + this.b;
    end
  end
end
