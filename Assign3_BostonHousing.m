%%
% Roll no.: 2016078
filename='housingdata.txt';
A=importdata(filename);
Z=A(:, 1:13);
tr=Z(1:354, :);
test=Z(355:506, :);
output_tr=A(1:354, 14);
output_test=A(355:506, 14);

% Training set for Boston Housing Dataset 
[n,M]=size(output_tr);
[n,N]=size(tr);
K1=3;                  % Top 3 variables detection
for i=1:M
    omega=[];
    xomega=output_tr(:, i);
    resi=xomega;
    index=zeros(K1,1);
    for j=1:K1
        proj=tr'*resi;
        pos=find(abs(proj)==max(abs(proj)));
        pos=pos(1);
        index(j)=pos;
        omega=mldivide(tr(:, index(1:j)),xomega);
        resi=xomega-tr(:, index(1:j))*omega;
    end
    x1=zeros(N,1);
    x1(index)=omega;
end
display(x1);
K2=5;                     % Top 5 variables detection
for i=1:M
    omega=[];
    xomega=output_tr(:, i);
    resi=xomega;
    index=zeros(K2,1);
    for j=1:K2
        proj=tr'*resi;
        pos=find(abs(proj)==max(abs(proj)));
        pos=pos(1);
        index(j)=pos;
        omega=mldivide(tr(:, index(1:j)),xomega);
        resi=xomega-tr(:, index(1:j))*omega;
    end
    x2=zeros(N,1);
    x2(index)=omega;
end
display(x2);

% Testing set
y_pred1=test*x1;
RMSE_1=sqrt(mean((output_test-y_pred1).^2));
display(RMSE_1);

y_pred2=test*x2;
RMSE_2=sqrt(mean((output_test-y_pred2).^2));
display(RMSE_2);
