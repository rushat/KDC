fileID = fopen('JointData.txt','r');
formatSpec = '%f';
sizeA = [7 Inf];
Data = fscanf(fileID,formatSpec,sizeA);
Data = Data';
fclose(fileID);

H_0_J1 = [0 -1 0 610,
            1 0 0 720,
            0 0 1 1346,
            0 0 0 1];
coord = [];
for i = 1:size(Data)
   theta_1 = Data(i,1); 
   theta_2 = Data(i,2);
   theta_3 = Data(i,3);
   theta_4 = Data(i,4);
   theta_5 = Data(i,5);
   theta_6 = Data(i,6);
   theta_7 = Data(i,7);

        
    H_J1_J2 = homo(theta_1, 0, 0, -pi/2); 
    H_J2_J3 = homo(theta_2, 0, 0, pi/2);
    H_J3_J4 = homo(theta_3, 550, 45, -pi/2);
    H_J4_J5 = homo(theta_4, 0, -45, pi/2);
    H_J5_J6 = homo(theta_5, 300, 0, -pi/2);
    H_J6_J7 = homo(theta_6, 0, 0, pi/2);
    H_J7_Tip = homo(theta_7, 180, 0, 0);

    trans = (H_0_J1)*(H_J1_J2)*(H_J2_J3)*(H_J3_J4)*(H_J4_J5)*(H_J5_J6)*(H_J6_J7)*(H_J7_Tip);
    coord(i,1) = trans(1,4);
    coord(i,2) = trans(2,4);
    coord(i,3) = trans(3,4);     
    
end
coordf = coord';
fileID = fopen('coordinates.txt','w');
fprintf(fileID,'%f %f %f\n',coordf);

scatter3(coord(:,1),coord(:,2),coord(:,3))

cross_a = [coord(4000,1),coord(4000,2),coord(4000,3)]-[coord(1000,1),coord(1000,2),coord(1000,3)];
cross_b = [coord(7000,1),coord(7000,2),coord(7000,3)]-[coord(4000,1),coord(4000,2),coord(4000,3)];

omega = cross(cross_a,cross_b);
omega_cap = omega/norm(omega)
