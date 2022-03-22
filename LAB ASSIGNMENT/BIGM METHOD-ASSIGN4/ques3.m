
M = 1000;
cost = [3 2 0 0 -M 0];
A = [1 1 1 0 0 2; 1 3 0 1 0 3; 1 -1 0 0 1 1];
s = eye(size(A,1));
BV=[];
for j=1:size(s,2)
    for i=1:size(A,2)
        if A(:,i)==s(:,j)
            BV = [BV i];
        end
    end
end
B = A(:,BV);
A = inv(B)*A;
ZjCj = cost(BV)*A -cost;
ZCj=[ZjCj;A];
RUN = true;
while RUN
ZC = ZjCj(:,1:end-1);
if any(ZC<0);
    [Enterval, pvt_col] = min(ZC);
    sol = A(:,end);
    Column = A(:,pvt_col);
    if all(Column)<=0
        fprintf('Solution is unbounded \n');
    else
        for i=1:size(Column,1)
            if Column(i)>0
                ratio(i)=sol(i)./Column(i);
            else
                ratio(i)=inf;
            end
        end
       
        [minR,pvt_row]=min(ratio); 
        BV(pvt_row)=pvt_col;
        B = A(:,BV);
        A = inv(B)*A;
        ZjCj = cost(BV)*A - cost;
        ZCj=[ZjCj;A];
    end
   
    else
        RUN = false;
    end
end

oprtimalbfs = zeros(1,size(A,2));
optimalbfs(BV) = A(:,end);
optimalbfs(end) = sum(oprtimalbfs.*cost);
ZjCj