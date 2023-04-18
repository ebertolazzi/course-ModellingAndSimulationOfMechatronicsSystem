function p = drawInit(figNum)
%DRAWINIT Set current figure, cleare it and set isotropic scaling
%
%History:
%   2019,May   - MB created
%
        
    narginchk(0,1)
    nargoutchk(0,1)
    
    if nargin > 0
        validateattributes(figNum, {'numeric'}, {'positive', 'integer','scalar'}); 
    end
    
    if nargin == 1
        figure(figNum); %set current figure and push it on top
    else
        figure;  % create new figure window
    end

    gkInit
    
    clf         % clear current figure
    hold on     % retains plots in the current axes
    axis equal  % use the same length for the data units along each axis

    if nargout > 0
        try
            p = get(gcf,'Number');
        catch
            p = gcf; % prior to R2014b
        end
    end
end

