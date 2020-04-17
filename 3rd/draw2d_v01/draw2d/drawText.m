function drawText( x, y, str, varargin)
%DRAWTEXT Draw text. Wrapper to gkText.

    narginchk(3,inf)
    nargoutchk(0,0)
    
    validateattributes(x,   {'numeric'}, {'real', 'scalar'});    
    validateattributes(y,   {'numeric'}, {'real', 'scalar'});
    validateattributes(str, {'char'},    {'nonempty','scalartext'});      
    
    gkText( x, y, str, varargin{:})
    
end
    