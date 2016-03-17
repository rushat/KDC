function [theta1,theta2] = padkah2(Et1,Et2,p,q,r)
l = p-r;
m = q-r;
n1 = Et1(4:6);
n2 = Et2(4:6);
alpha = ((n1'*n2)*n2'*l-n1'*m)/((n1'*n2)^2-1);
beta = ((n1'*n2)*n1'*m-n2'*l)/((n1'*n2)^2-1);
gamma = sqrt((norm(l)^2 - alpha^2 - beta^2-2*alpha*beta*(n1'*n2))/(norm(cross(n1,n2))^2));
z = gamma*cross(n1,n2)+alpha*n1 + beta*n2 ;
c = z+r;
theta2 = padkah1(Et2,p,c,r);
theta1 = padkah1(-Et1,q,c,r);
end