
clear all
clc

% initial condition
% q = x0,z0,t0,x_dot0,z_dot0,theta_dot0
x0 = 0;
z0 = 0.8;
t0 = 0;
x_dot0=0.1;
z_dot0= -1;
t_dot0 = 0.1;
q0 = [x0;z0;t0;x_dot0;z_dot0;t_dot0];

k1 = 1000;
k2 = 100;
k3 = 100;
D1 = 300;
D2 = 75;
D3 = 75;
m = 80;
MI = 2;
g = 9.81;

ldis = 0.2;
rdis = 0.2;

L1 = 0.5;
L2 = 0.5;

m = 80;
MI = 2;


tspan= [0,20];


[t,q] = ode45(@dyna,tspan,q0);

%plot
plot(t(:),q(:,1),t(:),q(:,2),t(:),q(:,3));
legend('x','z','theta');

%% part d

% from part a - 
% for left
for i=1:size(t)
xl(i) = q(i,1) +0.2;
zl(i) = q(i,2);
tl(i) = q(i,3);
[thet_lh(i,1),thet_lk(i,1),thet_la(i,1)] = IK(xl(i),zl(i),tl(i));


xr(i) = q(i,1) -0.2;
zr(i) = q(i,2);
tr(i) = q(i,3);
[thet_rh(i,1),thet_rk(i,1),thet_ra(i,1)] = IK(xr(i),zr(i),tr(i));


A(i,1) = -L1*cos(thet_la(i)) - L2*cos(thet_la(i) + thet_lk(i));
B(i,1) = -L1*sin(thet_la(i)) - L2*sin(thet_la(i) + thet_lk(i));
C(i,1) = -L1*cos(thet_ra(i)) - L2*cos(thet_ra(i) + thet_rk(i));

D(i,1) = -L1*sin(thet_ra(i)) - L2*sin(thet_ra(i) + thet_rk(i));
Q(i,1) = -L2*cos(thet_la(i) + thet_lk(i));
R(i,1) = -L2*sin(thet_la(i) + thet_lk(i));
S(i,1) = -L2*cos(thet_ra(i) + thet_rk(i));
T(i,1) = -L2*sin(thet_ra(i) + thet_rk(i));

E(i,1) = C(i)*B(i) - A(i)*D(i);
V(i,1) = Q(i)*B(i) - R(i)*A(i);
W(i,1) = S(i)*D(i) - T(i)*C(i);

stuff = [C(i)*V(i)/E(i) D(i)*V(i)/E(i) ((-V(i)-Q(i)*D(i)+R(i)*C(i))/2*E(i))-0.5;
        0 0 -0.5;
        -A(i)*W(i)/E(i) -B(i)*W(i)/E(i) ((W(i)+S(i)*B(i)-T(i)*A(i))/2*E(i))-0.5;
        0 0 -0.5];

    Fxdes = (-k2*q(i,1) - D2*q(i,4));
    Fzdes = (k1*(0.8 - q(i,2)) - D1*q(i,5)) + m*g;
    Ftdes = (-k3*q(i,3)-D3*q(i,6));
    
 final(:,i) = stuff*[Fxdes;Fzdes;Ftdes];

 
    figure(2);
    clf;
    axis([-0.5 0.5 0 1.7]);
    line([-ldis -ldis-L1*sin(thet_la(i))],[0 L1*cos(thet_la(i))],'color','b');
    line([rdis rdis-L1*sin(thet_ra(i))],[0 L1*cos(thet_ra(i))],'color','r');
    line([-ldis-L1*sin(thet_la(i)) q(i,1)],[L1*cos(thet_la(i)) q(i,2)],'color','b');
    line([rdis-L1*sin(thet_ra(i)) q(i,1)],[L1*cos(thet_ra(i)) q(i,2)],'color','r');
    line([q(i,1) q(i,1)-0.5*sin(q(i,3))],[q(i,2) q(i,2)+0.5*cos(q(i,3))],'color','g')
    pause(0.01);
end


figure;
plot(t(:),final(1,:),t(:),final(2,:),t(:),final(3,:),t(:),final(4,:));
legend('left knee','left hip','right knee','right hip');
 

