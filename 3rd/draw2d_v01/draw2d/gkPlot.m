function col = gkPlot( x, y, varargin)  
%GKPLOT Wrapper to plot functiom
    global gkdata
    if isempty(gkdata) || ~isempty(varargin)
        hp = plot(x,y,varargin{:});
        c = get(hp,'Color');
    else
        plot(x,y,...
            'LineWidth',gkGet('LineWidth'),...
            'Color',gkGet('LineColor'),...
            'LineStyle',gkGet('LineStyle'));  
        c = gkGet('LineColor');
    end
    if nargout > 0
        col = c;
    end
end

