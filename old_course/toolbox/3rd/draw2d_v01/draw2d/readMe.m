% draw2d - 2d drawing library
%==================================
% History:  
%   MB, created, 7.5-3.6.2019
%
% Ver: 1.0
%
%===============================
% This is a collection of MATLAB functions that allow to programaticaly
% create simple 2d drawing that can be used in engineering.
%================================
% NOTE 1:
%  For proper use one must set
%   
%   axis equal
%
%   This is done by drawInit
%
% NOTE 2:
%   The library must be set on MATLAB search path. For example: if
%   file structure is:
%       myMatlab -> draw2d
%                -> examples/ test01.m
%
% Then first line of test01.m should be
%   addpath('..\draw2d');
%
%================================
%
% Drawing functions:
% ------------------
%
% Anotations
%   p = drawArcArrow( form, ad1, ad2, xc, yc, r, sang, ang, varargin)
%   p = drawArrow( form, ad1, ad2, x1, y1, varargin)
%       drawArrowhead( form, ad1, ad2, xh, yh, rot, varargin)
%   p = drawAxes( form, ad, a, xc, yc, varargin)
%   p = drawCross(  d1, d2, xc, yc, varargin )
%   p = drawLeader( form, ad1, ad2, xh, yh, xt, yt, varargin)
%   drawText( x, y, str, varargin)
%
% Curves:
%   p = drawBezier( xv, yv, varargin )
%   p = drawBspline( c, xv, yv, varargin )
%   p = drawCatenary( x1, y1, dx, dy, varargin )
%   p = drawCircle( xc, yc, r, varargin )
%   p = drawEllipse( a, b, xc, yc, varargin )
%   p = drawHyperbola( t1, t2, a, b, xc, yc, varargin )
%   p = drawLine( x1, y1, varargin )
%   p = drawParabola( t1, t2, f, xc, yc, varargin )
%   p = drawPolygon( xv, yv, varargin)
%   p = drawPolyline( xv, yv, varargin)
%   p = drawSpiral( a, sang, eang, varargin)
%   p = drawSpline( ctype, xv, yv, varargin )
%
% Dimensions
%   drawAngDim( form, ad1, ad2, xc, yc, sang, ang, rt, at, varargin)
%   drawAngDim3p( form, ad1, ad2, xc, yc, x1, y1, x2, y2, rt, at, varargin)
%   drawDim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
%   drawHDim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
%   drawVDim( form, ad1, ad2, x1, y1, x2, y2, xt, yt, varargin)
%
% Shapes:
%   p = drawCanoe1( ht, x1, y1, varargin )
%   p = drawDonut(  d1, d2, xc, yc, varargin )
%   p = drawNgon( n, r, xc, yc, varargin )
%   p = drawRect( wd, ht, xr, yr, varargin )
%   p = drawSpring1(form,r,nc,x1,y1,varargin)  
%   p = drawSupport(type, r,x0,y0,varargin)
%
% Symbols: 
%   drawCOG( dia, xc, yc, varargin) 
%   p = drawPoint( form, d, xp, yp, varargin )
%
% Force and load:
%   p = drawForce(F,th,d,xr,yr,varargin) 
%   p = drawLoad(wd,h1,h2,nc,d,xr,yr,varargin) 
%
% Fill area
%------------
%   p = fillCanoe( c, wd, ht, xr, yr, varargin )
%   p = fillCanoe1( c, ht, x1, y1, varargin )
%   p = fillCircle( c, xc, yc, r, varargin )
%   p = fillDonut(  c1, c2, d1, d2, xc, yc, varargin )
%   p = fillEllipse( c, a, b, xc, yc, varargin )
%   p = fillNgon( c, n, r, xc, yc, varargin )
%   p = fillPolygon( c, xv, yv, varargin)
%   p = fillRect( c, wd, ht, xr, yr, varargin ) 
%
% Output attributes
% -----------------
%   v = drawGet(name)
%   fn = drawInit(figNum)
%   drawSet(varargin)
%
% Figure window functions:
% ---------
%   fn = drawInit(figNum)
%   drawLimits( xmin, xmax, ymin, ymax)
%
% Hard copy:
% ----------
%   drawSave(fileName,varargin)
%
% Evaluation functions:
% ---------------------
%   [x, y] = evalBezier( xv, yv, tt) 
%   [x, y] = evalBspline( c, xv, yv, np) 
%   [x, y] = evalCatenary( lambda, x1, y1, s1, s)
%   [x, y] = evalCircle( xc, yc, r, th)
%   [x, y] = evalEllipse( a, b, xc, yc, rot, th))
%   [x, y] = evalHyperbola( a, b, xc, yc, rot, t)
%   [x, y] = evalLine( x1, y1, x2, y2, t)
%   [x, y] = evalNgon( nv, r, xc, yc, rot, v1, v2)
%   [x, y] = evalParabola( f, xc, yc, rot, t)
%   [x, y] = evalRect( wd, ht, xr, yr, rot, ip, v1, v2 )
%   [x, y] = evalSpiral( a, xc, yc, rot, th)
%   [x, y, th] = evalSpline(ctype, xv, yv, u, v, np) 
%
% Transformation functions
%-------------------------
%   [xx,yy] = trRot2d( x, y, x0, y0, theta)
%   [xx,yy] = trScale2d( x, y, dx, dy)
%   [xx,yy] = trShift2d( x, y, dx, dy)
%
% Other functions
%------------------------
%
%   p = PCA2d( X, Y)
%   [x,y] = swap(x,y)