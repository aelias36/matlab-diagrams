function robot_plot(kin, theta)
ex = [1;0;0];
ey = [0;1;0];
ez = [0;0;1];
zv = [0;0;0];

UNIT_SIZE = 0.75;
CYL_HALF_LENGTH = 0.5;
CYL_RADIUS = 0.25;

N = numel(kin.joint_type);

p_0i = NaN([3 N+1]);
p_0i(:,1) = kin.P(:,1);
R = eye(3);
h_i_0 = NaN([3 N]);
h_i_0(:,1) = kin.H(:,1);

% 0 frame
diagrams.arrow(zv, ex*UNIT_SIZE);
diagrams.arrow(zv, ey*UNIT_SIZE);
diagrams.arrow(zv, ez*UNIT_SIZE);

% Calculate fwd kin for all frames
for i = 1:N+1
 

    if i == 1
        p_0i(:,i) = R*kin.P(:,i);
    else
        p_0i(:,i) = p_0i(:,i-1) + R*kin.P(:,i);    
    end

    if i <= N
        h_i_0(:,i) = R * kin.H(:,i);
        R = R*diagrams.rot(kin.H(:,i),theta(i));
    end  
end

% Draw cylinders for joints
c = cell([N 1]);
for i = 1:N
    c{i} = diagrams.cylinder(p_0i(:,i), h_i_0(:,i), CYL_HALF_LENGTH, CYL_RADIUS);
end

% Connect cylinders with lines
for i = 1:N-1
    diagrams.cylinder_line(c{i}, c{i+1}, LineWidth=8, color=diagrams.colors.blue);
end
p_short = diagrams.utils.shorten_to_cylinder(c{end}, p_0i(:,N+1));
diagrams.line(p_short, p_0i(:,N+1), LineWidth=8, color=diagrams.colors.blue);

% Dots at frames
for i = 1:N+1
    diagrams.dot(p_0i(:,i), 'color', diagrams.colors.red);
end

% Label frames
diagrams.text([0;0;0],   "$\mathcal O _0$");
for i = 1:N
    diagrams.text(p_0i(:,i),   "$\mathcal O _"+i+"$");
end
diagrams.text(p_0i(:,N+1),   "$\mathcal O _T$");

% T frame
p_0T = p_0i(:,end)
R_T = R;
diagrams.arrow(p_0T, p_0T+R_T*ex*UNIT_SIZE);
diagrams.arrow(p_0T, p_0T+R_T*ey*UNIT_SIZE);
diagrams.arrow(p_0T, p_0T+R_T*ez*UNIT_SIZE);

% Arrows and labels for joint vectors
for i = 1:N
    diagrams.arrow(p_0i(:,i) + h_i_0(:,i)*CYL_HALF_LENGTH,   p_0i(:,i) + h_i_0(:,i)*CYL_HALF_LENGTH+h_i_0(:,i)*UNIT_SIZE);
    diagrams.text(p_0i(:,i) + h_i_0(:,i)*CYL_HALF_LENGTH+h_i_0(:,i)*UNIT_SIZE, "$h_"+i+"$");
end

end