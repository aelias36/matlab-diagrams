classdef sphere < handle
    properties
        C
        r
        handle
    end
    
    methods
        function obj = sphere(C, r)
            diagrams.register_update(obj);

            obj.C=C; obj.r=r;
            C = obj.get_curve();
            obj.handle = plot3_mat(C);
        end
        
        function update(obj)
            curve = obj.get_curve();
            update_plot3_mat(obj.handle, curve);
        end

        function C = get_curve(obj)
            p_cam = campos(gca)';
            d = norm(obj.C - p_cam);
            x = 1/d;
            circle_center = obj.C + (p_cam-obj.C)/d*x;
            circle_radius = sqrt(obj.r^2 - x^2);

            radius_vec = cross([0;0;1], (obj.C - p_cam));
            radius_vec = radius_vec / norm(radius_vec);

            C = gen_circle((obj.C - p_cam)/d, (circle_center - p_cam) + radius_vec*circle_radius);
            C = C + p_cam;
        end


    end
end

function C = gen_circle(k,p)
    N = 100;
    C = NaN([3 N+1]);
    angles = linspace(0,2*pi,N+1);
    for i = 1:N
    C(:,i) = rot(k, angles(i))*p;
    end
    C(:,end)=C(:,1);
end

function h = plot3_mat(mat)
h = plot3(mat(1,:),mat(2,:),mat(3,:), 'k', 'LineWidth',1.5);
end

function update_plot3_mat(h, mat)
    set(h, 'XData', mat(1,:),'YData', mat(2,:),'ZData',mat(3,:));
end
