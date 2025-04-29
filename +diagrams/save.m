function save(h_fig, name, location)
    if nargin < 1
        h_fig = gcf;
    end

    if nargin < 2
        [~, name, ~] = fileparts(matlab.desktop.editor.getActiveFilename);
    end

    if nargin < 3
        location = "output";
    end

    prev = cd(location);
    % saveas(h_fig, name, 'svg');
    saveas(h_fig, name, 'epsc'); % epsc for color
    %saveas(h_fig, name, 'pdf');
    cd(prev);
end
