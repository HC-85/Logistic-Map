clear
phaseplot = 1;
if phaseplot == 0
    d_theta0 = 0;
    theta0 = pi/4;
    [t,y] = ode45(@pnl,[0 7],[theta0; d_theta0]);
    subplot(2,2,1)
    plot(t,y(:,1),'-.',t,y(:,2),'-.')
    title({'$\theta = \frac{\pi}{4}$'},'Interpreter','latex','FontSize',12)
    legend({'$\theta$','$\frac{d \theta}{d t}$'},'Interpreter','latex','FontSize',12,'Location','Southeast')

    theta0 = pi/2;
    [t,y] = ode45(@pnl,[0 7],[theta0; d_theta0]);
    subplot(2,2,2)
    plot(t,y(:,1),'-.',t,y(:,2),'-.')
    title({'$\theta = \frac{\pi}{2}$'},'Interpreter','latex','FontSize',12)
    legend({'$\theta$','$\frac{d \theta}{d t}$'},'Interpreter','latex','FontSize',12,'Location','Southeast')

    theta0 = 3*pi/4;
    [t,y] = ode45(@pnl,[0 7],[theta0; d_theta0]);
    subplot(2,2,3)
    plot(t,y(:,1),'-.',t,y(:,2),'-.')
    title({'$\theta = \frac{3\pi}{4}$'},'Interpreter','latex','FontSize',12)
    legend({'$\theta$','$\frac{d \theta}{d t}$'},'Interpreter','latex','FontSize',12,'Location','Southeast')

    theta0 = pi;
    [t,y] = ode45(@pnl,[0 7],[theta0; d_theta0]);
    subplot(2,2,4)
    plot(t,y(:,1),'-.',t,y(:,2),'-.')
    title({'$\theta = \pi$'},'Interpreter','latex','FontSize',12)
    legend({'$\theta$','$\frac{d \theta}{d t}$'},'Interpreter','latex','FontSize',12,'Location','Southeast')
else
    for d_theta0 = -2*pi:pi/4:2*pi
        for theta0 = -2*pi:pi/2:2*pi
            [t,y] = ode45(@pnl,[0 pi],[theta0; d_theta0]);
            plot(y(:,1),y(:,2),'r-')
            hold on
        end
    end
    axis([-2*pi,2*pi,-3*pi,3*pi])
    title('Phase Plot','FontSize',12)
    xlabel('$\theta$','Interpreter','latex','FontSize',15)
    ylabel('$\dot{\theta}$','Interpreter','latex','FontSize',15)
end

T = @(theta0) 2*pi*sqrt(1/9.8)*(1 + (1/4)*(sin(theta0/2)^2) + (9/64)*(sin(theta0/2)^4));
T(pi/4)

d_theta0 = 0;
theta0 = pi/4;
[t,y] = ode45(@pnl,[0 7],[theta0; d_theta0]);

plot(t,y(:,1),'.')
