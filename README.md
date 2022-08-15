# MATLAB Diagrams Library

Create paper-quality vector graphics geometry diagrams in 2D and 3D

### Capabilities
  * Angle Arc   
  * Arrow 
  * Cone 
  * Cylinder
  * Dot
  * Line
  * Perpendical Mark
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
