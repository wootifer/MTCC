%%
%
%    画ROC曲线,并返回曲线与两坐标轴所围的面积
%
%%
function  [eer] = calculate_eer( DisIntra ,DisInter )

num_DisIntra = length(DisIntra); %获取类内海明距离的个数
num_DisInter = length(DisInter);  %获取类间海明距离的个数

%% 计算EER
FRR = [];
GAR = [];
FAR = [];
% 写法1
% EER = [];
% threshold = 0:0.01:1;  %设置阈值
% for i = 1:length(threshold)
%     frr = sum(DisIntra > threshold(i))/num_DisIntra;   %大于预设阈值的 就错误的拒绝了
%     FRR = [FRR frr];
%     gar = sum(DisIntra < threshold(i))/num_DisIntra;    %小于预设阈值的 正确接受
%     GAR = [GAR gar];
%     far = sum(DisInter < threshold(i))/num_DisInter;   %小于阈值的  就错误的接受了
%     FAR = [FAR far];
% %     if (abs(frr-far)<0.02) %frr和far值相差很小时认为相等
% %         eer = abs(frr+far)/2;
% %         EER = [EER eer];
% %     end
% end
% eer = min(EER);

% 写法2
for threshold = 0:0.01:1
    frr = sum(DisIntra > threshold)/num_DisIntra;   %类内大于预设阈值的，错误的拒绝了
    FRR = [FRR frr];
    gar = sum(DisIntra < threshold)/num_DisIntra;   %类内小于预设阈值的，正确接受
    GAR = [GAR gar];
    far = sum(DisInter < threshold)/num_DisInter;   %类间小于阈值的，就错误的接受了
    FAR = [FAR far];
end

[~, EERindex]=min(abs(FAR-FRR));
eer = (FAR(EERindex)+FRR(EERindex))/2;

end
