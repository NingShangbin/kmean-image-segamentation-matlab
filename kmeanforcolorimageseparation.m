clear;
clc;

%�������
%load('d:\kmeanjava\matlab-lab2-data.mat');%���ļ�
%save('d:\kmeanjava\matlab-lab2-data.txt','-ascii'); 

%���ļ��ж�������
% data1=imread('D:\Program Files\MATLAB\R2009a\toolbox\images\imdemos\onion.png');
data1=imread('onion.png');
s=size(data1);%����ͼ��Ĵ�С

row=s(1);%ͼ�����ص�����
col=s(2);%ͼ�����ص�����
dataNum=row*col;%���ݵĸ���
if length(s)==2
    dimension=1;%���ݵ�ά��
else
    dimension=s(3);%���ݵ�ά��
end
data=zeros(dataNum,dimension);
Kcluster=8;%��Ҫ����ĸ���
currentMean=zeros(Kcluster,dimension);%��ǰ��������
newMean=zeros(Kcluster,dimension);%�¾�������
clusterAssign=zeros(dataNum,1);%ÿ���������ڵľ���


%data=load('d:\kmeanjava\matlab-lab2-data.txt');

data2=im2double(data1);
for i=1:row
    for j=1:col
       data((i-1)*col+j,:)=data2(i,j,:);
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
title('ԭʼͼ��');
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
        data(i,1)=0.13;
        data(i,2)=0.11;
        data(i,3)=0.24;
    end
    if(clusterAssign(i)==2)
        data(i,1)=0.25;
        data(i,2)=0.28;
        data(i,3)=0.19;
    end
     if(clusterAssign(i)==3)
           data(i,1)=0.22;
        data(i,2)=0.14;
        data(i,3)=0.28;
     end
     if(clusterAssign(i)==4)
          data(i,1)=0.22;
        data(i,2)=0.34;
        data(i,3)=0.25;
    end
     if(clusterAssign(i)==5)
          data(i,1)=0.21;
        data(i,2)=0.16;
        data(i,3)=0.37;
     end
    if(clusterAssign(i)==6)
          data(i,1)=0.36;
        data(i,2)=0.13;
        data(i,3)=0.157;
    end
    if(clusterAssign(i)==7)
          data(i,1)=0.15;
        data(i,2)=0.19;
        data(i,3)=0.25;
    end
    if(clusterAssign(i)==8)
          data(i,1)=0.35;
        data(i,2)=0.27;
        data(i,3)=0.33;
    end
       if(clusterAssign(i)==9)
          data(i,1)=0.18;
        data(i,2)=0.29;
        data(i,3)=0.22;
    end
    if(clusterAssign(i)==10)
          data(i,1)=0.25;
        data(i,2)=0.17;
        data(i,3)=0.33;
    end
    
end

for i=1:row
    for j=1:col
       data2(i,j,:)=data((i-1)*col+j,:);
    end 
end
data1=im2uint8(data2);
imshow(data1);
%plot(allClusters(1,:,1),allClusters(1,:,2),'r.',allClusters(2,:,1),allClusters(2,:,2),'b.',allClusters(3,:,1),allClusters(3,:,2),'g.');
title('���ط���');
imwrite(data1,'output.png');%�ѷָ���ͼ�񱣴浽�ļ�




