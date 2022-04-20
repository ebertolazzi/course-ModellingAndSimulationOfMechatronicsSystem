old_dir = cd(fileparts(which(mfilename)));

addpath('3rd/draw2d_v01/draw2d');
addpath('lib');
addpath('lib/ODE');
addpath('lib/ODE/ExplicitMethods');
addpath('lib/ODE/ImplicitMethods');

cd(old_dir);
