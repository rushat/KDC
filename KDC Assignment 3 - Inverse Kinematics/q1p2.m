syms L1 L2 real
E = sym('E',[6 3],'real');
gst_d = sym('g',[4,4],'real');

w1 = [0 0 1];
w2 = [0 1 0];
w3 = [1 0 0];
p = [0 0 L1];
gst0 = [1 0 0 L2; 0 1 0 0; 0 0 1 L1; 0 0 0 1];

Eta(:,1) = [-cross(w1,p) w1];
Eta(:,2) = [-cross(w2,p) w2];
Eta(:,3) = [-cross(w3,p) w3];

pw = [L2 0 L1 1]';
q = gst_d*inv(gst0)*pw;
r = [0 0 L1]';
[theta1,theta2] = padkah2(Eta(:,1),Eta(:,2),pw(1:3),q(1:3),r);
Ecap = sym(zeros(4,4,3));
Ecap(:,:,1) = etacap(Eta(:,1));
Ecap(:,:,2) = etacap(Eta(:,2));

pw2 = [0 0 0 1]';
q = expm(-Ecap(:,:,2)*theta2)*expm(-Ecap(:,:,1)*theta1)*gst_d*inv(gst0)*pw2;

assume(theta1,'real');
assume(theta2,'real');
theta3 = padkah1(Eta(:,3),pw2(1:3),q(1:3),r);


theta1
theta2
theta3