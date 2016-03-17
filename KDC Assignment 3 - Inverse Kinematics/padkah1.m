function thet = padkah1(Et,p,q,r)
l = p-r;
m = q-r;
n = Et(4:6);

l_project = -(l - (n*n')*l)*-1;
m_project = -(m - (n*n')*m)*-1;
thet = atan2(n'*(cross(l_project,m_project)),l_project' * m_project);
end