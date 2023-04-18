old_dir = cd(fileparts(which(mfilename)));

addpath('3rd/draw2d_v01/draw2d');
addpath('lib');
%addpath('lib/DAE');
addpath('lib/ODE');
addpath('lib/ODE/explicit');
addpath('lib/ODE/implicit');
%addpath('lib/ODE_P');
%addpath('lib/ODE_P/explicit');
%addpath('lib/ODE_P/implicit');
%addpath('examples/ODE');
%addpath('examples/ODE_P');
%addpath('examples/DAE');

cd(old_dir);
