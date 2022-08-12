function h_fig = setup()
    h_fig = figure(1);
    clf(h_fig,'reset')

    % https://journals.ieeeauthorcenter.ieee.org/create-your-ieee-journal-article/create-graphics-for-your-article/resolution-and-size/
    % Use a 2x scaling for everything
    figure_size = 2*[3.5 5];
    
    set(h_fig,'Visible','on')
    set(h_fig,'color','w');
    
    set(h_fig, "Units", "inches")
    pos_old = h_fig.Position;
    if ~all(pos_old(3:4) == figure_size)
        set(h_fig, "Position", [pos_old(1:2)-figure_size+pos_old(3:4) figure_size])
    end
    set(h_fig, "Units", "pixels")
    findfigs

    set(h_fig, 'renderer', 'painters')
    axis equal tight off
    camproj('perspective')

    
    % Make axes fill figure (no margins)
    ax = gca;
    set(ax, 'Position', [0 0 1 1]);
    
    h_fig.UserData = {};
    set(h_fig,'KeyPressFcn',@(~,~)diagrams.redraw());
    
end