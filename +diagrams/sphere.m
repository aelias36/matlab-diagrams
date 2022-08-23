classdef sphere < handle
    properties
        C
        r
        handle
    end
    
    methods
        function obj = sphere(C, r)
            diagrams.utils.register_update(obj);

            obj.C=C; obj.r=r;
            C = obj.get_curve();
            obj.handle = diagrams.utils.plot3_mat(C);
        end
        
        function update(obj)
            curve = obj.get_curve();
            diagrams.utils.plot3_mat_update(obj.handle, curve);
        end

        function C = get_curve(obj)
            p_cam = campos(gca)';
            d = norm(obj.C - p_cam);
            x = 1/d;
            circle_center = obj.C + (p_cam-obj.C)/d*x;
            circle_radius = sqrt(obj.r^2 - x^2);

            radius_vec = cross([0;0;1], (obj.C - p_cam));
            radius_vec = radius_vec / norm(radius_vec);

            C = diagrams.utils.gen_circle((obj.C - p_cam)/d, (circle_center - p_cam) + radius_vec*circle_radius);
            C = C + p_cam;
        end


    end
end