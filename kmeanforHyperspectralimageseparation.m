clear;
clc;



%从文件中读入数据
load('urban.mat');%读文件
data=x';%高光谱图像，行代表像素点数，列表示维度

row=Lines;%图像像素点行数
col=Columns;%图像像素点列数
dataNum=row*col;%数据的个数
dimension=L;%数据的维数



Kcluster=6;%需要聚类的个数

currentMean=zeros(Kcluster,dimension);%当前聚类中心

newMean=zeros(Kcluster,dimension);%新聚类中心

clusterAssign=zeros(dataNum,1);%每个数据所在的聚类




data=im2double(data);
data2=zeros(dataNum,3);

data3=zeros(row,col,3);

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

imagesc(reshape(data(:,80),[row,col]));
colormap gray;
%plot(data(:,1),data(:,2),'.');%source data
title('原始图像');
%allClusters=zeros(Kcluster,dataNum,dimension);
%coutEachCluster=zeros(Kcluster);
%for i=1:dataNum
    %计算某类中已有的数据点数
    %coutEachCluster(clusterAssign(i))=coutEachCluster(clusterAssign(i))+1;
    %allClusters(clusterAssign(i),coutEachCluster(clusterAssign(i)),:)=data(i,:);
%end
%figure(2);
figure(2);
for i=1:dataNum
    if(clusterAssign(i)==1)
        data2(i,1)=0.13;
        data2(i,2)=0.11;
        data2(i,3)=0.24;
    end
    if(clusterAssign(i)==2)
        data2(i,1)=0.25;
        data2(i,2)=0.28;
        data2(i,3)=0.99;
    end
     if(clusterAssign(i)==3)
           data2(i,1)=0.22;
        data2(i,2)=0.68;
        data2(i,3)=0.28;
     end
     if(clusterAssign(i)==4)
          data2(i,1)=0.22;
        data2(i,2)=0.34;
        data2(i,3)=0.25;
    end
     if(clusterAssign(i)==5)
          data2(i,1)=0.21;
        data2(i,2)=0.16;
        data2(i,3)=0.37;
     end
    if(clusterAssign(i)==6)
          data2(i,1)=0.81;
        data2(i,2)=0.13;
        data2(i,3)=0.157;
    end
    if(clusterAssign(i)==7)
          data2(i,1)=0.15;
        data2(i,2)=0.19;
        data2(i,3)=0.25;
    end
    if(clusterAssign(i)==8)
          data2(i,1)=0.35;
        data2(i,2)=0.27;
        data2(i,3)=0.33;
    end
       if(clusterAssign(i)==9)
          data2(i,1)=0.18;
        data2(i,2)=0.29;
        data2(i,3)=0.22;
    end
    if(clusterAssign(i)==10)
          data2(i,1)=0.25;
        data2(i,2)=0.17;
        data2(i,3)=0.33;
    end
    
end

for i=1:col
    for j=1:row
       data3(j,i,:)=data2((i-1)*row+j,:);
    end 
end
data1=im2uint8(data3);
imshow(data1);
%plot(allClusters(1,:,1),allClusters(1,:,2),'r.',allClusters(2,:,1),allClusters(2,:,2),'b.',allClusters(3,:,1),allClusters(3,:,2),'g.');
title('像素分类');
imwrite(data1,'output.png');%把分割后的图像保存到文件




