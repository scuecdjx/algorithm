clc;clear;
sj0=load('sj.txt');
x=sj0(:,1:2:8);x=x(:);
y=sj0(:,2:2:8);y=y(:);
sj=[x y];%100���ص�����
d1=[70,40];%��ʼλ��
sj0=[d1;sj;d1];%102������
sj=sj0*pi/180;%��λ���ɻ��ȣ��������
d=zeros(102);%�������
for i=1:101    %101�ξ���
    for j=i+1:102%�������
        d(i,j)=6370*acos(cos(sj(i,1)-sj(j,1))*cos(sj(i,2))*cos(sj(j,2))+sin(sj(i,2))*sin(sj(j,2)));
    end
end
d=d+d';%������ת��
w=50;g=100;%wΪ��Ⱥ������gΪ�����Ĵ���
rand('state',sum(clock));%��ʼ�����������
for k=1:w%ͨ������Ȧ�㷨ѡȡ��ʼ��Ⱥ
    c=randperm(100);%����1~100��һ��ȫ����
    c1=[1 c+1 102];%���ɳ�ʼ��
    for t=1:102%�ò�ѭ�����޸�Ȧ
        flag=0;%�޸�Ȧ�˳���־
        for u=1:100
            for v=u+2:101
                if d(c1(u),c1(v))+d(c1(u+1),c1(v+1))<d(c1(u),c1(u+1))+d(c1(v),c1(v+1))
                    c1(u+1:v)=c1(v:-1:u+1);%�ݼ��󽻻�
                    flag=1;%�޸�Ȧ
                end
            end
        end
        if flag==0
            J(k,c1)=1:102;break%��¼�ϺõĽⲢ�˳���ǰѭ��
        end
    end
end
J(:,1)=0;J=J/102;%����������ת���ɡ�0,1�������ʵ������ת����Ⱦɫ�����
for k=1:g%�ò�ѭ�������Ŵ��㷨�Ĳ���
    A=J;%��������Ӵ�A�ĳ�ʼȾɫ��
    c=randperm(w);%�������潻�������Ⱦɫ���
    for i=1:2:w
        F=2+floor(100*rand(1));%������������ĵ�ַ
        temp=A(c(1),[F:102]);%�м�����ı���ֵ
        A(c(i),[F:102])=A(c(i+1),[F:102]);%�������
        A(c(i+1),F:102)=temp;
    end
    by=[];
    while ~length(by)
        by=find(rand(1,w)<0.1);%������������ĵ�ַ
    end
    B=A(by,:);%������������ĳ�ʼȾɫ��
    for j=1:length(by)
        bw=sort(2+floor(100*rand(1,3)));%�������������3����ַ
        B(j,:)=B(j,[1:bw(1)-1,bw(2)+1:bw(3),bw(1):bw(2),bw(3)+1:102]);%����λ��,�������
    end
    G=[J;A;B];%�������Ӵ���Ⱥ�����һ��
    [SG,ind1]=sort(G,2);%��Ⱦɫ�巭���1~102������ind1
    num=size(G,1);long=zeros(1,num);%·�����ȵĳ�ʼֵ
    for j=1:num
        for i=1:101
            long(j)=long(j)+d(ind1(j,i),ind1(j,i+1));%����ÿ��·������
        end
    end
    [slong,ind2]=sort(long);%��·�����ȴ�С��������
    J=G(ind2(1:w),:);%��ѡǰw���϶̵�·����Ӧ��Ⱦɫ��
end
path=ind1(ind2(1),:);flong=slong(1)%���·��������
xx=sj0(path,1);
yy=sj0(path,2);
plot(xx,yy,'-o')
        