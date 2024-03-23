function plot_XphasePlane(tint, yint, N,ind,p)

T            = length(tint);

phi          = mod(yint(1:N,:),2*pi);
 
theta        = mod(yint(N + 1 : 2 * N,:),2*pi);

hold on;
N_p          = floor(p * N);

phi_blue = phi(ind(1 : N_p),:);
theta_blue  = theta(ind(1 : N_p),:);

phi_red = phi(ind(N_p + 1 : end),:);
theta_red=theta(ind(N_p + 1 : end),:);

m      = scatter(phi_blue(:,1),theta_blue(:,1),25,'filled','b');
n      = scatter(phi_red(:,1),theta_red(:,1),25,'filled','r');

    xlim([0 6.5])
    ylim([0 6.5])
    xlabel('$x$','FontSize', 50,'Interpreter', 'Latex');
    ylabel('$\theta$','FontSize',50,'Interpreter', 'Latex');
    set(gca,'XTick',0:pi:2*pi);
    set(gca,'XTickLabel',{'0','\pi','2\pi'},'FontSize', 40,'defaultAxesTickLabelInterpreter','latex');
    set(gca,'YTick',0:pi:2*pi);
    set(gca,'YTickLabel',{'','\pi','2\pi'},'FontSize', 40,'defaultAxesTickLabelInterpreter','latex');

filename = 'animation.gif';
for k = 1:T

    m.XData = phi_blue(:,k); 
    m.YData = theta_blue(:,k);
    n.XData = phi_red(:,k); 
    n.YData = theta_red(:,k); 

    pause(0.1)
    frame = getframe(gcf);
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 1
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,...
        'DelayTime',0.1);
    else
        imwrite(imind,cm,filename,'gif','WriteMode','append',...
        'DelayTime',0.1);
    end
end

hold off;

end
