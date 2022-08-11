%%
%
%    ��ROC����,����������������������Χ�����
%
%%
function  [eer] = calculate_eer( DisIntra ,DisInter )

num_DisIntra = length(DisIntra); %��ȡ���ں�������ĸ���
num_DisInter = length(DisInter);  %��ȡ��亣������ĸ���

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
    gar = sum(DisIntra < threshold)/num_DisIntra;   %����С��Ԥ����ֵ�ģ���ȷ����
    GAR = [GAR gar];
    far = sum(DisInter < threshold)/num_DisInter;   %���С����ֵ�ģ��ʹ���Ľ�����
    FAR = [FAR far];
end

[~, EERindex]=min(abs(FAR-FRR));
eer = (FAR(EERindex)+FRR(EERindex))/2;

end
