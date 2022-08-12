function register_update(obj)
    h_fig = gcf;
    h_fig.UserData{end+1} = obj;
end