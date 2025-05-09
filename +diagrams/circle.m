function h = circle(center, axis, radius, varargin)
    p = radius * diagrams.utils.perp_vector(axis);
    C = center + diagrams.utils.gen_circle(axis, p);
    
    h = diagrams.utils.plot3_mat(C, varargin{:});
end