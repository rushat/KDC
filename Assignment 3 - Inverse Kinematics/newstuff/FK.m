function xs = FK(theta,eta)
%#codegen
% Spatial Jacobian
gst0 = [0 -1 0 610;
        1 0 0 720;
        0 0 1 2376;
        0 0 0 1];
%     
%     q1 = [610;720;1346];
%     q2 = [610;720;1346];
%     q3 = [610;720;1346];
%     q4 = [610;720+45;1346+550];
%     q5 = [610;720;1346+550];
%     q6 = [610;720;1346+850];
%     q7 = [610;720;1346+850];
%     
%     om1 = [0;0;1];
%     om2 = [-1;0;0];
%     om3 = [0;0;1];
%     om4 = [-1;0;0];
%     om5 = [0;0;1];
%     om6 = [-1;0;0];
%     om7 = [0;0;1];
%     
%     v1 = -cross(om1,q1);
%     v2 = -cross(om2,q2);
%     v3 = -cross(om3,q3);
%     v4 = -cross(om4,q4);
%     v5 = -cross(om5,q5);
%     v6 = -cross(om6,q6);
%     v7 = -cross(om7,q7);
%     
%     eta= zeros(6,7);
% eta(:,1) = [v1;om1];
% eta(:,2) = [v2;om2];
% eta(:,3) = [v3;om3];
% eta(:,4) = [v4;om4];
% eta(:,5) = [v5;om5];
% eta(:,6) = [v6;om6];
% eta(:,7) = [v7;om7];

eta_d= zeros(6,7);
eta_d(:,1) = eta(:,1);
mul = eye(4);

for i=1:7
    mul = mul*expm(etacap(eta(:,i))*theta(i));    
end
F_K = mul*gst0;

Rot = F_K(1:3,1:3);
trans = F_K(1:3,4);
thet = acos((trace(Rot) - 1)/2);
om_vec = (1/(2*sin(thet)))*[Rot(3,2) - Rot(2,3);Rot(1,3) - Rot(3,1);Rot(2,1) - Rot(1,2)];

q0 = cos(thet/2);
q_vec = om_vec*sin(thet/2);


if q_vec(1)>0
    q0 = -q0;
    q_vec = -q_vec;
end

xs = [trans' q_vec' q0]';



end