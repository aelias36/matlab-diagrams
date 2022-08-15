function L = line(t,h, varargin)
    p = inputParser;
    addParameter(p,'LineStyle','-');
    addParameter(p,'LineWidth',1.5);
    parse(p,varargin{:});

L = plot3([t(1) h(1)],[t(2) h(2)],[t(3) h(3)], '-k.', 'LineWidth',p.Results.LineWidth, 'MarkerSize',1, LineStyle=p.Results.LineStyle);
end
