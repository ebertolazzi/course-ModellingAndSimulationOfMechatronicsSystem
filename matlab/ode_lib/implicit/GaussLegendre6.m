%
% Matlab code for the Course:
%
%     Modelling and Simulation Mechatronics System
%
% by
% Enrico Bertolazzi
% Dipartimento di Ingegneria Industriale
% Universita` degli Studi di Trento
% email: enrico.bertolazzi@unitn.it
%
classdef GaussLegendre6 < ODEbaseSolverRKimplicit
  methods
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    % Gauss–Legendre 6th order
    %
    % t  = sqrt(15)/10
    % tt = sqrt(15)/24
    % w  = 5/36
    % z  = 2/9
    %
    % 1/2-t | w      z-t  w-t/3
    % 1/2   | w+tt   z    w-tt
    % 1/2+t | w+t/3  z+t  w
    % ------+------------------
    %       | 5/18   4/9  5/18
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function self = GaussLegendre6()
      t  = sqrt(15)/10;
      tt = sqrt(15)/24;
      w  = 5/36;
      z  = 2/9;
      self@ODEbaseSolverRKimplicit('GaussLegendre6',...
        [w,z-t,w-t/3;w+tt,z,w-tt;w+t/3,z+t,w],...
        [5/18,4/9,5/18],[1/2-t,1/2,1/2+t]...
      );
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    function delete( self )
    end
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  end
end
