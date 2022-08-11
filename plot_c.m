%%
%
%    ��ROC����,����������������������Χ�����
%
%%
function  [auc,eer] = plot_c( DisIntra ,DisInter )

num_DisIntra = length(DisIntra); %��ȡ���ں�������ĸ���
num_DisInter = length(DisInter);  %��ȡ��亣������ĸ���

%%  Genuine and imposter distributions
% figure;
x1 = 0:0.005:1;  %���䲽��Ϊ0.005
y1 = hist(DisIntra,x1);   %�������ڸ�����ֵ�ĸ���
yy1 = y1/num_DisIntra *100;  %���������ռ�����İٷֱ�
y2 = hist(DisInter,x1);   %������������ֵ�ĸ���
yy2 = y2/num_DisInter *100;  %���������ռ�����İٷֱ�
plot(x1,yy1,'r.-',x1,yy2,'g*-','LineWidth',1.5);
legend('Genuine','Impster','Location','northwest');
axis([0 0.6 0 17]);    %�涨���������ķ�Χ
xlabel('Matching distance');
ylabel('Percentage(%)');
title('Genuine and imposter distributions');

%% ����EER
FRR = [];
GAR = [];
FAR = [];
% д��1
% EER = [];
% threshold = 0:0.01:1;  %������ֵ
% for i = 1:length(threshold)
%     frr = sum(DisIntra > threshold(i))/num_DisIntra;   %����Ԥ����ֵ�� �ʹ���ľܾ���
%     FRR = [FRR frr];
%     gar = sum(DisIntra < threshold(i))/num_DisIntra;    %С��Ԥ����ֵ�� ��ȷ����
%     GAR = [GAR gar];
%     far = sum(DisInter < threshold(i))/num_DisInter;   %С����ֵ��  �ʹ���Ľ�����
%     FAR = [FAR far];
% %     if (abs(frr-far)<0.02) %frr��farֵ����Сʱ��Ϊ���
% %         eer = abs(frr+far)/2;
% %         EER = [EER eer];
% %     end
% end
% eer = min(EER);

% д��2
for threshold = 0:0.01:1
    frr = sum(DisIntra > threshold)/num_DisIntra;   %���ڴ���Ԥ����ֵ�ģ�����ľܾ���
    FRR = [FRR frr];
    gar = sum(DisIntra <= threshold)/num_DisIntra;   %����С��Ԥ����ֵ�ģ���ȷ����
    GAR = [GAR gar];
    far = sum(DisInter <= threshold)/num_DisInter;   %���С����ֵ�ģ��ʹ���Ľ�����
    FAR = [FAR far];
end

[~, EERindex]=min(abs(FAR-FRR));
eer = (FAR(EERindex)+FRR(EERindex))/2;

%% ��ROC     
% figure;
% plot(FAR,FRR,'-r','LineWidth',2);
% xlabel('FAR(%)');  %���������
% ylabel('FRR(%)');   %����ܾ���
% plot(FAR, FRR, 'r.-');
% plot(threshold,FRR,'r.-',threshold,FAR,'g*-','LineWidth',1.5);
% legend('FRR','FAR','Location','southwest');

%% FRR-FAR
semilogx(FAR, FRR,'-p');
axis([1e-05 1 0 0.1]);

xlabel('FAR(%)');  % ���������
ylabel('FRR(%)');  % ����ܾ���
title('ROC����ͼ');
%����С���ε����,����auc
auc = 1 - trapz(FAR,FRR);        %��ֵԽ��˵����ȷ��Խ��
%% GAR-FAR
% figure,
semilogx(FAR, GAR,'-p');
axis([1e-05 1 0.98 1]);

xlabel('FAR(%)');  % ���������
ylabel('GAR(%)');  % ��ȷ������
title('ROC����ͼ');
% hold on;
%%  ��ֱ��y = x,ֱ����ROC�Ľ��㼴ΪEER
% x=0:0.25:1; 
% y = x; 
% plot(x, y); 
% hold off;
% EER = intersect(FAR,FRR);

end
