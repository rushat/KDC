function [final] = homo(theta_z,disp_z,disp_x,theta_x);
    homo1 = [cos(theta_z) -sin(theta_z) 0 0,
            sin(theta_z) cos(theta_z) 0 0,
            0 0 1 0,
            0 0 0 1];
    homo2 = [1 0 0 0,
            0 1 0 0,
            0 0 1 disp_z,
            0 0 0 1];
    homo3 = [1 0 0 disp_x,
            0 1 0 0,
            0 0 1 0,
            0 0 0 1];
    homo4 = [1 0 0 0,
            0 cos(theta_x) -sin(theta_x) 0,
            0 sin(theta_x) cos(theta_x) 0,
            0 0 0 1];
    final = homo1*homo2*homo3*homo4;
end    