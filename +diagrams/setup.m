function h_fig = setup(figure_type)
% diagrams.setup Set up the diagram figure window
%   h_fig = diagrams.setup() sets up the window for IEEE figures (3.5 in)
%   and returns a handle to the figure
%
%   h_fig = diagrams.setup("sagepub") sets up the window for Sage column
%   width (3 in)
%   h_fig = diagrams.setup("sagepub_half") sets up the window for half Sage
%   column width (3 in / 2 = 1.5 in)
%   h_fig = diagrams.setup([width height]) sets up a custom window (inches)
%   The window displayed will be twice this width and height

    if nargin < 1
        figure_type = "IEEE";
    end

    h_fig = figure(10);
    clf(h_fig,'reset')

    if all(size(figure_type)==[1 2])
        figure_size = 2*figure_type;
    elseif strcmpi(figure_type, "IEEE")
        % https://journals.ieeeauthorcenter.ieee.org/create-your-ieee-journal-article/create-graphics-for-your-article/resolution-and-size/
        % Use a 2x scaling for everything
        figure_size = 2*[3.5 5];
    elseif strcmpi(figure_type, "sagepub")
        % https://journals.sagepub.com/author-instructions/ijr
        % Use a 2x scaling for everything
        figure_size = 2*[3 4];
    elseif strcmpi(figure_type, "sagepub_half") % Half column, 12pt space (\hspace{12pt})
        figure_size = 2*[3-(1/6)/2 4]/2; % 1/6 in = 12pt
    elseif strcmpi(figure_type, "els_half") % Elsevier half page, 12pt space (\hspace{12pt})
        figure_size = 2*[6.5/2-(1/6)/2 4]; % 1/6 in = 12pt
    else
        error("Wrong figure type!")
    end
    
    set(h_fig,'Visible','on')
    set(h_fig,'color','w');
    
    set(h_fig, "Units", "inches")
    pos_old = h_fig.Position;
    if ~all(pos_old(3:4) == figure_size)
        set(h_fig, "Position", [pos_old(1:2)-figure_size+pos_old(3:4) figure_size])
    end
    set(h_fig, "Units", "pixels")
    findfigs

    set(h_fig, 'renderer', 'painters') % Forces vector graphics
    axis equal tight off
    camproj('perspective')

    % Make axes fill figure (no margins)
    ax = gca;
    set(ax, 'Position', [0 0 1 1]);
    
    h_fig.UserData = {};
    set(h_fig,'KeyPressFcn',@(~,~)diagrams.redraw());

    view(3);
end