//ƽ��for Database II
#include "mex.h"
#include "math.h"

//�������ѧ��
#define N1 5 //ƽ�Ƶĳ��ȣ�5��ʾ��������ƽ��2����λ���൱��5*5�Ĵ���
#define NN 25 //5*5��չ��ģ�����
#define TemplateLength (1*28*28) //ƽ�ƺ󴰿�ȡ28*28�ĳߴ�
#define ClassNum 378 //�����
#define SampleNum 20 //ÿ��������
#define IntraNum ClassNum*SampleNum*(SampleNum-1)/2  //36984//74068 //���ھ������/
#define InterNum SampleNum*SampleNum*ClassNum*(ClassNum-1)/2  //7457272//29968808 //���������
#define TemSide 32 //ԭʼģ��ı߳�



//get the minimum value
inline double min_min(double *ad)
{
    int k=1;
    double temp;
    temp=ad[0];    
           while(k<NN)
               {
             if (ad[k] < temp)
                 {
                  temp= ad[k];
                 }
                  k=k+1;
               }            
    return temp;
}
////////////////////////
inline void feature_shift2(double *in,double *out,int x,int y)
{
   int i,j;
 //  double out[TemSide*TemSide];
   //intilization
   for (i=0;i<TemSide;++i)
       for (j=0;j<TemSide;++j)
     {
         out[TemSide*i+j]=0;
         //out[TemSide*i+j+1024]=0;
       }
      for (i=0;i<TemSide+1-N1;++i)
         for (j=0;j<TemSide+1-N1;++j)
        {
          out[TemSide*i+j]=in[TemSide*(x+i)+y+j];    //real part
          //out[TemSide*i+j+TemSide*TemSide]=in[TemSide*(x+i)+y+j+TemSide*TemSide];  //image part
         }  
}

//////main function /////////

void mexFunction(int nlhs, mxArray *plhs[],
				 int nrhs, const mxArray *prhs[])
{
/* retrive arguments */
//�����������������һ������������������һ�������Ƶ�������Ϣ������������ţ��Լ�ÿ�βɼ��Ĵ���
	if( nrhs<2 )
		mexErrMsgTxt("2 input arguments are required.");
    if( nlhs!= 2 )
        mexErrMsgTxt("2 output arguments are required.");
   
	  const mxArray* datacell;   
      int first_num,second_num,total_num,total_num1,total_num2;     
	  int i,j,k,kk,ij;
    // �ڲ�ѭ��
      int ii,jj;    
	  double *data1,*data2;
		double temp11[NN];
    //save the transform
      double data1_temp[TemSide*TemSide],data2_temp[TemSide*TemSide];
    //save 
     // double temp11[NN];
      int sum1=0;  
      int *sum_temp;
           sum_temp = new int[ClassNum];
	   
	  double temp=0;
      double *palmprint_index = mxGetPr(prhs[1]);
    
    int nn=0,mm=0;
    mexPrintf("%d",nn);
    double out1[IntraNum];
    
    double *out2;
    out2 = new double[InterNum];
    if(!out2)
    {
          mexPrintf("fial to malloc memory\n");
          exit(1);
    }
    //�����������
    sum_temp[0]=0;
     for (i = 1; i < ClassNum; ++i)
    {
        first_num  = palmprint_index[3*(i-1)+1];
        second_num = palmprint_index[3*(i-1)+2];
        total_num = first_num + second_num;
        sum_temp[i]=sum_temp[i-1] + total_num;
     }
    
    //���ڱȽ�
    for (i = 0; i < ClassNum; ++i)
    {
        first_num  = palmprint_index[3*i+1];
        second_num = palmprint_index[3*i+2];
        total_num = first_num + second_num;
        
       for(j = 0;  j<total_num-1; ++j)
       {
	     datacell= mxGetCell(prhs[0], sum1+j);
         data1 = mxGetPr(datacell);
         feature_shift2(data1,data1_temp,2,2);
         for(k=j+1; k<total_num; ++k)
             {
	            datacell= mxGetCell(prhs[0], sum1+k);
                data2= mxGetPr(datacell);
                                   
                for(ii = 0;  ii< N1; ++ii)
                    for(jj = 0;  jj< N1; ++jj)
                   {
                   feature_shift2(data2,data2_temp,ii,jj);
	               for(  ij=0; ij<TemSide*TemSide; ++ij )
	                  {
                        if (data1_temp[ij]!=data2_temp[ij])
                           temp=temp+1; 
                           }
                      temp11[N1*ii+jj]=(double)temp/TemplateLength;
                      temp=0;
                    }
               out1[nn]=min_min(temp11);
               nn=nn+1;
              }
         }
        sum1=sum1+total_num;
    }
/// mexPrintf("nn =%d\n",nn);   
/// ���Ƚ�	
    for (i=0; i< ClassNum-1; ++i)
    {
          first_num  = palmprint_index[3*i+1];
          second_num = palmprint_index[3*i+2];
          total_num1 = first_num + second_num;
       for (j=i+1; j< ClassNum;++j)
          {
               first_num  = palmprint_index[3*j+1];
               second_num = palmprint_index[3*j+2];
               total_num2 = first_num + second_num;
           for (k=0; k<total_num1; ++k)
              {  
                datacell= mxGetCell(prhs[0], sum_temp[i]+k);
                data1 = mxGetPr(datacell);
                feature_shift2(data1,data1_temp,2,2);
               for (kk=0; kk<total_num2; ++kk)
                   {
                     datacell= mxGetCell(prhs[0], sum_temp[j]+kk);
                     data2 = mxGetPr(datacell);                      
                    for(ii = 0;  ii<N1; ++ii)
                        for(jj = 0;  jj<N1; ++jj)
                         {
                            feature_shift2(data2,data2_temp,ii,jj);
                            for(ij=0; ij<1024; ++ij )
                                {
                                   if (data1_temp[ij]!=data2_temp[ij])
                                      temp=temp+1; 
                                  }
                              temp11[N1*ii+jj]=(double)temp/TemplateLength;
                              temp=0;
                             }
                         out2[mm]=min_min(temp11);
                //         mexPrintf("out2[nn]=%f\n",out2[mm]);
                         mm=mm+1;                      
                    }
               }        
           }     
    } 
    plhs[0] = mxCreateNumericMatrix(nn, 1, mxDOUBLE_CLASS, mxREAL);
    double *y1 = mxGetPr( plhs[0] );
    for(i=0; i<nn; ++i ) 
          y1[i] = out1[i];
    plhs[1] = mxCreateNumericMatrix(mm, 1, mxDOUBLE_CLASS, mxREAL);
	double *y2 = mxGetPr( plhs[1] );
    for(i=0; i<mm; ++i ) 
          y2[i] = out2[i];
    delete out2;
    delete sum_temp;
}
