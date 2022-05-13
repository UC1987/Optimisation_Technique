V = {'x1','x2','s1','s2','sol'};
Z = [-3 -5 0 0 0];
T = [-1 -3
     -1 -1];
 
B = [-3
     -2];
 
I = [1 0
     0 1];
 
A = [T I B];
BV = [];

for j=1:size(I,2)
    for i=1:size(A,2)
        if A(:,i)==I(:,j)
            BV = [BV i];
        end
    end
end

Zj_Cj = Z(BV)*A - Z;
ZCj = [A;Zj_Cj];
table = array2table(ZCj);
table.Properties.VariableNames(1:size(ZCj,2)) = V
flag = 1;
while flag
sol = A(:,end);
if any (sol<0); 
    [Leaving_variable, Pivot_row] = min(sol);
    row = A(Pivot_row,1:end-1);
    ZJ = Zj_Cj(:,1:end-1);
    for i=1:size(row,2)
        if row(i)<0
            ratio(i) = abs(ZJ(i)./row(i));
        else
            ratio(i) = inf;
        end
    end
    [min_val, Pivot_col] = min(ratio);
    BV(Pivot_row) = Pivot_col;
    Pivot_key = A(Pivot_row,Pivot_col);
    A(Pivot_row,:) = A(Pivot_row,:)./Pivot_key;
    for i=1:size(A, 1)
        if i~=Pivot_row 
            A (i, :) = A (i,:)-A(i,Pivot_col).*A(Pivot_row,:);
        end
    end
    Zj_Cj = Z(BV)*A - Z;
    ZCj = [A;Zj_Cj];
    table = array2table(ZCj);
    table.Properties.VariableNames(1:size(ZCj,2)) = V
else
    flag = false; 
end 
end 