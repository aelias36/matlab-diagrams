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
            diagrams.utils.register_update(obj)

            obj.p0 = p0; obj.k = k;
            obj.half_length = half_length;
            obj.radius = radius;
           
            [V_1, V_2] = obj.line_pos();
            
            % Now plot
            radius_vec = radius*diagrams.utils.perp_vector(k);
            C_pos = diagrams.utils.gen_circle(k,  k*half_length+radius_vec);
            C_neg = diagrams.utils.gen_circle(k, -k*half_length+radius_vec);
            diagrams.utils.plot3_mat(C_pos+p0);
            diagrams.utils.plot3_mat(C_neg+p0);
            obj.line_1 = diagrams.line(V_1+p0+k*half_length, V_1+p0-k*half_length);
            obj.line_2 = diagrams.line(V_2+p0+k*half_length, V_2+p0-k*half_length);
        end
        
        function update(obj)
            [V_1, V_2] = obj.line_pos();
            diagrams.utils.line_update(obj.line_1, V_1+obj.p0+obj.k*obj.half_length,...
                                    V_1+obj.p0-obj.k*obj.half_length);

            diagrams.utils.line_update(obj.line_2, V_2+obj.p0+obj.k*obj.half_length,...
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