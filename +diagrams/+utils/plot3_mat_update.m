function plot3_mat_update(h_plot, mat)
    set(h_plot, 'XData', mat(1,:), 'YData', mat(2,:), 'ZData', mat(3,:));
end