
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

%% part c

% from part a - 

thet_la = -48.4861*pi/180;
thet_lk =  68.8998*pi/180;
thet_ra = -20.4137*pi/180;
thet_rk =  68.8998*pi/180;


A = -L1*cos(thet_la) - L2*cos(thet_la + thet_lk);
B = -L1*sin(thet_la) - L2*sin(thet_la + thet_lk);
C = -L1*cos(thet_ra) - L2*cos(thet_ra + thet_rk);

D = -L1*sin(thet_ra) - L2*sin(thet_ra + thet_rk);
Q = -L2*cos(thet_la + thet_lk);
R = -L2*sin(thet_la + thet_lk);
S = -L2*cos(thet_ra + thet_rk);
T = -L2*sin(thet_ra + thet_rk);

E = C*B - A*D;
V = Q*B - R*A;
W = S*D - T*C;

% for i=1:size(t)
%     Fxdes(i) = (-k2*q(i,1) - D2*q(i,4));
%     Fzdes(i) = (k1*(0.8 - q(i,2)) - D1*q(i,5)) + m*g;
%     Ftdes(i) = (-k3*q(i,3)-D3*q(i,6));
% % end
% Fxdes = Fxdes';
% Fzdes = Fzdes';
% Ftdes = Ftdes';

Fxdes = (-k2*q(:,1) - D2*q(:,4));
Fzdes = (k1*(0.8 - q(:,2)) - D1*q(:,5)) + m*g;
Ftdes = (-k3*q(:,3)-D3*q(:,6));

stuff = [C*V/E D*V/E ((-V-Q*D+R*C)/2*E)-0.5;
        0 0 -0.5;
        -A*W/E -B*W/E ((W+S*B-T*A)/2*E)-0.5;
        0 0 -0.5];
 T=[];
 for i=1:size(Fxdes)
     
    T(:,i) = stuff*[Fxdes(i);
                    Fzdes(i);
                    Ftdes(i)];
 end
 
 figure;
 plot(t(:),T(1,:),t(:),T(2,:),t(:),T(3,:),t(:),T(4,:));
 legend('left knee','left hip','right knee','right hip');

 
 