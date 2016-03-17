function [Qm] = quatmul(q1,q2)
a1 = q1(4);
b1 = q1(1);
c1 = q1(2);
d1 = q1(3);

a2 = q2(4);
b2 = q2(1);
c2 = q2(2);
d2 = q2(3);

Qm(1) = a1*b2 + b1*a2 + c1*d2 - d1*c2;
Qm(2) = a1*c2 - b1*d2 + c1*a2 + d1*b2;
Qm(3) = a1*d2 + b1*c2 - c1*b2 + d1*a2;
Qm(4) = a1*a2 - b1*b2 - c1*c2 - d1*d2;

end