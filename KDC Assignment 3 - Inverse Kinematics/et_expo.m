function E = et_expo(omega,theta,q)

a = om_expo(cap(omega),theta);
b = (eye(3) - cap(omega))*(cross(omega,-cross(omega,q)))' + omega*omega'*((-cross(omega,q)))'*theta;
    E = [a b;0 0 0 1];
end

