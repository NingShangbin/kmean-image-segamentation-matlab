clear;
clc;

%�������
%load('d:\kmeanjava\matlab-lab2-data.mat');%���ļ�
%save('d:\kmeanjava\matlab-lab2-data.txt','-ascii'); 

dataNum=256*256;%���ݵĸ���
dimension=1;%���ݵ�ά��
data=zeros(dataNum,dimension);


Kcluster=5;%��Ҫ����ĸ���
currentMean=zeros(Kcluster,dimension);%��ǰ��������
newMean=zeros(Kcluster,dimension);%�¾�������
clusterAssign=zeros(dataNum,1);%ÿ���������ڵľ���

%���ļ��ж�������
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

%��data�����ѡ��Kcluster��������Ϊ��ʼ�ľ�������
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

algorithmEnd=1;%�㷨������������
iter=0;
while(algorithmEnd==1)
    algorithmEnd=0;
    
    iter=iter+1
    %�����ݷ�����ʵľ�����
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

    %�����¾�������
    sumOfEachCluster=zeros(Kcluster,dimension);
    numOfEachCluster=zeros(Kcluster);
    for i=1:dataNum%��ÿ������ĺ������ݵ����
       numOfEachCluster(clusterAssign(i))= numOfEachCluster(clusterAssign(i))+1;
   
      sumOfEachCluster(clusterAssign(i),:)= sumOfEachCluster(clusterAssign(i),:)+data(i,:);
    
    end

    for k=1:Kcluster
      newMean(k,:)=sumOfEachCluster(k,:)./numOfEachCluster(k);
    end

    %�����㷨��������
    for k=1:Kcluster
       for(j=1:dimension)
            if not(newMean(k,j)==currentMean(k,j))
              algorithmEnd=1;
            end
       end
    end
    %���㷨������������¾������� 
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
title('ԭʼ����');
%allClusters=zeros(Kcluster,dataNum,dimension);
%coutEachCluster=zeros(Kcluster);
%for i=1:dataNum
    %����ĳ�������е����ݵ���
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
title('���ݾ���');




