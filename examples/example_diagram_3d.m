zv = [0;0;0];

k = [0;0;1];
p_1 = diagrams.rot(k, -deg2rad(40))*[1.2;0;2];
p_2 = [0.4;1.6;0.8];

cone_center = k*k'*p_1;
A_11 = cross(k,p_1);
A_12 = -cross(k,A_11);

theta = subproblem1(p_1, p_2, k);

p_2_proj = p_2 - k*k'*p_2;
p_star = p_2_proj / norm(p_2_proj) * norm(A_11);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h_fig = diagrams.setup;

view(90,30)
hold on

diagrams.cone(zv, p_1, k);
diagrams.arrow(cone_center, cone_center+k, color = diagrams.colors.blue);
diagrams.arrow(zv, p_1, color = diagrams.colors.blue);
diagrams.arrow(zv, p_2, color = diagrams.colors.blue);
diagrams.arrow(zv, cone_center, LineStyle = '--');
diagrams.arrow(cone_center, cone_center + A_11);
diagrams.arrow(cone_center, cone_center + A_12);
diagrams.arrow(cone_center, cone_center + p_2_proj);
diagrams.dot(cone_center+p_star, color = diagrams.colors.red);

diagrams.angle_arc(cone_center + A_12*0.6, k, cone_center, theta);

diagrams.text(cone_center+A_11, "$k^\times p_1$", ...
    VerticalAlignment = 'top', HorizontalAlignment = 'left');
diagrams.text(cone_center+A_12*0.2, "$-k^{\times^2} p_1$", ...
    VerticalAlignment = 'middle', HorizontalAlignment = 'right', Margin = 20);
diagrams.text(p_1*0.7, "$p_1$", ...
    VerticalAlignment = 'bottom', HorizontalAlignment = 'left', ...
    color = diagrams.colors.blue, margin = 2);
diagrams.text(p_2, "$p_2$", ...
    VerticalAlignment = 'middle', HorizontalAlignment = 'left', ...
    color = diagrams.colors.blue);
diagrams.text(cone_center+k, "$k$", color = diagrams.colors.blue);
diagrams.text(cone_center+p_2_proj, "$A x_{LS}$", ...
    VerticalAlignment = 'bottom', HorizontalAlignment = 'center');
diagrams.text(cone_center+0.95*p_star, "$A x^\star$", ...
    VerticalAlignment = 'bottom', HorizontalAlignment = 'right', Margin = 0);
diagrams.text(cone_center+diagrams.rot(k, theta/2)*A_12*0.6, "$\theta$", ...
    VerticalAlignment = 'top', HorizontalAlignment = 'center'); 
diagrams.text(cone_center/2, "$p_{1_k}$", ...
    VerticalAlignment = 'middle', HorizontalAlignment = 'left'); 

diagrams.plane(cone_center, k, [0;1;0], 2);

diagrams.line(p_2, cone_center+p_2_proj, LineStyle = ':');
diagrams.perpendicular_mark(cone_center+p_2_proj, -p_2_proj, -k);

hold off
diagrams.redraw()
%% 
diagrams.save(h_fig, "example_diagram_3d", "./")

function theta = subproblem1(p1, p2, k)
%  p2 = diagrams.rot(k, theta)*p1

KxP = cross(k, p1);
A = [KxP -cross(k,KxP)];
x = A'*p2;
theta = atan2(x(1),x(2));
end