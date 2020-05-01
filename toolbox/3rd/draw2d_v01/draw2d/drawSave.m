function drawSave(fileName,varargin)
%DRAWSAVE  Save current figure as bitmap image in jpg 24-bit format. 
%
%History:
%   2019,May   - MB created
%
% Usage:
%   drawSave(fileName,varargin)
%
% Optional input:
%   fileName --
%   varargin -- options
%       '-r',|'low'|'medium'(default)|'high'
%       '-f',fileName
%
% Notes:
%   Figure is saved to file 'fileName.jpg'. Input file extension, if any, 
%   is ignored.
%
%   If file name is not given then the file name is FigXX.jpg where XX is
%   current figure number.
%
% Examples:
%   darawSave('test','-r','low')  save current figure to test.jpg with
%   resolution 100.
%
    narginchk(0,4)
    nargoutchk(0,0)
    
    % set default values
    fname = sprintf('Fig%g.jpg',get(gcf,'Number'));
    res = '-r300';
    
    if nargin == 1
        [~,fname,~] = fileparts(fileName);
        fname = sprintf('%s.jpg',fname);
    else
        if nargin > 1
            for k = 1:2:length(varargin)
                switch lower(varargin{k})
                    case '-r'
                        if ~ischar(varargin{k+1})
                            nn = varargin{k+1};
                            validateattributes(nn, {'numeric'}, {'>',9,'<',1201', 'integer', 'scalar'});
                            res = sprintf('-r%d',nn);
                        else
                            switch lower(varargin{k+1})
                                case {'low','l'}
                                    res = '-r100';
                                case {'medium','m'}
                                    res = '-r300';
                                case {'high','h'}
                                    res = '-r600';
                            end
                        end
                    case '-f'
                        [~,fname,~] = fileparts(varargin{k+1});
                        fname = sprintf('%s.jpg',fname); 
                end
            end
        end
    end
    
     print(gcf,fname,'-djpeg',res);
     
end
