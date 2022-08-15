function perpendicular_mark(c, v1, v2)
W = 0.3;

v1 = v1 / norm(v1) * W;
v2 = v2 / norm(v2) * W;

path = c + [v1 v1+v2 v2];
plot3(path(1,:), path(2,:),path(3,:), 'k');
end
