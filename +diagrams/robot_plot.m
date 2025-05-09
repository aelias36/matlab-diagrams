function robot_plot(kin, theta, varargin)
ex = [1;0;0];
ey = [0;1;0];
ez = [0;0;1];
zv = [0;0;0];

N = numel(kin.joint_type);

p = inputParser;
addOptional(p,'auto_scale',false);
addOptional(p,'unit_size',0.75);
addOptional(p,'cyl_half_length',0.5);
addOptional(p,'cyl_radius',0.25);
addOptional(p,'show_arrows',true);
addOptional(p,'show_arrow_labels',true);
addOptional(p,'show_joint_labels',true);
addOptional(p,'show_base_label',true);
addOptional(p,'show_task_label',true);
addOptional(p,'show_dots',true);
addOptional(p,'show_base_frame',true);
addOptional(p,'show_task_frame',true);
addOptional(p,'cylinder_color',[0 0 0]);
addOptional(p,'link_color',diagrams.colors.blue);
addOptional(p,'cylinder_show_list',1:N);
addOptional(p,'link_show_list',1:(N+1));
parse(p,varargin{:});

AUTO_SCALE = p.Results.auto_scale;
UNIT_SIZE = p.Results.unit_size;
CYL_HALF_LENGTH = p.Results.cyl_half_length;
CYL_RADIUS = p.Results.cyl_radius;
SHOW_ARROWS = p.Results.show_arrows;
SHOW_ARROW_LABELS = p.Results.show_arrow_labels;
SHOW_JOINT_LABELS = p.Results.show_joint_labels;
SHOW_BASE_LABEL = p.Results.show_base_label;
SHOW_TASK_LABEL = p.Results.show_task_label;
SHOW_DOTS = p.Results.show_dots;
SHOW_BASE_FRAME = p.Results.show_base_frame;
SHOW_TASK_FRAME = p.Results.show_task_frame;
CYLINDER_COLOR = p.Results.cylinder_color;
LINK_COLOR = p.Results.link_color;
CYLINDER_SHOW_LIST = p.Results.cylinder_show_list;
LINK_SHOW_LIST = p.Results.link_show_list;

if AUTO_SCALE
    L_char = max(vecnorm(kin.P)) / 4;
    UNIT_SIZE = UNIT_SIZE * L_char;
    CYL_HALF_LENGTH = CYL_HALF_LENGTH * L_char;
    CYL_RADIUS = CYL_RADIUS * L_char;
end


p_0i = NaN([3 N+1]);
p_0i(:,1) = kin.P(:,1);
R = eye(3);
h_i_0 = NaN([3 N]);
h_i_0(:,1) = kin.H(:,1);

% 0 frame
if SHOW_BASE_FRAME
    diagrams.arrow(zv, ex*UNIT_SIZE);
    diagrams.arrow(zv, ey*UNIT_SIZE);
    diagrams.arrow(zv, ez*UNIT_SIZE);
end

% Calculate fwd kin for all frames
for i = 1:N+1
    if i == 1
        p_0i(:,i) = R*kin.P(:,i);
    else
        if kin.joint_type(i-1) == 0 % revolute
            p_0i(:,i) = p_0i(:,i-1) + R*kin.P(:,i);    
        else % prismatic
            p_0i(:,i) = p_0i(:,i-1) + R*kin.P(:,i) + R*theta(i-1)*kin.H(:,i-1);
        end
    end

    if i <= N
        h_i_0(:,i) = R * kin.H(:,i);
        if  kin.joint_type(i) == 0 % revolute
            R = R*diagrams.rot(kin.H(:,i),theta(i));
        end
    end  
end

% Draw cylinders for joints
c = cell([N 1]);
for i = 1:N
    if any(i==CYLINDER_SHOW_LIST)
        extra_args = {};
    else
        extra_args = {'LineStyle', 'none', 'Marker', 'none'};
    end
    c{i} = diagrams.cylinder(p_0i(:,i), h_i_0(:,i), CYL_HALF_LENGTH, CYL_RADIUS, extra_args{:}, color=CYLINDER_COLOR);
end

% Connect cylinders with lines
for i = 1:N-1
    if any(i==LINK_SHOW_LIST)
        diagrams.cylinder_line(c{i}, c{i+1}, LineWidth=8, color=LINK_COLOR);
    end    
end
p_short = diagrams.utils.shorten_to_cylinder(c{end}, p_0i(:,N+1));
if any((N+1)==LINK_SHOW_LIST)
    diagrams.line(p_short, p_0i(:,N+1), LineWidth=8, color=LINK_COLOR);
end


% Dots at frames
if SHOW_DOTS
    for i = 1:N+1
        diagrams.dot(p_0i(:,i), 'color', diagrams.colors.red);
    end
end

% Label frames
if SHOW_BASE_LABEL
    diagrams.text([0;0;0],   "$\mathcal O _0$");
end
if SHOW_JOINT_LABELS
    for i = 1:N
        diagrams.text(p_0i(:,i),   "$\mathcal O _"+i+"$");
    end
end
if SHOW_TASK_LABEL
    diagrams.text(p_0i(:,N+1),   "$\mathcal O _T$");
end

% T frame
if SHOW_TASK_FRAME
    p_0T = p_0i(:,end);
    R_T = R;
    diagrams.arrow(p_0T, p_0T+R_T*ex*UNIT_SIZE);
    diagrams.arrow(p_0T, p_0T+R_T*ey*UNIT_SIZE);
    diagrams.arrow(p_0T, p_0T+R_T*ez*UNIT_SIZE);
end

% Arrows and labels for joint vectors
for i = 1:N
    if SHOW_ARROWS
        diagrams.arrow(p_0i(:,i) + h_i_0(:,i)*CYL_HALF_LENGTH,   p_0i(:,i) + h_i_0(:,i)*CYL_HALF_LENGTH+h_i_0(:,i)*UNIT_SIZE);
    end
    if SHOW_ARROW_LABELS
        diagrams.text(p_0i(:,i) + h_i_0(:,i)*CYL_HALF_LENGTH+h_i_0(:,i)*UNIT_SIZE, "$h_"+i+"$");
    end
end

end