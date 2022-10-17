tic
maxiter = 10000;
x(maxiter) = 0;
a = 8;
b = 0:.0001:4;
ctol = 0:20;
y = zeros(length(ctol),400000,2);
c = zeros(1,length(ctol));
for m = 1:length(ctol)
    for kk = 1:length(b)
        x(1) = .2;
        %G = @(x) exp(-a*x.^2) + b(kk);
        G = @(x) b(kk)*x.*(1-x);
        for k = 2:maxiter
            x(k) = G(x(k-1));
             if nnz(abs(x(1:k-1)-x(k))<.1)>m
                [~,I] = min(abs(x(1:k-1)-x(k)));
                cycle = x(I:k-1);
                for n = cycle
                    c(m) = c(m) + 1;
                    y(m,c(m),:) = [b(kk), n];   
                end
                break
            end
        end
    end
    ctol(m)
end
toc
h = figure('WindowState','Fullscreen');
filename = 'ctolTest3.gif';
%axis tight manual
for t = 1:length(ctol)
    scatter(y(t,1:c(t),1),y(t,1:c(t),2),'o','SizeData',1,'MarkerFaceAlpha','.1','MarkerEdgeColor','none','MarkerFaceColor','k');
    hold on
    at = sprintf('ctol = %.2f',ctol(t));
    title(at)
    %axis([-1,0,-1,1.2])
    drawnow
    if length(ctol)>1
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