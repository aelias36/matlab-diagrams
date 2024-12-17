function perpendicular_mark(c, v1, v2, opts)
    arguments
        c (3,1) double
        v1 (3,1) double
        v2 (3,1) double
        opts.width (1,1) double = 0.3
    end

    W = opts.width;

    v1 = v1 / norm(v1) * W;
    v2 = v2 / norm(v2) * W;

    path = c + [v1 v1+v2 v2];
    plot3(path(1,:), path(2,:), path(3,:), 'k');
end
