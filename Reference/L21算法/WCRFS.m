%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Description
%  Robust feature selection via L21 reguarlized correntropy
%  feature selection via L21-norm
%  Robust learning via Correntropy
%Input
%  Data   d*n data matrix
%  label  n*1 label vector
%  lambda regularization parameter
%Output
%  W      d*c projection matrix
%  feaind d*1 selected feature index vector
%  dd     d*1 weight vector
%  T      CPU time
%Reference  
%  Ran He, Tieniu Tan, Liang Wang and Wei-Shi Zheng. 
%  L21 Regularized Correntropy for Robust Feature Selection. In IEEE CVPR,2012.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [W] = WCRFS(Data,Y,lambda,d,lambda1)
    
    [dim,num]=size(Data);
    weight = ones(1,num);
    weight2 = ones(dim,1);
    iter =100;
    
    for i=1:iter
%         X1 = Data.*repmat(weight,dim,1);
       X1 = Data*diag(weight);
%         W = (X1*Data'+lambda*diag(weight2)+2*lambda1*diag(d))\(X1*Y);
         W = (X1*Data'+lambda*diag(weight2)+2*lambda1)\(X1*Y);
        %%%%%%%%%%%%distance
        vt = (Data'*W-Y)';
        weight=sum(vt.^2);
        weight = exp(-weight/(4*mean(weight)));
        dd = W.*W;
		weight2 = 2./sqrt(sum(dd')+0.0000001);  
    end
    