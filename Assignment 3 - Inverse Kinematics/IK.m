function [t_h,t_k,t_a] = IK(x,z,t)
l1 = 0.5;
l2 = 0.5;
r = sqrt(x^2+z^2);
alpha = acos((l1^2+l2^2-r^2)/(2*l1*l2));
t_k = pi-alpha;
beta = acos((l1^2-l2^2+r^2)/(2*l1*r));
t_a = atan2(z,x)-beta-pi/2;
t_h = -t+t_a+t_k;
end