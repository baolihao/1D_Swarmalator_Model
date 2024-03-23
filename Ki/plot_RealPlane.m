function plot_2(tint, yint,Sp,Sn, N)

T            = length(tint);

phi          = wrapTo2Pi(yint(1:N,:));

phi_x        = cos(phi);
phi_y        = sin(phi);

theta        = wrapTo2Pi(yint(N + 1 : 2 * N,:));
    

 
% grid minor 
hold on;
r=1;
x0=0;
y0=0;
syms x y
circle=fimplicit((x-x0).^2 + (y-y0).^2 -r^2);

circle.Color='k';
axis equal
set(gca, 'XAxisLocation', 'origin', 'YAxisLocation', 'origin')
set(gca,'XTick',[],'YTick',[])
xlabel('x_1','FontSize',32)
ylabel('x_2','FontSize',32)
colormap turbo;
scatter(phi_x(:,end),phi_y(:,end),115,theta(:,end),'filled');

n = scatter(Sp(1,end),Sp(2,end),2250,'filled');
n.CData=[0 0.5 0.8];
n_text = text(Sp(1,end)-0.14,Sp(2,end),'Smax','FontSize',18.5);
l = scatter(Sn(1,end),Sn(2,end),2250,'filled');
l.CData=[0.8 0.5 0];
l_text = text(Sn(1,end)-0.13,Sn(2,end),'Smin','FontSize',18.5);

hold off;

end
