syms theta1 theta2 theta3 l0

ezthet = [cos(theta1) -sin(theta1) 0;
    sin(theta1) cos(theta1) 0;
    0 0 1];
vec = [0;1;0];
two = ezthet*vec;

fin  = cross(two,[0;0;l0]);

eythet = [cos(theta2) 0 sin(theta2);
          0 1 0;
          -sin(theta2) 0 cos(theta2)];
three = ezthet*eythet*[1;0;0];
fin3 = cross(three,[0;0;l0]);
