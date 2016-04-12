
clear all
clc

l1 = sym('l1', 'real');
l2 = sym('l2','real');
theta1 = sym('theta1', 'real');
theta2 = sym('theta2','real');
theta3 = sym('theta3','real');

q = [0 0 l1];
gst0= [1 0 0 l2;
        0 1 0 0;
        0 0 1 l1;
        0 0 0 1];
om1 = [0;0;1];

OM1 = [0 -om1(3) om1(2) ; om1(3) 0 -om1(1) ; -om1(2) om1(1) 0 ];
om1cross = -cross(om1,q)';
et1 = [OM1 om1cross;0 0 0 0];
expo1 = expm(et1*theta1);

om2 = [0;1;0];

OM2=[0 -om2(3) om2(2) ; om2(3) 0 -om2(1) ; -om2(2) om2(1) 0 ];
om2cross = -cross(om2,q)';
et2 = [OM2 om2cross;0 0 0 0];
expo2 = expm(et2*theta2);

om3 = [1;0;0];

OM3 = [0 -om3(3) om3(2) ; om3(3) 0 -om3(1) ; -om3(2) om3(1) 0 ];
om3cross = -cross(om3,q)';
et3 = [OM3 om3cross;0 0 0 0];
expo3 = expm(et3*theta3);



% 
% et1 = et_expo(om1,theta1,q);
% et2 = et_expo(om2,theta2,q);
% et3 = et_expo(om3,theta3,q);
% 
gsttheta = expo1*expo2*expo3*gst0;
gsttheta = simplify(gsttheta)
ginver = inv(gsttheta);
 
R = ginver(1:3,1:3);
p = ginver(1:3,4);
pcap = cap(p);
 
Ad = [R pcap*R; 0 0 0 R];
simplify(Ad);

Jst = [0 -l1*cos(theta1)  -l1*cos(theta2)*sin(theta1);
        0 -l1*sin(theta1) l1*cos(theta1)*cos(theta2);
        0 0 0;
        0 -sin(theta1) cos(theta1)*cos(theta2);
        0 cos(theta1) cos(theta2)*sin(theta1);
        1 0 -sin(theta2)];

 Jb  = Ad*Jst;
 Jb = simplify(Jb)
