clear
tic
maxiter = 1000;
x(maxiter) = 0;
R = 0:.000009:4;
y = zeros(400000,2);
c = zeros(1,length(R));
totc = 0;
x(1) = .2;
for kk = 1:length(R)
    L = @(x) R(kk)*x.*(1-x);
    for k = 2:maxiter
        x(k) = L(x(k-1));
        if nnz(abs(x(1:k-1)-x(k))<1e-9)>0
            [~,I] = min(abs(x(1:k-1)-x(k)));
            cycle = x(I:k-1);
            for n = cycle
                totc = totc + 1;
                c(kk) = c(kk) + 1;
                y(totc,:) = [R(kk), n];   
            end
            break
        end
    end
    R(kk)
end
scatter(y(:,1),y(:,2),'o','SizeData',1,'MarkerFaceAlpha','1','MarkerEdgeColor','none','MarkerFaceColor','r')

len(1) = 0;
for n = 1:6
    dummy = find(c==2.^n);
    if isempty(dummy)
    else
        len(n+1) = dummy(1)*.001;
    end
end
biff = diff(len);
for n = 2:length(biff)-1
    biff(n-1)/biff(n)
end
toc