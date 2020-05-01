function value = drawGet(name)
%DRAWGET Wrapper to gkGet
    narginchk(1,1)
    nargoutchk(0,1)
    validateattributes(name, {'char'},{'nonempty','scalartext'});   
    value = gkGet(name);   
end

