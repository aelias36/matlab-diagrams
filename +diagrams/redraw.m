function redraw()
    h_fig = gcf;
    update_list = h_fig.UserData;
    for i = 1:length(update_list)
        K = update_list{i};
        K.update();
    end
end    
