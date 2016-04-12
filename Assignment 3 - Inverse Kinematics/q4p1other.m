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

r = sqrt(z0^2+ldis^2)

alpha = acos((l1^2 + l2^2 - r^2)/2*l1*l2)
beta  = acos((r^2 + l1^2 - l2^2)/2*l1*r)

thet2_1 = (pi + alpha)*180/pi
thet2_2 = (pi - alpha)*180/pi

thet1_1 = (atan2(z0,ldis)+beta)*180/pi
thet1_2 = (atan2(z0,ldis)-beta)*180/pi

