clear;
close all;
clc;
% 初始化参数
Class_Num = 378;  % M 表示样本（测试）的类别数
train_size = 1;
test_size = 19;
total_size = train_size + test_size;  % N 表示每类样本的样本个数
% 构造滤波器
gb = Np_Gabor(8,6);
% 设置文件路径
train_path = 'F:\Code\NEW\PolyU\PolyU_tr_te\train_PolyU_1\';
test_path = 'F:\Code\NEW\PolyU\PolyU_tr_te\test_PolyU_19\';

%% 读取图片并编码,含有子文件夹的图片读取方法
% tic
% imgDataDir  = dir(imgDataPath);          % 遍历所有文件
% k = 1;
% for i = 1:length(imgDataDir)
%     if(isequal(imgDataDir(i).name,'.')||... % 去除系统自带的两个隐文件夹
%        isequal(imgDataDir(i).name,'..')||...
%        ~imgDataDir(i).isdir)                % 去除遍历中不是文件夹的
%            continue;
%     end
%     imgDir = dir([imgDataPath imgDataDir(i).name '/*.jpg']); 
%     for j =1:length(imgDir)                 % 遍历所有图片
%         img = imread([imgDataPath imgDataDir(i).name '/' imgDir(j).name]);
%         if size(img,1) ~= 128
%             img = imresize(img,[128 128]);
%         end
%         im = img(:,:,1);
%         im = normalize_image(im);
%         Palm_code{1,k} = imPalmCode(im, Gb);
%         k = k+1;
%     end    
% end
% toc
%% 不含子文件夹的读取方法
% 训练集图片读取并编码
tic
image_list_train=dir([train_path '*.bmp']);
Templates_train = cell(1, length(image_list_train));
for i=1:length(image_list_train)
    im_name = image_list_train(i).name;
    im = imread([train_path im_name]);
    im = normalize_image(im); % 图像归一化
    im = im(:,:,1);
    if size(im,2) ~= 128
        im = imresize(im,[128 128]);
    end
    Templates_train{i}= ExtractFeature_Simp(im, gb);
end
save Templates_train Templates_train
toc

%测试集文件读取并编码
tic
image_list_test=dir([test_path '*.bmp']);
Templates_test = cell(1, length(image_list_test));
for i=1:length(image_list_test)
    im_name = image_list_test(i).name;
    im = imread([test_path im_name]);
    im = normalize_image(im); % 图像归一化
    im = im(:,:,1);
    if size(im,2) ~= 128
        im = imresize(im,[128 128]);
    end    
    Templates_test{i}= ExtractFeature_Simp(im, gb);
end
save Templates_test Templates_test
toc
%% 使用K-NN算法实现分类
tic
true_num=0;
false_num=0;
for i = 1:length(Templates_test)
    T1 =  Templates_test{i};
    for j = 1:length(Templates_train)
           T2 =  Templates_train{j};           
           Dis(j) = im_Ham_MGCC(T1,T2);
    end
    [m,k]=min(Dis);
    if ceil(k/train_size) == ceil(i/test_size) % ceil向上取整
        true_num = true_num+1;
    end
end
toc
acc = true_num / (Class_Num * test_size);

save acc acc

