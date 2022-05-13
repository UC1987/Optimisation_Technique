cost = [14 56 48 27;82 35 21 81;99 31 71 63];
A = [13 19 16];
B = [7 14 21 6];

if sum(A) == sum(B)
    fprintf('balanced problem\n');
else
    fprintf('unbalanced problem\n');
    
    if sum(A)<sum(B)
        cost(end+1,:) = zeros(1,size(A,2));
        A(end+1) = sum(B)-sum(A);
    elseif sum(B)<sum(A)
        cost(:,end+1) = zeros(1,size(A,2));
        B(end+1) = sum(A)-sum(B);
    end
end

X = zeros(size(cost));
[m,n] = size(cost);
BFS = m+n-1;
for i = 1:m
    for j = 1:n
        x11 = min(A(i),B(j));
        X(i,j) = x11;
        A(i) = A(i)-x11;
        B(j) = B(j)-x11;
    end
end

fprintf('initial BFS = \n');
IB = array2table(X);
disp(IB);

totalBFS = length(nonzeros(X));
if totalBFS == BFS
    fprintf('non degenerate\n');
else
    fprintf('Degenerate\n');
end
 value = sum(sum(cost.*X));
 fprintf('optimal cost is :%d',value);