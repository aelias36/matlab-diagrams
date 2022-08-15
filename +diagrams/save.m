function save(h_fig, name, location)
    prev = cd(location);
    saveas(h_fig, name, 'svg');
    saveas(h_fig, name, 'epsc'); % epsc for color
    %saveas(h_fig, name, 'pdf');
    cd(prev);
end
