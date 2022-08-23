function cylinder_line(cylinder_1, cylinder_2, varargin)
    p1 = diagrams.utils.shorten_to_cylinder(cylinder_1, cylinder_2.p0);
    p2 = diagrams.utils.shorten_to_cylinder(cylinder_2, cylinder_1.p0);
    diagrams.line(p1,p2, varargin{:});
end

