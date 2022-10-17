%The logistic map and Feigenbaum constant(delta)
%X_{n+1} = LX_{n}(1-X_{n}) = LX_{n} - LX_{n}^2
clear
x0 = .5;
cyclength = [];
infflag=0;
vartrack(4001) = 0;
iter = 0;
for k = 3.84:.0001:3.8571
    iter = iter + 1;
    L = k
    clear x
    x(1) = x0;
    n = 1;
    flag=1;
    while flag==1 && n<5000
        x(n+1) = L*x(n) - L*x(n).^(2);
        check = round(x(1:n),5)==round(x(n+1),5);
        if any(check) || any(isnan(x))
            flag=0;
        end
        n=n+1;
    end
    cycle = x(find(check)+1:end);
    if (any(isinf(cycle))||isempty(cycle))&&infflag == 0
        infflag = k;
    end
    %if isempty(cycle)
    %    cycle = x(1:find(abs(x)==Inf,1)-1);
    %end
    
    vartrack(iter) = var(cycle);
    
    scatter(L*ones(1,length(cycle)),cycle,'.r','SizeData',1)
    if k == 0
        hold on
    end
    
    %drawnow
    cyclength = [cyclength [k;length(cycle)]];
end