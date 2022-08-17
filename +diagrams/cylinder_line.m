function cylinder_line(cylinder_1, cylinder_2, varargin)
    p1 = shorten(cylinder_1, cylinder_2.p0);
    p2 = shorten(cylinder_2, cylinder_1.p0);
    diagrams.line(p1,p2, varargin{:});

end

function p_short = shorten(cylinder, p_ext)
    p_01 = p_ext - cylinder.p0;
    k = cylinder.k;
    p_01_proj = p_01 - k*k'*p_01;
    p_01_rad = p_01 / norm(p_01_proj) * cylinder.radius;
    if norm(k'*p_01_rad) < cylinder.half_length
        % Shorten line so it lines up with cylinder radius
        p_short = cylinder.p0 + p_01_rad;
    else
        % Shorten line so it lines up with cylinder top/bottom
        p_01_proj = k'*p_01;
        p_short = cylinder.p0 + p_01 / norm(p_01_proj) * cylinder.half_length;
    end
end