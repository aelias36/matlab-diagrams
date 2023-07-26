function perpendicular_mark(c, v1, v2, varargin)

p = inputParser;
addOptional(p,'width',0.3);
parse(p,varargin{:});

W = p.Results.width;

v1 = v1 / norm(v1) * W;
v2 = v2 / norm(v2) * W;

path = c + [v1 v1+v2 v2];
plot3(path(1,:), path(2,:),path(3,:), 'k');
end
