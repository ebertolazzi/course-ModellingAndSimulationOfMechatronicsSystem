function gkText( x, y, str, varargin)
%GKTEXT Wrapper to text function
    global gkdata
    if isempty(gkdata) || ~isempty(varargin)
        text(x,y,str,varargin{:})
    else
        ht = text(x,y,str,...
            'FontName',gkGet('fontName'),...
            'FontSize',gkGet('FontSize'),...
            'FontWeight',gkGet('fontWeight'));
        set(ht,'Color',gkGet('textColor'));
        set(ht,'HorizontalAlignment',gkGet('HorizontalAlignment'));
        set(ht,'VerticalAlignment',gkGet('VerticalAlignment'));
        set(ht,'Rotation',gkGet('Rotation'));
    end
end

