# MATLAB Diagrams Library

Create paper-quality vector graphics geometry diagrams in 2D and 3D

### Capabilities
  * Angle Arc   
  * Arrow 
  * Cone 
  * Cylinder
  * Dot
  * Line
  * Perpendicular Mark
  * Plane
  * Sphere
  * Text

### Depends on
  * [ds2fig](https://www.mathworks.com/matlabcentral/fileexchange/43896-3d-data-space-coordinates-to-normalized-figure-coordinates-conversion)
  * [general robotics toolbox](https://github.com/rpiRobotics/general-robotics-toolbox)

## Examples
<p align="center">
  <img width="644" height="412" src="https://user-images.githubusercontent.com/4022499/184445889-66569f27-19f2-408c-acd6-d280295f489e.svg">
  <img width="645.333" height="768" src="https://user-images.githubusercontent.com/4022499/184707576-c31d84b5-294b-4a54-86f6-a3cbe002e479.svg">
  <img width="544" height="556" src="https://user-images.githubusercontent.com/4022499/185184780-5a7d1ec6-d80b-4ee8-b633-7d02305f479d.svg">
</p>

## 3D Example Code

```matlab
zv = [0;0;0];

k = [0;0;1];
p_1 = rot(k, -deg2rad(40))*[1.2;0;2];
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
diagrams.text(cone_center+rot(k, theta/2)*A_12*0.6, "$\theta$", ...
    VerticalAlignment = 'top', HorizontalAlignment = 'center'); 
diagrams.text(cone_center/2, "$p_{1_k}$", ...
    VerticalAlignment = 'middle', HorizontalAlignment = 'left'); 

diagrams.plane(cone_center, k, [0;1;0], 2);

diagrams.line(p_2, cone_center+p_2_proj, LineStyle = ':');
diagrams.perpendicular_mark(cone_center+p_2_proj, -p_2_proj, -k);

hold off
diagrams.redraw()

diagrams.save(h_fig, "example_diagram_3d", "./")
```

## 2D Example Code

```matlab
zv = [0;0;0];
ex = [1;0;0];
ey = [0;1;0];
ez = [0;0;1];

h_fig = diagrams.setup;

p = [0;1.5;0]
theta = wrapTo2Pi(subproblem1(p-ex,ex,  ez)*2);
p_int = rot(ez, theta)*ex;

view(2)
hold on

C = diagrams.gen_circle([0;0;1], [1;0;0]);
plot3(C(1,:), C(2,:), C(3,:), 'k');

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
diagrams.text(rot(ez, theta/2)*ex*0.3, "$\omega T$", ...
    VerticalAlignment = "bottom", HorizontalAlignment="left");
diagrams.text(-ex+rot(ez, theta/4)*ex*0.3, "$\frac{\omega T}2$", ...
    VerticalAlignment = "bottom", HorizontalAlignment="left");

hold off
diagrams.redraw()

diagrams.save(h_fig, "example_diagram_2d", "./")
```
## Robot Example Code

```matlab
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

R_T = rot(ez, deg2rad(-20))*...
      rot(ey, deg2rad(-20))*...
      rot(ex, deg2rad(30));

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

diagrams.save(h_fig, "example_robot", "./")

function v = normalize(v)
    v = v/norm(v);
end
```
