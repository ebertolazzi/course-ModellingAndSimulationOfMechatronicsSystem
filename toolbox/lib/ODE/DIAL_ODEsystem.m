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
%> Class container for a system of Ordinary Differential Equations (ODEs)
%
classdef DIAL_ODEsystem < DIAL_Base
  %
  methods
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> Class constructor
    %>
    %> - *name* Name of the system of ODEs/DAEs
    %> - *neqn* Number of equations of the system of ODEs/DAEs
    %> - *ninv* [optional, default = 0] Number of invariants/contraints of the system of ODEs/DAEs
    %
    function this = DIAL_ODEsystem( name, neqn, ninv, ~ )
      this@DIAL_Base( name, neqn, ninv );
    end
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
  methods (Abstract)
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> (Abstract) Definition of the system of ODEs:
    %>
    %> \f[ \mathbf{x}' = \mathbf{f}( t, \mathbf{x} ) \quad\oplus\quad [\textrm{invariants}] \f]
    %>
    %> invariants are of the form:
    %>
    %> \f[ \mathbf{h}( t, \mathbf{x} ) = \mathbf{0} \f]
    %>
    %> The derived function must define the r.h.s. of the ODE
    %> \f$ \mathbf{f}( t, \mathbf{x} ) \f$ where
    %> \f$ \mathbf{x} \f$ are the states of the model described by the ODE.
    %
    f( this, t, x, ~ )
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> (Abstract) Evaluate the jacobian of the r.h.s. of the system of ODEs:
    %>
    %> \f[ \partial \mathbf{f}( t, \mathbf{x} ) / \partial \mathbf{x} \f]
    %>
    %> Used only in implicit Runge-Kutta methods
    %
    DfDx( this, t, x, ~ )
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> (Abstract) Evaluate the invariants/hidden constraints of the system of ODEs:
    %>
    %> \f[ \mathbf{h}( t, \mathbf{x} ) = \mathbf{0} \f]
    %
    h( this, t, x, ~ )
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
    %> (Abstract) Evaluate the Jacobian of the hidden constraints of the system of ODEs:
    %>
    %> \f[ \partial \mathbf{h}( t, \mathbf{x} ) / \partial \mathbf{x} \f]
    %>
    %> Used only in projection method
    %
    DhDx( this, t, x, ~ )
    %
    % - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    %
  end
  %
end
