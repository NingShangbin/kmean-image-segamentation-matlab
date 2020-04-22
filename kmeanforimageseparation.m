clear;
clc;

%定义变量
%load('d:\kmeanjava\matlab-lab2-data.mat');%读文件
%save('d:\kmeanjava\matlab-lab2-data.txt','-ascii'); 

dataNum=256*256;%数据的个数
dimension=1;%数据的维数
data=zeros(dataNum,dimension);


Kcluster=5;%需要聚类的个数
currentMean=zeros(Kcluster,dimension);%当前聚类中心
newMean=zeros(Kcluster,dimension);%新聚类中心
clusterAssign=zeros(dataNum,1);%每个数据所在的聚类

%从文件中读入数据
%data=load('d:\kmeanjava\matlab-lab2-data.txt');
% data1=imread('D:\Program Files\MATLAB\R2009a\toolbox\images\imdemos\cameraman.tif');
data1=imread('cameraman.tif');
data2=im2double(data1);
for i=1:256
    for j=1:256
       data((i-1)*256+j)=data2(i,j);
    end 
end
%for i=1:dataNum
   % data(i,:)=rand(1:dimension);
%end

%从data中随机选择Kcluster个数据作为初始的聚类中心
randArray=zeros(Kcluster,1);
randArray(1)=round(dataNum*rand());
for i=2:Kcluster
   sign=1; 
   while(sign==1) 
       sign=0;
       mean=round(dataNum*rand());
       for j=1:i-1
            if(mean==randArray(j))
                 sign=1
            end
       end
        
   end
   randArray(i)=mean;
end
for i=1:Kcluster
    
        currentMean(i,:)=data(randArray(i),:);
    
end

algorithmEnd=1;%算法结束控制条件
iter=0;
while(algorithmEnd==1)
    algorithmEnd=0;
    
    iter=iter+1
    %把数据放入合适的聚类中
    difference=zeros(dimension,1); 
    distance=zeros(Kcluster,1); 
    for i=1:dataNum
     
         for j=1:Kcluster
         
          difference=data(i,:)-currentMean(j,:);
          distance(j)=difference*difference';
         end
      [minValue,index]=min(distance);
      clusterAssign(i)=index;
    end

    %计算新聚类中心
    sumOfEachCluster=zeros(Kcluster,dimension);
    numOfEachCluster=zeros(Kcluster);
    for i=1:dataNum%求每个据类的和与数据点个数
       numOfEachCluster(clusterAssign(i))= numOfEachCluster(clusterAssign(i))+1;
   
      sumOfEachCluster(clusterAssign(i),:)= sumOfEachCluster(clusterAssign(i),:)+data(i,:);
    
    end

    for k=1:Kcluster
      newMean(k,:)=sumOfEachCluster(k,:)./numOfEachCluster(k);
    end

    %计算算法结束条件
    for k=1:Kcluster
       for(j=1:dimension)
            if not(newMean(k,j)==currentMean(k,j))
              algorithmEnd=1;
            end
       end
    end
    %若算法不结束，则更新聚类中心 
    if(algorithmEnd==1)
        for k=1:Kcluster
             currentMean(k,:)=newMean(k,:);
        end
    end
end

%data1=im2uint8(data);

figure(1);
subplot(2,1,1);
imshow(data1);
%plot(data(:,1),data(:,2),'.');%source data
title('原始数据');
%allClusters=zeros(Kcluster,dataNum,dimension);
%coutEachCluster=zeros(Kcluster);
%for i=1:dataNum
    %计算某类中已有的数据点数
    %coutEachCluster(clusterAssign(i))=coutEachCluster(clusterAssign(i))+1;
    %allClusters(clusterAssign(i),coutEachCluster(clusterAssign(i)),:)=data(i,:);
%end
%figure(2);
subplot(2,1,2);
for i=1:dataNum
    if(clusterAssign(i)==1)
        data(i)=0;
    end
    if(clusterAssign(i)==2)
        data(i)=0.2;
    end
     if(clusterAssign(i)==3)
        data(i)=0.6;
     end
     if(clusterAssign(i)==4)
        data(i)=0.8;
    end
     if(clusterAssign(i)==5)
        data(i)=1;
    end
end

for i=1:256
    for j=1:256
       data2(i,j)=data((i-1)*256+j);
    end 
end
data1=im2uint8(data2);
imshow(data1);
%plot(allClusters(1,:,1),allClusters(1,:,2),'r.',allClusters(2,:,1),allClusters(2,:,2),'b.',allClusters(3,:,1),allClusters(3,:,2),'g.');
title('数据聚类');




