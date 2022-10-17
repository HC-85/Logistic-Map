clear
tridi = 0;
if tridi == 1
    tic
    maxiter = 250;
    x(maxiter) = 0;
    a = 0:.01:20;
    b = -1:.01:1;
    y = zeros(400000,3);
    c = 0;
    for m = 1:length(a)
        for kk = 1:length(b)
            x(1) = 0;
            G = @(x) exp(-a(m)*x.^2) + b(kk);
            for k = 2:maxiter
                x(k) = G(x(k-1));
                if any(abs(x(1:k-1)-x(k)) < 1e-5)
                    [~,I] = min(abs(x(1:k-1)-x(k)));
                    cycle = x(I:k-1);
                    for n = cycle
                        c = c + 1;
                        y(c,:) = [a(m) ,b(kk), n];   
                    end
                    break
                end
            end
        end
        a(m)
    end
    y = y(1:c,:);
    scatter3(y(:,1),y(:,2),y(:,3),'.r','SizeData',1)
    toc
%-------------------------------------------------------------------------%    
else
    tic
    maxiter = 10000;
    x(maxiter) = 0;
    a = 9.82;
    b = -1:.0001:1;
    y = zeros(length(a),400000,2);
    c = zeros(1,length(a));
    for m = 1:length(a)
        for kk = 1:length(b)
            x(1) = 0;
            G = @(x) exp(-a(m)*x.^2) + b(kk);
            for k = 2:maxiter
                x(k) = G(x(k-1));
                if nnz(abs(x(1:k-1)-x(k))<.001)>2
                    [~,I] = min(abs(x(1:k-1)-x(k)));
                    cycle = x(I:k-1);
                    for n = cycle
                        c(m) = c(m) + 1;
                        y(m,c(m),:) = [b(kk), n];   
                    end
                    break
                end
            end
            b(kk)
        end
        a(m)
    end
    toc
    h = figure('WindowState','Fullscreen');
    filename = 'GaussianMapTest2.gif';
    for t = 1:length(a)
        scatter(y(t,1:c(t),1),y(t,1:c(t),2),'o','SizeData',1,'MarkerFaceAlpha','.2','MarkerEdgeColor','none','MarkerFaceColor','k');
        at = sprintf('a = %.2f',a(t));
        title(at)
        axis([-1,1,-1,1.2])
        drawnow
        if length(a)>1
            % Capture the plot as an image 
            frame = getframe(h); 
            im = frame2im(frame); 
            [imind,cm] = rgb2ind(im,512); 
            % Write to the GIF File 
            if t == 1 
                imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
            else 
                imwrite(imind,cm,filename,'gif','WriteMode','append'); 
            end 
        end
    end
end


