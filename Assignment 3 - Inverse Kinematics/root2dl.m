function F = root2dl(x)
x0 = 0;
z0 = 0.8;
theta0 = 0;
ldis = 0.2;
rdis = 0.2;
l1 = 0.5;
l2 = 0.5;
m = 80;
MI = 2;

F(1) = -l1*sin(x(1)) - l2*sin(x(1) + x(2)) - ldis;
F(2) = l1*cos(x(1)) + l2*cos(x(1) + x(2))-0.8;
end