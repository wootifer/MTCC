clear;
close all;
clc;
% ��ʼ������
Class_Num = 378;  % M ��ʾ���������ԣ��������
train_size = 1;
test_size = 19;
total_size = train_size + test_size;  % N ��ʾÿ����������������
% �����˲���
gb = Np_Gabor(8,6);
% �����ļ�·��
train_path = 'F:\Code\NEW\PolyU\PolyU_tr_te\train_PolyU_1\';
test_path = 'F:\Code\NEW\PolyU\PolyU_tr_te\test_PolyU_19\';

%% ��ȡͼƬ������,�������ļ��е�ͼƬ��ȡ����
% tic
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
%% �������ļ��еĶ�ȡ����
% ѵ����ͼƬ��ȡ������
tic
image_list_train=dir([train_path '*.bmp']);
Templates_train = cell(1, length(image_list_train));
for i=1:length(image_list_train)
    im_name = image_list_train(i).name;
    im = imread([train_path im_name]);
    im = normalize_image(im); % ͼ���һ��
    im = im(:,:,1);
    if size(im,2) ~= 128
        im = imresize(im,[128 128]);
    end
    Templates_train{i}= ExtractFeature_Simp(im, gb);
end
save Templates_train Templates_train
toc

%���Լ��ļ���ȡ������
tic
image_list_test=dir([test_path '*.bmp']);
Templates_test = cell(1, length(image_list_test));
for i=1:length(image_list_test)
    im_name = image_list_test(i).name;
    im = imread([test_path im_name]);
    im = normalize_image(im); % ͼ���һ��
    im = im(:,:,1);
    if size(im,2) ~= 128
        im = imresize(im,[128 128]);
    end    
    Templates_test{i}= ExtractFeature_Simp(im, gb);
end
save Templates_test Templates_test
toc
%% ʹ��K-NN�㷨ʵ�ַ���
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
    if ceil(k/train_size) == ceil(i/test_size) % ceil����ȡ��
        true_num = true_num+1;
    end
end
toc
acc = true_num / (Class_Num * test_size);

save acc acc

