ex = [1;0;0];
ey = [0;1;0];
ez = [0;0;1];
zv = [0;0;0];

UNIT_SIZE = 0.75;
CYL_HALF_LENGTH = 0.5;
CYL_RADIUS = 0.25;

p_01 = zv;
h_1  = ez;

p_12 = [0;1.5;1.2];
h_2  = normalize([1;0;-0.4]);

p_23 = [0;-.1;1];
h_3  = normalize([1;0.2;0.2]);

p_34 = [0;1.5;0.5];
h_4  = normalize([0.1;0.1;1]);

p_45 = [1.5;0;-0.5];
h_5  = normalize([1.5;-1;-0.5]);

p_56 = [0;1;0.5];
h_6  = normalize([1;-0.2;0]);

p_6T = [0.2;1;0.2];

R_T = diagrams.rot(ez, deg2rad(-20))*...
      diagrams.rot(ey, deg2rad(-20))*...
      diagrams.rot(ex, deg2rad(30));

p_02 = p_01 + p_12;
p_03 = p_02 + p_23;
p_04 = p_03 + p_34;
p_05 = p_04 + p_45;
p_06 = p_05 + p_56;
p_0T = p_06 + p_6T;

os_1 = 1;
os_2 = 0.5;
os_3 = 0.2;
os_4 = -0.2;
os_5 = 0.5;
os_6 = 0.4;

p_01_os = p_01 + h_1*os_1;
p_02_os = p_02 + h_2*os_2;
p_03_os = p_03 + h_3*os_3;
p_04_os = p_04 + h_4*os_4;
p_05_os = p_05 + h_5*os_5;
p_06_os = p_06 + h_6*os_6;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

h_fig = diagrams.setup;

view(30,20)
hold on

diagrams.arrow(zv, ex*UNIT_SIZE);
diagrams.arrow(zv, ey*UNIT_SIZE);
diagrams.arrow(zv, ez*UNIT_SIZE);

diagrams.arrow(p_0T, p_0T+R_T*ex*UNIT_SIZE);
diagrams.arrow(p_0T, p_0T+R_T*ey*UNIT_SIZE);
diagrams.arrow(p_0T, p_0T+R_T*ez*UNIT_SIZE);

diagrams.arrow(p_01 + 2*h_1*CYL_HALF_LENGTH, p_01 + 2*h_1*CYL_HALF_LENGTH+h_1*UNIT_SIZE);
diagrams.arrow(p_02 + h_2*CYL_HALF_LENGTH,   p_02 + h_2*CYL_HALF_LENGTH+h_2*UNIT_SIZE);
diagrams.arrow(p_03 + h_3*CYL_HALF_LENGTH,   p_03 + h_3*CYL_HALF_LENGTH+h_3*UNIT_SIZE);
diagrams.arrow(p_04 + h_4*CYL_HALF_LENGTH,   p_04 + h_4*CYL_HALF_LENGTH+h_4*UNIT_SIZE);
diagrams.arrow(p_05 + h_5*CYL_HALF_LENGTH,   p_05 + h_5*CYL_HALF_LENGTH+h_5*UNIT_SIZE);
diagrams.arrow(p_06 + h_6*CYL_HALF_LENGTH,   p_06 + h_6*CYL_HALF_LENGTH+h_6*UNIT_SIZE);

c1 = diagrams.cylinder(p_01 + h_1*CYL_HALF_LENGTH, h_1, CYL_HALF_LENGTH, CYL_RADIUS);
c2 = diagrams.cylinder(p_02, h_2, CYL_HALF_LENGTH, CYL_RADIUS);
c3 = diagrams.cylinder(p_03, h_3, CYL_HALF_LENGTH, CYL_RADIUS);
c4 = diagrams.cylinder(p_04, h_4, CYL_HALF_LENGTH, CYL_RADIUS);
c5 = diagrams.cylinder(p_05, h_5, CYL_HALF_LENGTH, CYL_RADIUS);
c6 = diagrams.cylinder(p_06, h_6, CYL_HALF_LENGTH, CYL_RADIUS);

diagrams.dot(p_01_os, 'color', diagrams.colors.red);
diagrams.dot(p_02_os, 'color', diagrams.colors.red);
diagrams.dot(p_03_os, 'color', diagrams.colors.red);
diagrams.dot(p_04_os, 'color', diagrams.colors.red);
diagrams.dot(p_05_os, 'color', diagrams.colors.red);
diagrams.dot(p_06_os, 'color', diagrams.colors.red);
diagrams.dot(p_0T, 'color', diagrams.colors.red);

diagrams.cylinder_line(c1, c2, LineWidth=8, color=diagrams.colors.blue)
diagrams.cylinder_line(c2, c3, LineWidth=8, color=diagrams.colors.blue)
diagrams.cylinder_line(c3, c4, LineWidth=8, color=diagrams.colors.blue)
diagrams.cylinder_line(c4, c5, LineWidth=8, color=diagrams.colors.blue)
diagrams.cylinder_line(c5, c6, LineWidth=8, color=diagrams.colors.blue)
diagrams.line(p_06+ey*CYL_HALF_LENGTH, p_0T, LineWidth=8, color=diagrams.colors.blue);

diagrams.text(p_01 + 2*h_1*CYL_HALF_LENGTH+h_1*UNIT_SIZE, "$h_1$");
diagrams.text(p_02 + h_2*CYL_HALF_LENGTH+h_2*UNIT_SIZE, "$h_2$");
diagrams.text(p_03 + h_3*CYL_HALF_LENGTH+h_3*UNIT_SIZE, "$h_3$");
diagrams.text(p_04 + h_4*CYL_HALF_LENGTH+h_4*UNIT_SIZE, "$h_4$");
diagrams.text(p_05 + h_5*CYL_HALF_LENGTH+h_5*UNIT_SIZE, "$h_5$");
diagrams.text(p_06 + h_6*CYL_HALF_LENGTH+h_6*UNIT_SIZE, "$h_6$");

diagrams.text(zv,   "$\mathcal O _0$", ...
    HorizontalAlignment='Center', margin=15);
diagrams.text(p_01_os,   "$\mathcal O _1$", ...
    VerticalAlignment = 'Bottom', HorizontalAlignment = 'Right', margin = 8);
diagrams.text(p_02_os,   "$\mathcal O _2$", ...
    VerticalAlignment = 'Middle', HorizontalAlignment = 'Left', margin = 15);
diagrams.text(p_03_os,   "$\mathcal O _3$", ...
    VerticalAlignment = 'Middle', HorizontalAlignment = 'Right', margin=10);
diagrams.text(p_04_os,   "$\mathcal O _4$", ...
    VerticalAlignment = 'Bottom', HorizontalAlignment = 'Center', margin=8);
diagrams.text(p_05_os,   "$\mathcal O _5$", ...
    VerticalAlignment = 'Middle', HorizontalAlignment = 'Left', margin=22);
diagrams.text(p_06_os,   "$\mathcal O _6$", ...
    VerticalAlignment = 'Top', HorizontalAlignment = 'Center', margin=25);

diagrams.text(p_0T, "$\mathcal O _T$");

hold off

diagrams.redraw()
%% 

diagrams.save(h_fig, "example_diagram_robot", "./")

function v = normalize(v)
    v = v/norm(v);
end