function h = plot3_mat(mat, varargin)
    h = plot3(mat(1,:),mat(2,:),mat(3,:), 'k', 'LineWidth',1.5, varargin{:});
end