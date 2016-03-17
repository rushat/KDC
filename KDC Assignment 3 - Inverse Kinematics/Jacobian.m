function Jac = Jacobian(theta,eta)
%#codegen
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
% eta = zeros(6,7);
% eta(:,1) = [v1;om1];
% eta(:,2) = [v2;om2];
% eta(:,3) = [v3;om3];
% eta(:,4) = [v4;om4];
% eta(:,5) = [v5;om5];
% eta(:,6) = [v6;om6];
% eta(:,7) = [v7;om7];

eta_d = zeros(6,7);
eta_d(:,1) = eta(:,1);
mul = eye(4);
for i=2:7
    mul = mul*expm(etacap(eta(:,i-1))*theta(i-1));
    adj = adjo(mul);
    eta_d(:,i) = adj*eta(:,i);
    
end

Jac = [eta_d(:,1) eta_d(:,2) eta_d(:,3) eta_d(:,4) eta_d(:,5) eta_d(:,6) eta_d(:,7)];




end