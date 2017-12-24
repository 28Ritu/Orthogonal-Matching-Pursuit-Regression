%%
% Roll No.: 2016078
filename='winequality-white.csv';
A=dlmread(filename, ';', 1, 0);
Z=A(:, 1:11);
tr=Z(1:3428, :);
test=Z(3429:4898, :);
output_tr=A(1:3428, 12);
output_test=A(3429:4898, 12);

% Training set for Wine Quality-White Dataset 
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
