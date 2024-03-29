classdef angle_arc < handle
    properties
        h_arrow
        center
        tail
        k
        theta
        C_plot
    end
    
    methods
        function obj = angle_arc(tail, k, center, theta, varargin)
            diagrams.utils.register_update(obj)

            assert(theta>0, "Theta must be a positive angle (theta = %f)", theta);
            obj.center = center;
            obj.tail = tail;
            obj.k = k;
            obj.theta = theta;

            % Create an arc in 3D for the body
            N = 100;
            delta_theta = 2*pi / N;
            angles = [0:delta_theta:theta theta];
            C = NaN([3 length(angles)]);
            for i = 1:length(angles)
                C(:,i) = center+diagrams.rot(k, angles(i))*(tail-center);
            end
            obj.C_plot = diagrams.utils.plot3_mat(C);

            % Use a 2D arrow for the head
            arrow_head = center+diagrams.rot(k, theta)*(tail-center);
            arrow_tail = center+diagrams.rot(k, theta- delta_theta)*(tail-center);
            obj.h_arrow = diagrams.arrow(arrow_tail, arrow_head, 'LineStyle', 'none');

        end
        
        function update(obj)
            N = 100;
            delta_theta = 2*pi / N;


            angles = [0:delta_theta:obj.theta obj.theta];
            C = NaN([3 length(angles)]);
            for i = 1:length(angles)
                C(:,i) = obj.center+diagrams.rot(obj.k, angles(i))*(obj.tail-obj.center);
            end
            diagrams.utils.plot3_mat_update(obj.C_plot, C);

            % Use a 2D arrow for the head
            obj.h_arrow.head = obj.center+diagrams.rot(obj.k, obj.theta)*(obj.tail-obj.center);
            obj.h_arrow.tail = obj.center+diagrams.rot(obj.k, obj.theta- delta_theta)*(obj.tail-obj.center);
            obj.h_arrow.update();
            
            % Arrowhead shouldn't be perfectly parallel to the circle
            % Instead, arrowhead needs to be rotated s.t.
            % front and back of arrowhead lie on the circle with perspective

            % Find the actual length between head and tail
            % Scale delta_theta so length is closer to actual head length
            % (Head length is 10pt, but place where it meets is at 7px)
            set(obj.h_arrow.an, 'Units', 'points');
            current_len = norm(obj.h_arrow.an.Position(3:4));
            set(obj.h_arrow.an, 'Units', 'normalized');
            arrow_tail = obj.center+diagrams.rot(obj.k, obj.theta- delta_theta*8/current_len)*(obj.tail-obj.center);
            obj.h_arrow.tail = arrow_tail;
            obj.h_arrow.update();

            % Pull back the length of the arc so it doesn't overlap with
            % the arrow head
            theta_adj = obj.theta - delta_theta*6/current_len;
            angles = [0:delta_theta:theta_adj theta_adj];
            C = NaN([3 length(angles)]);
            for i = 1:length(angles)
                C(:,i) = obj.center+diagrams.rot(obj.k, angles(i))*(obj.tail-obj.center);
            end
            diagrams.utils.plot3_mat_update(obj.C_plot, C);

        end


    end
end