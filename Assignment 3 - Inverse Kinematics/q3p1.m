clear all
clc


gst0 = [0 -1 0 610;
        1 0 0 720;
        0 0 1 2376;
        0 0 0 1];

    theta = [0.1 0.2 0.3 0.4 0.5 0.6 0.7];
% Spatial Jacobian
    
    q1 = [610;720;1346];
    q2 = [610;720;1346];
    q3 = [610;720;1346];
    q4 = [610;720+45;1346+550];
    q5 = [610;720;1346+550];
    q6 = [610;720;1346+850];
    q7 = [610;720;1346+850];
    
    om1 = [0;0;1];
    om2 = [-1;0;0];
    om3 = [0;0;1];
    om4 = [-1;0;0];
    om5 = [0;0;1];
    om6 = [-1;0;0];
    om7 = [0;0;1];
    
    v1 = -cross(om1,q1);
    v2 = -cross(om2,q2);
    v3 = -cross(om3,q3);
    v4 = -cross(om4,q4);
    v5 = -cross(om5,q5);
    v6 = -cross(om6,q6);
    v7 = -cross(om7,q7);
    
    
eta(:,1) = [v1;om1];
eta(:,2) = [v2;om2];
eta(:,3) = [v3;om3];
eta(:,4) = [v4;om4];
eta(:,5) = [v5;om5];
eta(:,6) = [v6;om6];
eta(:,7) = [v7;om7];


eta_d(:,1) = eta(:,1);
mul = eye(4);
for i=2:7
    mul = mul*expm(etacap(eta(:,i-1))*theta(i-1));
    adj = adjo(mul);
    eta_d(:,i) = adj*eta(:,i);
    
end

Jac = [eta_d(:,1) eta_d(:,2) eta_d(:,3) eta_d(:,4) eta_d(:,5) eta_d(:,6) eta_d(:,7)]






xs = [445.43 1123.20 2226.53 -0.29883 0.44566 0.84122 -0.06664]'; 
xd = [0463.20 1164.02 2220.58 -0.29301 0.41901 0.84979 0.12817]';

gs = [-0.81252 -0.15424 -0.56216 0.44543;
      -0.37847 -0.59390  0.70996 1.12320;
      -0.44337  0.78962  0.42418 2.22653;
       0        0        0       1       ];
   
qs = [xs(7) xs(4) xs(5) xs(6)];
qd = [xd(7) xd(4) xd(5) xd(6)];
qs_norm = norm(qs);

qs_inv = (1/(qs_norm)^2)*[qs(1) -qs(2) -qs(3) -qs(4)];
del_q = [qd(1)*qs_inv(1) - qd(2:4)*qs_inv(2:4)', qd(1)*qs_inv(2:4)+qs_inv(1)*qd(2:4) + cross(qd(2:4),qs_inv(2:4))];         

d_thet = 2*acos(del_q(1));
dw = del_q(2:4)/sin(d_thet/2);
dp = xd(1:3) - xs(1:3);
v = [dp; dw']
