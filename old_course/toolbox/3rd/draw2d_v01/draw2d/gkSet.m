function gkSet(varargin)
%GKSET set attributes to output primitives
    global gkdata
    if isempty(gkdata)
        error('Data table is empty.')
    end
    if isempty(varargin)
        return
    end
    nn = length(varargin);
    if mod(nn,2) ~= 0
        error('Missing data.')
    end
    for n = 1:2:nn
        switch lower(varargin{n})
            case 'linestyle'
                gkdata.lineStyle = varargin{n+1};
            case 'linecolor'
                gkdata.lineColor = varargin{n+1};
            case 'linewidth'
                gkdata.lineWidth = varargin{n+1};
            case 'facecolor'
                gkdata.faceColor = varargin{n+1};
            case 'edgecolor'
                gkdata.edgeColor = varargin{n+1};
            case 'edgewidth'
                gkdata.edgeWidth = varargin{n+1};
            case 'edgestyle'
                gkdata.edgeStyle = varargin{n+1};
            case 'fontname'
                gkdata.fontName   = varargin{n+1};
            case 'fontsize'
                gkdata.fontSize   = varargin{n+1};
            case 'fontweight'
                gkdata.fontWeight = varargin{n+1};
            case 'textcolor'
                gkdata.textColor  = varargin{n+1};
            case 'horizontalalignment'
                gkdata.HorizontalAlignment = varargin{n+1};
            case 'verticalalignment'
                gkdata.VerticalAlignment   = varargin{n+1};
            case 'rotation'
                gkdata.Rotation   = varargin{n+1};
            case {'lorg','torg'}
                switch varargin{n+1}
                    case 1
                        gkdata.HorizontalAlignment = 'left';
                        gkdata.VerticalAlignment   = 'bottom';
                    case 2
                        gkdata.HorizontalAlignment = 'center';
                        gkdata.VerticalAlignment   = 'bottom';
                    case 3
                        gkdata.HorizontalAlignment = 'right';
                        gkdata.VerticalAlignment   = 'bottom';
                    case 4
                        gkdata.HorizontalAlignment = 'left';
                        gkdata.VerticalAlignment   = 'middle';
                    case 5
                        gkdata.HorizontalAlignment = 'center';
                        gkdata.VerticalAlignment   = 'middle';
                    case 6
                        gkdata.HorizontalAlignment = 'right';
                        gkdata.VerticalAlignment   = 'middle';
                    case 7
                        gkdata.HorizontalAlignment = 'left';
                        gkdata.VerticalAlignment   = 'top';
                    case 8
                        gkdata.HorizontalAlignment = 'center';
                        gkdata.VerticalAlignment   = 'top';
                    case 9
                        gkdata.HorizontalAlignment = 'right';
                        gkdata.VerticalAlignment   = 'top';
                end
        end
    end
end