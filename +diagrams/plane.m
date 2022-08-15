function plane(center, perp, edge, radius)
perp = perp / norm(perp);
edge = edge / norm(edge);

edge_2 = cross(perp, edge);

pts = center + radius*[edge+edge_2 edge-edge_2 -edge-edge_2 -edge+edge_2 edge+edge_2];

plot3(pts(1,:), pts(2,:), pts(3,:), 'k')
end
