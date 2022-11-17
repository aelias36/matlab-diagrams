function plane(center, perp, edge, radius)
if numel(radius)==1
    radius = radius*[1 1 1 1];
end

perp = perp / norm(perp);
edge = edge / norm(edge);

edge_2 = cross(perp, edge);

pts = center + [radius(1)*edge+radius(2)*edge_2 radius(1)*edge-radius(4)*edge_2 -radius(3)*edge-radius(4)*edge_2 -radius(3)*edge+radius(2)*edge_2 radius(1)*edge+radius(2)*edge_2];

plot3(pts(1,:), pts(2,:), pts(3,:), 'k')
end
