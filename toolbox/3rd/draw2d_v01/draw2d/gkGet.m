function value = gkGet(name)
%GKGET get attribute to output primitives
    global gkdata
    if isempty(gkdata)
        error('Data table is empty.')
    end
    narginchk(1,1);
    nargoutchk(0,1);
    switch lower(name)
        %plot --------------------------
        case 'linestyle'
            value = gkdata.lineStyle;
        case {'linecolor'}
            value = gkdata.lineColor;
        case 'linewidth'
            value = gkdata.lineWidth;
        %fill --------------------------
        case 'facecolor'
            value = gkdata.faceColor;
        case 'edgecolor'
            value = gkdata.edgeColor;
        case 'edgewidth'
            value = gkdata.edgeWidth;
        case 'edgestyle'
            value = gkdata.edgeStyle;
        %text ---------------------------
        case 'fontname'
            value = gkdata.fontName;
        case 'fontsize'
            value = gkdata.fontSize;
        case 'fontweight'
            value = gkdata.fontWeight;
        case 'textcolor'
            value = gkdata.textColor;
        case 'horizontalalignment'
            value = gkdata.HorizontalAlignment;
        case 'verticalalignment'
            value = gkdata.VerticalAlignment;
        case 'rotation'
            value = gkdata.Rotation;
        otherwise
            error('Invalid name.')
    end
end