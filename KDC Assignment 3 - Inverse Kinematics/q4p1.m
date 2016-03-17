
clear all
clc
% define variables
x0 = 0;
z0 = 0.8;
theta0 = 0;
ldis = 0.2;
rdis = 0.2;
l1 = 0.5;
l2 = 0.5;
m = 80;
MI = 2;


x0dot = 0.1;
z0dot = -1;
thet0dot = 0.1;

%left - soln 1 ------------------------------------------------bad
fun = @root2dl;
x_init = [0,0];
x = fsolve(fun,x_init);
xdeg_l1 = x*180/pi;

%left soln 2 - -----------------------------------------good
fun = @root2dl;
x_init = [1,1];
x = fsolve(fun,x_init);
xdeg_l2 = x*180/pi

%right soln 1 - -----------------------------------------------bad
fun = @root2dr;
x_init = [0,0];
x = fsolve(fun,x_init);
xdeg_r1 = x*180/pi;

%right soln 2 - ---------------------------------------------------good
fun = @root2dr;
x_init = [1,1];
x = fsolve(fun,x_init);
xdeg_r2 = x*180/pi