function gkInit
%GKINIT Initialize attributes to output primitives
    global gkdata

    if ~isempty(gkdata)
        return
    end
    
    % plot ------------------------
    gkdata.lineStyle = '-';
    gkdata.lineColor = 'k';
    gkdata.lineWidth = 1;  
    
    % fill ----------------------------
    gkdata.faceColor = 'r';
    gkdata.edgeColor = 'k';
    gkdata.edgeWidth = 1; 
    gkdata.edgeStyle = '-';    
    
    % text ----------------------------
    gkdata.fontName   = 'FixedWidth';
    gkdata.fontSize   = 12;
    gkdata.fontWeight = 'normal'; 
    gkdata.textColor  = 'k';
    gkdata.HorizontalAlignment = 'left';
    gkdata.VerticalAlignment   = 'bottom';
    gkdata.Rotation   = 0;
    
end