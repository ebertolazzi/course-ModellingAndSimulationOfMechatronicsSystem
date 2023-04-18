function [x,y] = evalCatenary( lambda, x1, y1, s1, s) 
%EVALCATENARY  Calculate points that on a catenary curve
%
%Usage:
%   [x,y] = evalCatenary(x1,y1,lambda,s1,s)
%
%Input:
%   x1,y1   --  starting point coordinates
%   lambda  --  catenary parameter (characteristic length)
%   s1      --  starting value of the parameter
%   s       --  arc-length coordinates  
%
%Output:
%   x,y     --  the points of the curve
%

    narginchk(5,5)
    nargoutchk(2,2)
     
    validateattributes(x1, {'numeric'}, {'real', 'scalar'});    
    validateattributes(y1, {'numeric'}, {'real', 'scalar'});   
    validateattributes(lambda, {'numeric'}, {'positive', 'real', 'scalar'});    
    validateattributes(s1, {'numeric'}, {'real', 'scalar'});       
    validateattributes(s,  {'numeric'}, {'real', 'vector'});    
    
    %calculate coordinates
    x = x1 + lambda*(asinh(s/lambda) - asinh(s1/lambda));
    y = y1 + lambda*(sqrt(1 + (s/lambda).^2) - sqrt(1 + (s1/lambda)^2));

end

