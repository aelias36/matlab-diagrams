h_fig = diagrams.setup;
view(-15,30)
hold on

% diagrams.angle_arc(tail, k, center, theta, vargin)
diagrams.angle_arc([0;-1;0], [0;0;1], [0;0;0], pi);

% diagrams.arrow(tail, head, vargin)
diagrams.arrow([2;0;0], [2;0;1]);

% diagrams.cone(p0,p,k)
diagrams.cone([4;0;0],[0;1;1],[0;0;1]);

% diagrams.cylinder(p0, k, half_length, radius)
c1 = diagrams.cylinder([0;-4;0], [0;0;1], 1/2, 1/2);
c2 = diagrams.cylinder([1;-3;1], [0;0;1], 1/5, 1/2);

% diagrams.cylinder_line(cylinder_1, cylinder_2, vargin)
diagrams.cylinder_line(c1, c2);

% diagrams.dot(loc, vargin)
diagrams.dot([2;-4;0]);

% diagrams.line(t, h, vargin)
diagrams.line([4;-4;0], [4;-4;1]);

% diagrams.perpendicular_mark(c, v1, v2)
diagrams.perpendicular_mark([0;-8;0], [0;1;0], [1;0;0]);

% diagrams.plane(center, perp, edge, radius)
diagrams.plane([2;-8;0], [1;0;0], [0;0;1], 1);

% diagrams.sphere(C,r);
diagrams.sphere([4;-8;0],1);

% diagrams.text(loc, txt, vargin);
diagrams.text([4;0;0], "Text\ $\int{abc}$");

% diagrams.circle(center, axis, radius)
diagrams.circle([0;-8;0], [0;0;1],  1);


hold off
diagrams.redraw();

%% 
diagrams.save(h_fig, "usage_diagram", "./")