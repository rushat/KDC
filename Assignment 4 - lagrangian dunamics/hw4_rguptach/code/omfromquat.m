function w = omfromquat(q1,q2)
    w = [];
    q1_conj = [q1(1),-q1(2:4)]/(norm(q1)^2) ;
    dq = quatmul(q2,q1_conj);
    thet = 2*acos(dq(1));
    w = dq(2:4)/sin(thet/2);
    w = thet*w';
end