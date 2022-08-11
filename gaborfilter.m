
%%
%               1                -1     x  ^    y  ^
%%% G(x,y) = ---------- * exp ([----{(----) 2+(----) 2} * exp(2*pi*i*(mu*x*cos(theta)+mu*ysin(theta)))
%            2*pi*sx*sy           2    sx       sy
%
%%% G'(x,y) =  G(x,y) - sumG/(2*n+1)^2  (sumG is the sum of the G)
%
%% Describtion :

%% I : Input image
%% mu : The frequency of the sinusoidal wave
%% theta : The orientation of the function
%% sigma = The standard deviation of the Gaussian envelope
%% (2*n+1)^2 : The size of the filter

%%

function [Gb] = gaborfilter(m, n)

mu = 0.0916;
sigma = 5.6179;
% theta = pi/4;
% m = 8; % 滤波器的大小为(2*m+1)^2
d = pi/n; %角度间隔
Gb = zeros(2*m + 1, 2*m + 1, n);
for theta = 0:d:(n-1)*d
    G = zeros(2*m + 1,2*m + 1);
    for x = -m:m
        for y = -m:m
            G(x+m+1,y+m+1) = (1/(2*pi*sigma^2))*exp(-.5*(x^2 + y^2)/sigma^2)*exp(2*pi*sqrt(-1)*(mu*x*cos(theta)+mu*y*sin(theta)));
        end
    end
    adj_G = G -mean(mean(G));  %调整后的Gober滤波器
    Gb(:,:,round(theta/d)+1) = adj_G(:,:);    
end

%% 
% figure,
% subplot(231),imshow(Gb(:,:,1),[]);
% subplot(232),imshow(Gb(:,:,2),[]);
% subplot(233),imshow(Gb(:,:,3),[]);
% subplot(234),imshow(Gb(:,:,4),[]);
% subplot(235),imshow(Gb(:,:,5),[]);
% subplot(236),imshow(Gb(:,:,6),[]);
end