function L = line(t,h, varargin)
    p = inputParser;
    addParameter(p,'LineStyle','-');
    addParameter(p,'LineWidth',1.5);
    addParameter(p,'Color', [0 0 0]);
    addParameter(p,'Marker', 'o');
    parse(p,varargin{:});

L = plot3([t(1) h(1)],[t(2) h(2)],[t(3) h(3)], ...
    'LineWidth',p.Results.LineWidth, ...
    'Marker',p.Results.Marker, ...
    'MarkerSize',p.Results.LineWidth, ...
    LineStyle=p.Results.LineStyle, ...
    Color=p.Results.Color, ...
    MarkerFaceColor=p.Results.Color, ...
    MarkerEdgeColor='none');
end
