classdef angle_arc
    properties
        arrow
        center
        tail
        k
        theta
    end
    
    methods
        function obj = angle_arc(tail, k, center, theta, varargin)
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
                C(:,i) = center+rot(k, angles(i))*(tail-center);
            end
            plot3_mat(C);

            % Use a 2D arrow for the head
            

            arrow_head = center+rot(k, theta)*(tail-center);
            arrow_tail = center+rot(k, theta- delta_theta)*(tail-center);
            obj.arrow = diagrams.arrow(arrow_tail, arrow_head, 'LineStyle', 'none');
        end
        
        function update(obj)
            N = 100;
            delta_theta = 2*pi / N;


            obj.arrow.update();
            % Arrowhead shouldn't be perfectly parallel to the circle
            % Instead, arrowhead needs to be rotated s.t.
            % front and back of arrowhead lie on the circle with perspective

            % Find the actual length between head and tail
            % Scale delta_theta so length is closer to actual head length
            % (Head length is 10pt, but place where it meets is at 7px)
            set(obj.arrow.an, 'Units', 'points');
            current_len = norm(obj.arrow.an.Position(3:4));
            set(obj.arrow.an, 'Units', 'normalized');
            arrow_tail = obj.center+rot(obj.k, obj.theta- delta_theta*8/current_len)*(obj.tail-obj.center);
            obj.arrow.tail = arrow_tail;
            obj.arrow.update();
        end


    end
end

function plot3_mat(mat)
plot3(mat(1,:),mat(2,:),mat(3,:), 'k', 'LineWidth',1.5)
end