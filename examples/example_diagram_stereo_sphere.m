ex = [1;0;0];
ey = [0;1;0];
ez = [0;0;1];
zv = zeros(3,1);

h_fig = diagrams.setup();
view(-15,40)
hold on

S = diagrams.sphere(zv,1);

theta_list = linspace(0,pi, 13 + 2);
theta_list = theta_list(2:end-1);

for theta = theta_list
    axis_1 = diagrams.rot(ex, theta) * ez;
    center_1 = -ez/2 + diagrams.rot(ex, theta*2)*-ez/2;
    radius = norm(center_1 - (-ez));
    axis_2 = diagrams.rot(ez, pi/2)*axis_1;
    center_2 = diagrams.rot(ez, pi/2)*center_1;
    
    diagrams.sphere_arc(center_1, axis_1,  radius, zv, 1, false, color=diagrams.colors.red);
    diagrams.sphere_arc(center_1, axis_1,  radius, zv, 1, true, lineStyle='--',lineWidth= 0.5, color=diagrams.colors.dark_red);
    diagrams.sphere_arc(center_2, axis_2,  radius, zv, 1, false, color=diagrams.colors.green);
    diagrams.sphere_arc(center_2, axis_2,  radius, zv, 1, true, lineStyle='--',lineWidth= 0.5, color=diagrams.colors.dark_green);
end


hold off
diagrams.redraw();
camzoom(1.25)

%%
diagrams.save(h_fig, "example_diagram_stereo_sphere", "./")