clc
clear
% define eta thetaC 
syms eta1 eta2 eta3 theta theta1 theta2 theta3 real
% define 0th configs 
syms gsl1_0 gsl2_0 gsl3_0 real
% define distances
syms l0 l1 l2 r0 r1 r2 real
% define masses and inertia moments
syms m1 Ix1 Iy1 Iz1 m2 Ix2 Iy2 Iz2 m3 Ix3 Iy3 Iz3 M real 
%define jacobian columns
syms eta_plus_1 eta_plusplus_2 eta_plusplus_1  eta_plusplusplus_2 eta_plusplusplus_1 eta_plusplusplus_3 real
%define Jacobians
syms J1 J2 J3 real
%define other variables
syms a b c d real
% define theta dots and coriolis matrix
syms theta1_dot theta2_dot theta3_dot theta_dot sum C real
% define variables for potential energy
syms V gsl1_theta gsl2_theta gsl3_theta g h1 h2 h3 N real
%% write values for etas
% assumption - all link lengths are 1 and all COMs are in the center

l0 = 1;
l1 = 1;
l2 = 1;
r0 = l0/2;
r1 = l1/2;
r2 = l2/2;

eta1 = [0;0;0;0;0;1];
eta2 = [0;-l0;0;-1;0;0];
eta3 = [0;-l0;l1;-1;0;0];
% eta = [eta1 eta2 eta3];
theta = [theta1 theta2 theta3];



%% define 0th configs 
gsl1_0 = [eye(3) [0;0;r0];0 0 0 1];
gsl2_0 = [eye(3) [0;r1;l0];0 0 0 1];
gsl3_0 = [eye(3) [0;l1+r2;l0];0 0 0 1];

  
%% find Jacobians - 
%jacobian 1 

  eta_plus_1 = inv(adjo(expm(etacap(eta1)*theta1)*gsl1_0))*eta1;
  J1 = [eta_plus_1 0 0];

%Jacobian 2 
   eta_plusplus_1 = inv(adjo(expm(etacap(eta1)*theta1)*expm(etacap(eta2)*theta2)*gsl2_0))*eta1;
   eta_plusplus_2 = inv(adjo(expm(etacap(eta2)*theta2)*gsl2_0))*eta2;
   J2 = [eta_plusplus_1 eta_plusplus_2 0];
  
%eta plus 3 
   eta_plusplusplus_1 = inv(adjo(expm(etacap(eta1)*theta1)*(expm(etacap(eta2)*theta2)*(expm(etacap(eta3)*theta3)))*gsl3_0))*eta1;
   eta_plusplusplus_2 = inv(adjo(expm(etacap(eta2)*theta2)*expm(etacap(eta3)*theta3)*gsl3_0))*eta2;
   eta_plusplusplus_3 = inv(adjo(expm(etacap(eta3)*theta3)*gsl3_0))*eta3;
   J3 = [eta_plusplusplus_1 eta_plusplusplus_2 eta_plusplusplus_3];
%



%% Define Mis
%all masses are 1 and inertia matrices are 1
m1 = 1;
m2 = 1;
m3 = 1;
Ix1 = 1;
Iy1 = 1;
Iz1 = 1;
Ix2 = 1;
Iy2 = 1;
Iz2 = 1;
Ix3 = 1;
Iy3 = 1;
Iz3 = 1;
M1 = [m1 0 0 0 0 0;
      0 m1 0 0 0 0;
      0 0 m1 0 0 0;
      0 0 0 Ix1 0 0;
      0 0 0 0 Iy1 0;
      0 0 0 0 0 Iz1];
M2 = [m2 0 0 0 0 0;
      0 m2 0 0 0 0;
      0 0 m2 0 0 0;
      0 0 0 Ix2 0 0;
      0 0 0 0 Iy2 0;
      0 0 0 0 0 Iz2];
M3 = [m3 0 0 0 0 0;
      0 m3 0 0 0 0;
      0 0 m3 0 0 0;
      0 0 0 Ix3 0 0;
      0 0 0 0 Iy3 0;
      0 0 0 0 0 Iz3];
  
  
%% inertia matrix - 

M = J1'*M1*J1 + J2'*M2*J2 + J3'*M3*J3;
%disp('M_1_1:')
%disp(simplify(M(1,1)));

%% coriolis matrix
theta_dot = [theta1_dot theta2_dot theta3_dot];
sum = 0 ;
for i = 1:3
    for j = 1:3
        sum = 0;
        for k = 1:3
            sum = sum + (diff(M(i,j),theta(k))+ diff(M(i,k),theta(j)) - diff(M(k,j),theta(i)))*theta_dot(k);
        end
        C(i,j) = 0.5*sum; 
    end
end
%disp('C_2_1:')
%disp(simplify(C(2,1)));

%% compute N
g = 9.8;
gsl1_theta = expm(etacap(eta1)*theta1)*gsl1_0;
gsl2_theta = expm(etacap(eta1)*theta1)*expm(etacap(eta2)*theta2)*gsl2_0;
gsl3_theta = expm(etacap(eta1)*theta1)*expm(etacap(eta2)*theta2)*expm(etacap(eta3)*theta3)*gsl3_0;

h1 = gsl1_theta(3,4);
h2 = gsl2_theta(3,4);
h3 = gsl3_theta(3,4);

V = m1*g*h1 + m2*g*h2 + m3*g*h3;
N(1) = diff(V,theta1);
N(2) = diff(V,theta2);
N(3) = diff(V,theta3);

%disp('N_3:')
%disp(simplify(N(3)));
%M
%C
%N
x0 = [0;0;0;0;0;0];
t = 0:0.1:5;

[t,x] = ode45('ode_dyn',t,x0);

plot(t,x(:,1),t,x(:,2),t,x(:,2),t,x(:,3),t,x(:,4),t,x(:,5))
legend('theta1','theta2','theta3','v1','v2','v3');