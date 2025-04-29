classdef arc < handle
    properties
        h_arrow
        center
        tail
        k
        theta
        C_plot
    end
    
    methods
        function obj = arc(tail, k, center, theta, varargin)
            % diagrams.utils.register_update(obj)

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
            obj.C_plot = diagrams.utils.plot3_mat(C, varargin{:});

            % % Use a 2D arrow for the head
            % arrow_head = center+diagrams.rot(k, theta)*(tail-center);
            % arrow_tail = center+diagrams.rot(k, theta- delta_theta)*(tail-center);
            % obj.h_arrow = diagrams.arrow(arrow_tail, arrow_head, 'LineStyle', 'none');

        end
        

    end
end