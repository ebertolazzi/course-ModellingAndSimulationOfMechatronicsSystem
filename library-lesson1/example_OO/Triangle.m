%
% Define the Class Triangle
% < handle (forget for now, its a technical instruction to access data)
% The data of the trinagle are the 3 points P1, P2 and P3.
%
classdef Triangle < handle
  properties (SetAccess = protected, Hidden = true)
    P1;
    P2;
    P3;
  end

  methods
    function self = Triangle( P1, P2, P3 )
      % This function is called when the object is instantiated
      fprintf( 'Creating Triangle object\n');
      self.P1 = P1;
      self.P2 = P2;
      self.P3 = P3;
    end
    %
    %
    %
    function translate( self, dx, dy )
      self.P1 = self.P1+[dx,dy];
      self.P2 = self.P2+[dx,dy];
      self.P3 = self.P3+[dx,dy];
    end
    %
    %
    %
    function res = perimeter( self )
      L12 = norm( self.P1 - self.P2 );
      L23 = norm( self.P2 - self.P3 );
      L31 = norm( self.P3 - self.P1 );
      res = L12+L23+L31;
    end
    %
    %
    %
    function res = area( self )
      %
      % https://www.mathsisfun.com/geometry/herons-formula.html
      %
      a = norm( self.P1 - self.P2 );
      b = norm( self.P2 - self.P3 );
      c = norm( self.P3 - self.P1 );
      s = (a+b+c)/2;
      res = sqrt(s*(s-a)*(s-b)*(s-c));
    end
    %
    %
    %
    function plot( self, varargin )
      X = [self.P1(1), self.P2(1),self.P3(1),self.P1(1)];
      Y = [self.P1(2), self.P2(2),self.P3(2),self.P1(2)];
      plot(X,Y,varargin{:});
    end
  end
end
