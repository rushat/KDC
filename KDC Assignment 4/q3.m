fileID = fopen('poses.txt','r');
formatSpec = '%f';
sizeA = [8 Inf];
Data = fscanf(fileID,formatSpec,sizeA);
Data = Data';


scatter3(Data(:,2),Data(:,3),Data(:,4));
hold on;


xyz = [Data(:,2),Data(:,3),Data(:,4)];
 r0=mean(xyz);
 xyz=bsxfun(@minus,xyz,r0);
 [~,~,V]=svd(xyz,0);
 
 for t = [1:size(Data)] 
  r(t,:) = r0 + 0.05*t*V(:,1)';
 end
 
 plot3(r(:,1),r(:,2),r(:,3))
 
 
 