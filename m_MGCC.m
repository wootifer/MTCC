clear;
close all;
clc;
M = 378;  % M ��ʾ���������ԣ��������
N = 20;   % N ��ʾÿ����������������
gb = Np_Gabor(8,6); %����6�������gabor�˲���

imgDataPath = 'F:\Code\NEW\PolyU\PolyU_bmp_ind\';

tic
%%  �������ļ��е�ͼƬ��ȡ����
% imgDataDir  = dir(imgDataPath);          % ���������ļ�
% k = 1;
% for i = 1:length(imgDataDir)
%     if(isequal(imgDataDir(i).name,'.')||... % ȥ��ϵͳ�Դ����������ļ���
%        isequal(imgDataDir(i).name,'..')||...
%        ~imgDataDir(i).isdir)                % ȥ�������в����ļ��е�
%            continue;
%     end
%     imgDir = dir([imgDataPath imgDataDir(i).name '/*.jpg']); 
%     for j =1:length(imgDir)                 % ��������ͼƬ
%         img = imread([imgDataPath imgDataDir(i).name '/' imgDir(j).name]);
%         im = img(:,:,1);
%         im = imresize(im,[128 128]);
%         im = normalize_image(im); % ͼ���һ��
%         Bocv_code{1,k} = imBOCVCode(im, gb);
%         k = k+1;
%     end    
% end

%% �������ļ��еĶ�ȡ����
image_list=dir([imgDataPath '*.bmp']);
for i=1:length(image_list)
    im_name = image_list(i).name;
    im = imread([imgDataPath im_name]);
    im = normalize_image(im); % ͼ���һ��
    im = im(:,:,1);
    if size(im,2) ~= 128
        im = imresize(im,[128 128]);
    end
    Templates{i}= ExtractFeature_Simp(im, gb);
end

save Templates Templates
toc

%%
T1_1 = cell(1, length(Templates));T1_2 = cell(1, length(Templates));
T1_3 = cell(1, length(Templates));T1_4 = cell(1, length(Templates));
T1_5 = cell(1, length(Templates));T1_6 = cell(1, length(Templates));
T1_7 = cell(1, length(Templates));T1_8 = cell(1, length(Templates));
T1_9 = cell(1, length(Templates));T1_10 = cell(1, length(Templates));
T1_11 = cell(1, length(Templates));T1_12 = cell(1, length(Templates));

for index = 1:length(Templates)
   T1_1{index} =  Templates{1,index}{1,1};T1_2{index} =  Templates{1,index}{1,2};
   T1_3{index} =  Templates{1,index}{1,3};T1_4{index} =  Templates{1,index}{1,4};
   T1_5{index} =  Templates{1,index}{1,5};T1_6{index} =  Templates{1,index}{1,6};
   T1_7{index} =  Templates{1,index}{1,7}; T1_8{index} =  Templates{1,index}{1,8};
   T1_9{index} =  Templates{1,index}{1,9}; T1_10{index} =  Templates{1,index}{1,10};
   T1_11{index} =  Templates{1,index}{1,11}; T1_12{index} =  Templates{1,index}{1,12};
end
%%
Index = create_palmprintIndex(M, 10, 10); %NΪż��
palmindex = reshape(Index',M*3,1);
mex perform_large_novel_structure.cpp
tic
1
[DisIntra1,DisInter1] = perform_large_novel_structure(T1_1,palmindex);
toc
tic
2
[DisIntra2,DisInter2] = perform_large_novel_structure(T1_2,palmindex);
toc
tic
3
[DisIntra3,DisInter3] = perform_large_novel_structure(T1_3,palmindex);
toc
tic
4
[DisIntra4,DisInter4] = perform_large_novel_structure(T1_4,palmindex);
toc
tic
5
[DisIntra5,DisInter5] = perform_large_novel_structure(T1_5,palmindex);
toc
tic
6
[DisIntra6,DisInter6] = perform_large_novel_structure(T1_6,palmindex);
toc
tic
7
[DisIntra7,DisInter7] = perform_large_novel_structure(T1_7,palmindex);
toc
tic
8
[DisIntra8,DisInter8] = perform_large_novel_structure(T1_8,palmindex);
toc
tic
9
[DisIntra9,DisInter9] = perform_large_novel_structure(T1_9,palmindex);
toc
tic
10
[DisIntra10,DisInter10] = perform_large_novel_structure(T1_10,palmindex);
toc
tic
11
[DisIntra11,DisInter11] = perform_large_novel_structure(T1_11,palmindex);
toc
tic
12
[DisIntra12,DisInter12] = perform_large_novel_structure(T1_12,palmindex);
toc
%%
%% �������ں�
% ���ں�������
T = 0.5;
Dis_Texture_Intra = (DisIntra1+DisIntra3+DisIntra5+DisIntra7+DisIntra9+DisIntra11)/6;
Dis_Texture_Trans_Intra = (DisIntra2+DisIntra4+DisIntra6+DisIntra8+DisIntra10+DisIntra12)/6;
DisIntra = T *  Dis_Texture_Intra + (1-T) * Dis_Texture_Trans_Intra;
save DisIntra DisIntra;
save Dis_Texture_Intra Dis_Texture_Intra;
save Dis_Texture_Trans_Intra Dis_Texture_Trans_Intra;

% ��亣������
Dis_Texture_Inter = (DisInter1+DisInter3+DisInter5+DisInter7+DisInter9+DisInter11)/6;
Dis_Texture_Trans_Inter = (DisInter2+DisInter4+DisInter6+DisInter8+DisInter10+DisInter12)/6;
DisInter = T *  Dis_Texture_Inter + (1-T) * Dis_Texture_Trans_Inter;
save DisInter DisInter;
save Dis_Texture_Inter Dis_Texture_Inter;
save Dis_Texture_Trans_Inter Dis_Texture_Trans_Inter;

%% ������ͼ
[auc,eer] = plot_c(DisIntra, DisInter);
fprintf('EER: %f\n',eer);
save eer eer
