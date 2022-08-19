classdef cylinder < handle
    properties
        line_1
        line_2
        p0
        k
        half_length
        radius
    end
    
    methods
        function obj = cylinder(p0, k, half_length, radius)
            diagrams.register_update(obj)

            obj.p0 = p0; obj.k = k;
            obj.half_length = half_length;
            obj.radius = radius;
            
           
            [V_1, V_2] = obj.line_pos();
            
            % Now plot
            radius_vec = radius*diagrams.perp_vector(k);
            C_pos = diagrams.gen_circle(k,  k*half_length+radius_vec);
            C_neg = diagrams.gen_circle(k, -k*half_length+radius_vec);
            plot3_mat(C_pos+p0)
            plot3_mat(C_neg+p0)
            obj.line_1 = line(V_1+p0+k*half_length, V_1+p0-k*half_length);
            obj.line_2 = line(V_2+p0+k*half_length, V_2+p0-k*half_length);
        end
        
        function update(obj)
            [V_1, V_2] = obj.line_pos();
            update_line(obj.line_1, V_1+obj.p0+obj.k*obj.half_length,...
                                    V_1+obj.p0-obj.k*obj.half_length);

            update_line(obj.line_2, V_2+obj.p0+obj.k*obj.half_length,...
                                    V_2+obj.p0-obj.k*obj.half_length);
        end

        function [V_1, V_2] = line_pos(obj)

            center_pos = obj.k*obj.half_length + obj.p0;
            p_cam = campos(gca)';
            
            p_cam_proj = p_cam  + obj.k*obj.k'*(center_pos-p_cam);
            
            
            d = norm(p_cam_proj - center_pos);
            phi = acos(obj.radius/d);
            
            p_center_closest = (p_cam_proj - center_pos);
            p_center_closest = p_center_closest/norm(p_center_closest);
            p_center_closest = p_center_closest * obj.radius;
            
            V_1 = diagrams.rot(obj.k, phi)*p_center_closest;
            V_2 = diagrams.rot(obj.k,-phi)*p_center_closest;
        end
    end
end

function L = line(t,h)
L = plot3([t(1) h(1)],[t(2) h(2)],[t(3) h(3)], '-k.', 'LineWidth',1.5, 'MarkerSize',1);
end

function update_line(L, t, h)
set(L,'XData',[t(1) h(1)],'YData',[t(2) h(2)],'ZData',[t(3) h(3)])
end

function plot3_mat(mat)
plot3(mat(1,:),mat(2,:),mat(3,:), 'k', 'LineWidth',1.5)
end
