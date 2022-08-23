zv = [0;0;0];
ex = [1;0;0];
ey = [0;1;0];
ez = [0;0;1];

h_fig = diagrams.setup;

p = [0;1.5;0];
theta = wrapTo2Pi(subproblem1(p-ex,ex,  ez)*2);
p_int = diagrams.rot(ez, theta)*ex;

view(2)
hold on

diagrams.circle(zv, ez, 1);

diagrams.line(-ex, p);
diagrams.line(zv, p_int);

diagrams.angle_arc(ex*0.3, ez, zv, theta);
diagrams.angle_arc(-ex+ex*0.3, ez, -ex, theta/2);

diagrams.dot(p);
diagrams.dot(p_int);

AXIS_SIZE = 1.3;
diagrams.arrow(-AXIS_SIZE*ex, AXIS_SIZE*ex);
diagrams.arrow(-AXIS_SIZE*ey, 1.8*ey);

diagrams.text(p, "$j \frac{\omega_w T}{2} = j \tan \frac{\omega T}{2}$", ...
    VerticalAlignment="middle", Margin=12);
diagrams.text(p_int, "$z = e^{j \omega T}$", ...
    VerticalAlignment = "bottom", HorizontalAlignment="right");
diagrams.text(diagrams.rot(ez, theta/2)*ex*0.3, "$\omega T$", ...
    VerticalAlignment = "bottom", HorizontalAlignment="left");
diagrams.text(-ex+diagrams.rot(ez, theta/4)*ex*0.3, "$\frac{\omega T}2$", ...
    VerticalAlignment = "bottom", HorizontalAlignment="left");

hold off
diagrams.redraw()
%% 
diagrams.save(h_fig, "example_diagram_2d", "./")

function theta = subproblem1(p1, p2, k)
%  p2 = diagrams.rot(k, theta)*p1

KxP = cross(k, p1);

A = [KxP -cross(k,KxP)];
p = p2-k*k'*p1;

x = A'*p;

theta = atan2(x(1),x(2));

end