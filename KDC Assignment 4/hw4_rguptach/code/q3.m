fileID = fopen('poses.txt','r');
formatSpec = '%f';
sizeA = [8 Inf];
Data = fscanf(fileID,formatSpec,sizeA);
Data = Data';


% scatter3(Data(:,2),Data(:,3),Data(:,4));
% hold on;

% 
% xyz = [Data(:,2),Data(:,3),Data(:,4)];
%  r0=mean(xyz);
%  xyz=bsxfun(@minus,xyz,r0);
%  [~,~,V]=svd(xyz,0);
%  
%  for t = [1:size(Data)] 
%   r(t,:) = r0 + 0.05*t*V(:,1)';
%  end
%  
%  plot3(r(:,1),r(:,2),r(:,3))
quat(:,1) = Data(:,8);;
quat(:,2:4) = Data(:,5:7);

pos(:,1:3) = Data(:,2:4);
A = [];
B = [];
for i = 1:(length(Data)-1)
    del_t = Data(i+1,1) - Data(i,1);
    addl = eye(3)*del_t;
    R1 = quat2rotm(quat(i,:));
    R2 = quat2rotm(quat(i+1,:));
    addr = R1-R2;
    add = horzcat(addl,addr);
    A = vertcat(A,add);
    del_xb = [pos(i+1,1)-pos(i,1);pos(i+1,2)-pos(i,2);pos(i+1,3)-pos(i,3)];
    B = vertcat(B,del_xb);
end
    X = A\B;
    
    vel_com = X(1:3);
    pos_com = X(4:6);
    R = norm(pos_com);
    
%% 

D=[];
C=[];
om = [];
  for j = 1:(length(Data)-2)
      w1s = omfromquat(quat(j,:),quat(j+1,:));
      w2s = omfromquat(quat(j+1,:),quat(j+2,:));
      
      R2 = quat2rotm(quat(j+1,:));
      R3 = quat2rotm(quat(j+2,:));
      
      w1b = R2'*w1s;
      w2b = R3'*w2s;
%       w1b = [-w1b_cap(2,3);w1b_cap(1,3);-w1b_cap(1,2)]';
%       w2b = [-w2b_cap(2,3);w2b_cap(1,3);-w2b_cap(1,2)]';
      wb_dot = w2b-w1b;
      
      om = horzcat(om,w1b);
      
      M  = [w1b(1) w1b(2) w1b(3) 0 0;
          0 w1b(1) 0 w1b(2) w1b(3);
          0 0 w1b(1) 0 w1b(2) ];
      M_dot = [wb_dot(1) wb_dot(2) wb_dot(3) 0 0;
          0 wb_dot(1) 0 wb_dot(2) wb_dot(3);
          0 0 wb_dot(1) 0 wb_dot(2)];
      
      
      right_D = - [w1b(2)*w1b(3);
                  -w1b(1)*w1b(3);
                  wb_dot(3)];
      w1b_cap = cap(w1b);
      final_left_C = M_dot + w1b_cap*M;
      C = vertcat(C,final_left_C);
      D = vertcat(D,right_D);      
  end
  
  I_v = C\D;
  
  Itensor = [I_v(1) I_v(2) I_v(3);
      I_v(2) I_v(4) I_v(5);
      I_v(3) I_v(5) 1]
  I = eig(Itensor)
  
  
   for i = 1:length(Data)-1
        q1 = quat(i,:);
        q2 = quat(i+1,:);
        R1 = quat2rotm(q1);
        w1s = omfromquat(q1,q2);
        ang_mom_vector(i,:) = (R1*Itensor*R1'*w1s)';

    end
  
    avg_ang_mom = mean(ang_mom_vector);
    avg_ang_mom_norm=norm(avg_ang_mom);