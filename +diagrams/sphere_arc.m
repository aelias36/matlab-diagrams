classdef sphere_arc < handle
    properties
        sphere_C
        sphere_r
        p
        center
        C_plot
        axis
        is_back
    end
    methods
        function obj = sphere_arc(center, axis, radius, sphere_C, sphere_r, is_back, varargin)
            if nargin < 6
                is_back = false;
                varargin = {};
            end
            obj.is_back = is_back;

            diagrams.utils.register_update(obj)
            
            obj.sphere_C = sphere_C;
            obj.sphere_r = sphere_r;
            obj.p = radius * diagrams.utils.perp_vector(axis);
            obj.center = center;
            obj.axis = axis;
            
            obj.C_plot = diagrams.utils.plot3_mat([0;0;0], varargin{:});
            obj.update()
        end

        function update(obj)
            [h, d, circle_center, p_cam] = obj.get_edge_plane;

            [t, is_LS] = sp_4(h, obj.p, obj.axis, d-h'*obj.center);
            N = 100;
            delta_theta = 2*pi / N;

            if is_LS
                % Circle doesn't intersect with edge plane
                % So, show or hide the whole circle
                if xor(d - dot(h, obj.center) < 0, obj.is_back)
                    % Circle center is closer than plane
                    angles = [0:delta_theta:(2*pi) (2*pi)];
                else
                    % Circle center is farther than plane
                    angles = [];
                end
            else
                if xor(dot(obj.axis, cross(h, diagrams.rot(obj.axis, min(t))*obj.p)) < 0, obj.is_back)
                    angles = [min(t):delta_theta:max(t) max(t)];
                else
                    angles = [max(t):delta_theta:(min(t)+2*pi) (min(t)+2*pi)];
                end

            end


            C = NaN([3 length(angles)]);
            for i = 1:length(angles)
                C(:,i) = obj.center+diagrams.rot(obj.axis, angles(i))*obj.p;
            end
            diagrams.utils.plot3_mat_update(obj.C_plot, C);
        end

        function [h, d, circle_center, p_cam] = get_edge_plane(obj)
            p_cam = campos(gca)';
            d_cam = norm(obj.sphere_C - p_cam);
            %x = obj.sphere_r^2/d_cam;
            x = obj.sphere_r^2/d_cam;
            h = (p_cam-obj.sphere_C)/d_cam; % points towards camera

            circle_center = obj.sphere_C + h*x;
            d = dot(h, circle_center);
        end
    end
end

function [theta, is_LS] = sp_4(h, p, k, d)
% subproblem.sp_4  Subproblem 4: Circle and plane
%   theta = = subproblem.sp_4(h, p, k, d) finds theta such that
%       h'*rot(k,theta)*p = d
%   If there's no solution, minimize the least-squares residual
%       | h'*rot(k,theta)*p - d |
%
%   If the problem is well-posed, there may be 1 or 2 exact solutions, or 1
%   least-squares solution
%   theta1 and theta2 are column vectors of the solutions
%
%   [theta, is_LS] = subproblem.sp_4(h, p, k, d) also produces
%   a flag is_LS, which is true if theta is a least-squares solution
%
%   The problem is ill-posed if (p, k) or (h, k) are parallel
%
%   Inputs:
%       h: 3x1 vector with norm(h) = 1
%       p: 3x1 vector
%       k: 3x1 vector with norm(k) = 1
%       d: 1x1
%   Outputs:
%       theta: 1xN angle (in radians)
%           (N is the number of solutions)
%       is_LS: 1x1 boolean

A_11 = cross(k,p);
A_1 = [A_11 -cross(k,A_11)];
A = h'*A_1;

b = d - h'*k*(k'*p);

norm_A_2 = dot(A,A);

x_ls_tilde = A_1'*(h*b);

if norm_A_2 > b^2
    xi = sqrt(norm_A_2-b^2);
    x_N_prime_tilde = [A(2); -A(1)];

    sc_1 = x_ls_tilde + xi*x_N_prime_tilde;
    sc_2 = x_ls_tilde - xi*x_N_prime_tilde;

    theta = [atan2(sc_1(1), sc_1(2)) atan2(sc_2(1), sc_2(2))];
    is_LS = false;
else
    theta = atan2(x_ls_tilde(1), x_ls_tilde(2));
    is_LS = true;
end

end