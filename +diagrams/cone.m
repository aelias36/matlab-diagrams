classdef cone < handle
    properties
        line_1
        line_2
        p0
        p
        k
    end
    
    methods
        function obj = cone(p0, p, k)
            diagrams.utils.register_update(obj)

            obj.p0 = p0; obj.p = p; obj.k = k;
            
            [V_1, V_2] = obj.line_pos();
            
            C = diagrams.utils.gen_circle(k,p);
            diagrams.utils.plot3_mat(C+p0);
            obj.line_1 = diagrams.line(p0, V_1+p0);
            obj.line_2 = diagrams.line(p0, V_2+p0);
        end
        
        function update(obj)
            [V_1, V_2] = obj.line_pos();
            diagrams.utils.line_update(obj.line_1, obj.p0, V_1+obj.p0);
            diagrams.utils.line_update(obj.line_2, obj.p0, V_2+obj.p0);
        end

        function [V_1, V_2] = line_pos(obj)
            % do everything wrt. p_0, only use p_0 for plotting
            center = obj.k*obj.k'*obj.p;
            p_cam = campos(gca)';
            p_cam = p_cam -obj.p0; 
            
            % find equivalent camera position by scaling down (tip - camera) until
            % camera is on plane of top of cone
            
            cone_length = obj.k'*center;
            p_cam = p_cam * cone_length / (obj.k'*p_cam);
            p_cam_prog = (p_cam-center) - obj.k*obj.k'*(p_cam-center);
            
            r = norm(center -  obj.p);
            
            d = norm(p_cam_prog);
            phi = acos(r/d);
            
            theta_0 = subproblem1(obj.p, p_cam, obj.k);
            
            V_1 = diagrams.rot(obj.k,theta_0 + phi)*obj.p;
            V_2 = diagrams.rot(obj.k,theta_0 - phi)*obj.p;
        end
    end
end

function theta = subproblem1(p1, p2, k)
    %  p2 = diagrams.rot(k, theta)*p1
    
    KxP = cross(k, p1);
    A = [KxP -cross(k,KxP)];
    x = A'*p2;
    theta = atan2(x(1),x(2));
end