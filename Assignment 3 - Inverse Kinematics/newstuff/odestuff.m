function  q_dot = odestuff(t,q)
 q0 =  [0.1 0.2 0.3 0.4 0.5 0.6 0.7]';
 global eta;
% q1 = [610;720;1346];
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
% eta = zeros(6,7);
% eta(:,1) = [v1;om1];
% eta(:,2) = [v2;om2];
% eta(:,3) = [v3;om3];
% eta(:,4) = [v4;om4];
% eta(:,5) = [v5;om5];
% eta(:,6) = [v6;om6];
% eta(:,7) = [v7;om7];
 Jac = Jacob(q,eta);
 xs = FK(q,eta);
 xd = [463.20 1164.02 2220.58 -0.29301 0.41901 0.84979 0.12817]';
 e(1:3) = xd(1:3)-xs(1:3);
 
 qs = [xs(7) xs(4) xs(5) xs(6)];
 qd = [xd(7) xd(4) xd(5) xd(6)];
 qs_norm = norm(qs);

 qs_inv = (1/(qs_norm)^2)*[qs(1) -qs(2) -qs(3) -qs(4)];
 del_q = [qd(1)*qs_inv(1) - qd(2:4)*qs_inv(2:4)', qd(1)*qs_inv(2:4)+qs_inv(1)*qd(2:4) + cross(qd(2:4),qs_inv(2:4))];
 e(4:6) = [del_q(2) del_q(3) del_q(4)];
 


% gain
K1 = 1;
K2 = 1;
K3 = 1;
K4 = 1;
K5 = 1;
K6 = 1;
K_e = [K1*e(1) K2*e(2) K3*e(3) K4*e(4) K5*e(5) K6*e(6)]';

q_dot = Jac'*K_e;
end


