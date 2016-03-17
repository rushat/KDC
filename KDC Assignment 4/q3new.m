fileID = fopen('poses.txt','r');
formatSpec = '%f';
sizeA = [8 Inf];
Data = fscanf(fileID,formatSpec,sizeA);
Data = Data';


scatter3(Data(:,2),Data(:,3),Data(:,4));
hold on;

quat = 