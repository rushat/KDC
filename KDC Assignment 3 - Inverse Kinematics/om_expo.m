function Em = om_expo(omegacap,theta)
    Em = eye(3) + omegacap*sin(theta) + omegacap^2*(1-cos(theta));
end