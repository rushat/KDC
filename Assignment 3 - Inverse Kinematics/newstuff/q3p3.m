q0 =  [0.1 0.2 0.3 0.4 0.5 0.6 0.7]';
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
    
global eta
eta = zeros(6,7);
eta(:,1) = [v1;om1];
eta(:,2) = [v2;om2];
eta(:,3) = [v3;om3];
eta(:,4) = [v4;om4];
eta(:,5) = [v5;om5];
eta(:,6) = [v6;om6];
eta(:,7) = [v7;om7];
% 
% Jac = Jacobian(theta,eta);
% xs = FK(theta,eta);
% 
% e = xd-xs;
% 
% % gain
% K = [1 1 1 1 1 1];
% K_e = K.*e;
% 
% q_dot = Jac'*K_e;

tspan = [0 5];
options = odeset('Maxstep',0.001);
[t,q] = ode45(@odestuff,tspan,q0,options);

plot(t,q)

