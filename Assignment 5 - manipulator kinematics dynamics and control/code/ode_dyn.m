function dx = ode_dyn(t,x)
    theta1 = x(1);
    theta2 = x(2);
    theta3 = x(3);
    theta = [theta1;theta2;theta3];
    theta1_dot = x(4);
    theta2_dot = x(5);
    theta3_dot = x(6);
    theta_dot = [theta1_dot;theta2_dot;theta3_dot];
    
 dx = zeros(6,1);
    
    
 M =   [ cos(2*theta2 + theta3)/2 + (5*cos(2*theta2))/8 + cos(2*theta2 + 2*theta3)/8 + cos(theta3)/2 + 15/4,                   0,                   0;
                                                                                                          0,   cos(theta3) + 7/2, cos(theta3)/2 + 5/4;
                                                                                                          0, cos(theta3)/2 + 5/4,                 5/4];
 
 C = [ - (theta2_dot*(sin(2*theta2)/4 + 2*(cos(theta2 + theta3)/2 + cos(theta2))*(sin(theta2 + theta3)/2 + sin(theta2))))/2 - (theta3_dot*sin(theta2 + theta3)*(cos(theta2 + theta3)/2 + cos(theta2)))/2, -(theta1_dot*(sin(2*theta2 + theta3) + (5*sin(2*theta2))/4 + sin(2*theta2 + 2*theta3)/4))/2, -(theta1_dot*sin(theta2 + theta3)*(cos(theta2 + theta3)/2 + cos(theta2)))/2;
                                                                                                        (theta1_dot*(sin(2*theta2 + theta3) + (5*sin(2*theta2))/4 + sin(2*theta2 + 2*theta3)/4))/2,                                                                 -(theta3_dot*sin(theta3))/2,                                  -(sin(theta3)*(theta2_dot + theta3_dot))/2;
                                                                                                                        (theta1_dot*sin(theta2 + theta3)*(cos(theta2 + theta3)/2 + cos(theta2)))/2,                                                                  (theta2_dot*sin(theta3))/2,                                                                           0];
 
                                                                                                      
 N =   [ 0;
    - (49*cos(theta2 + theta3))/10 - (147*cos(theta2))/10;
    -(49*cos(theta2 + theta3))/10];

Kp = 15;
Kd = 15;
theta_des = [0;-pi/2;0];

tau = N + Kd*theta_dot - Kp*(theta_des - theta);

dx = [theta_dot;
        -inv(M)*(tau - C*theta_dot -N)];


end