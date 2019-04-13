% Use: �Ŵ�ģ���˻��㷨������
% ������������޸������� Box�����ӵ�����
% Cargo�����������
% order��Ҫ������װ�ش���
% 
% 
% ����� bestLoadOrder:����װ��
% author�� ���� 2 ��
clc; 
clear; 
close all; 
tic 
%% ����¼��
Box=[2.33 1.78 2.197 5000]; % �������� �������ߣ�����
Cargo=[0.94 0.68 0.39 0.249288 270.5 6;0.81 1.02 0.6 0.495720 896 2;... 
    0.81 1.02 0.70 0.578340 868 4;0.73 0.69 0.80 0.40296 240 2;... 
    1.20 0.72 0.72 0.622080 280 2;1.10 0.84 0.26 0.24024 80 1;... 
    0.80 0.74 0.72 0.426240 180 1;1.60 1.07 0.75 1.28400 774 12;... 
    1.19 1.11 1.08 1.426572 960 11;1.19 1.11 0.9 1.18810 800 10;... 
    1.40 1.16 1.20 1.948800 420 8;0.82 0.37 0.18 0.54612 40 5]; % ��������
%���ȣ�m�� ��ȣ�m�� �߶ȣ�m�� �����m^3�� ������kg�� ����
order=[6,3,11,7,8,5,1,2,4,9,10,12;];
cmax=300; %��ʹ�õ�����������
save Box Box 
save Cargo Cargo 
toc 
%% ģ���˻����
tic 
T=100; % ��ʼ�¶�
Tend=1e-3; % ��ֹ�¶�
L=5; % ���¶��µĵ���������������
q=0.8; %��������
G=100;
%% �Ŵ�����
Pc=0.9; %�������
Pm=0.05; %�������
popsize=20;
retain=10;
GGAP=0.9; %����
%% ��������
load Box 
load Cargo 
%% 
N=size(Cargo,1); % ��װ������� 
for i=1:popsize
  chrom(i,:)=randperm(N); %�������һ��װ��˳��
end
for i=1:popsize
  tempchrom=chrom(i,:);
  [RestSpace,LoadOrder]=IniOrder(tempchrom,Box,Cargo); 
  fitness(i)=FitFun(cmax,RestSpace,LoadOrder,Box,tempchrom,order); 
end
fitness=fitness';
%% ��������Ĵ��� Time 
Time=ceil(double(solve(['1000*(0.8)^x=',num2str(Tend)]))); %solve('1000*(0.8)^x=1e-3')����Ҳ����
count=0; %��������
Obj=[]; %Ŀ��ֵ�����ʼ��
track=[]; %ÿ��������·�߾����ʼ��
bestchrom=[];
%% ����
while T>Tend 
  count=count+1; %���µ�������
  temp=[];
  [temp ,index]=sort(fitness,'descend');
  chrom=chrom(index,:);
  chromone=chrom(1:retain,:);
  fitnessone=temp(1:retain,:);
 
  chromtwo=chrom(retain+1:end,:);
 
  %% �������
  SelCh=Recombin(chromtwo,Pc);
  %% ����
  SelCh=Mutate(SelCh,Pm);
  tempchrom=[];
  for i=1:size(SelCh,1)
    tempchrom=SelCh(i,:);
    [RestSpace,LoadOrder]=IniOrder(tempchrom,Box,Cargo);
    fitnesstwo(i,:)=FitFun(cmax,RestSpace,LoadOrder,Box,tempchrom,order);
  end
  for k=1:L 
  %% �����½�
    for j=1:(popsize-retain)
      newchrom(j,:)=randperm(N);
    end
    tempchrom=[];
    for i=1:(popsize-retain)
      tempchrom=newchrom(i,:);
      [RestSpace,LoadOrder]=IniOrder(tempchrom,Box,Cargo);
      newfitness(i,:)=FitFun(cmax,RestSpace,LoadOrder,Box,tempchrom,order);
    end
    newfitness=G-newfitness;
    for i=1:(popsize-retain)
      if newfitness(i,:)<fitnesstwo
         SelCh(i,:)=newchrom(i,:);
         fitnesstwo(i,:)=G-newfitness(i,:);
      elseif exp(-(newfitness(i,:)-fitnesstwo(i,:))/T)
         SelCh(i,:)=newchrom(i,:);
         fitnesstwo(i,:)=G-newfitness(i,:);
      % else %��ԭ��Ⱥ�ͽⲻ��,��������ģ���˻��ѡ��
      end
    end
  end
end
