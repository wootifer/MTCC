function [T]=ExtractFeature_Simp(I,Gb)
T = cell(1,12);

I11 = conv2(double(I),double(Gb(:,:,1)),'same'); 
I12 = conv2(I11,double(Gb(:,:,1)),'same'); 

T11=I11(1:4:end,1:4:end);
T12=I12(1:4:end,1:4:end);
T{1} = double(T11>0);
T{2} = double(T12>0);

I21 = conv2(double(I),double(Gb(:,:,2)),'same'); 
I22 = conv2(I21,double(Gb(:,:,2)),'same'); 

T21=I21(1:4:end,1:4:end);
T22=I22(1:4:end,1:4:end);
T{3} = double(T21>0);
T{4} = double(T22>0);

I31 = conv2(double(I),double(Gb(:,:,3)),'same'); 
I32 = conv2(I31,double(Gb(:,:,3)),'same'); 

T31=I31(1:4:end,1:4:end);
T32=I32(1:4:end,1:4:end);
T{5} = double(T31>0);
T{6} = double(T32>0);

I41 = conv2(double(I),double(Gb(:,:,4)),'same'); 
I42 = conv2(I41,double(Gb(:,:,4)),'same'); 

T41=I41(1:4:end,1:4:end);
T42=I42(1:4:end,1:4:end);
T{7} = double(T41>0);
T{8} = double(T42>0);

I51 = conv2(double(I),double(Gb(:,:,5)),'same'); 
I52 = conv2(I51,double(Gb(:,:,5)),'same'); 

T51=I51(1:4:end,1:4:end);
T52=I52(1:4:end,1:4:end);
T{9} = double(T51>0);
T{10} = double(T52>0);

I61 = conv2(double(I),double(Gb(:,:,6)),'same'); 
I62 = conv2(I61,double(Gb(:,:,6)),'same'); 

T61=I61(1:4:end,1:4:end);
T62=I62(1:4:end,1:4:end);
T{11} = double(T61>0);
T{12} = double(T62>0);


