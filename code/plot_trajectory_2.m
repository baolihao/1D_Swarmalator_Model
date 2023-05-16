
function plot_trajectory_2(tint, yint, N)

T=length(tint);


x1                    = yint(1 : 2 : 2 * (N - 1) + 1, :);
x2                    = yint(2 : 2 : 2 * (N - 1) + 2, :);
theta                 = wrapTo2Pi(yint(2* N + 1 : 3 * N,:));
    

hf=figure; hold on
title(sprintf('Trajectory\nTime: %0.2f sec', tint(1)), 'Interpreter', 'Latex');
grid minor 


Cdata = theta(:,1);
cmap = colormap;
% make it into a index image.
cmin = min(Cdata(:));
cmax = max(Cdata(:));
M = length(cmap);
index = fix((Cdata-cmin)/(cmax-cmin)*M)+1; %A
% Then to RGB
RGB = ind2rgb(index,cmap);
for i=1:N
    plot(x1(i,:),x2(i,:),'Color','None');
    p(i)= plot(x1(i,1),x2(i,1),'Color',RGB(i,:,:));
    
  
    a(i) = annotation('arrow');
    a(i).Parent=hf.CurrentAxes;
    a(i).X=[x1(i,1) x1(i,2)];
    a(i).Y=[x2(i,1) x2(i,2)];
    a(i).Color=RGB(i,:,:);
    
end
m = scatter(x1(:,1),x2(:,1),25,theta(:,1),'filled');


filename = 'animation.gif';
for k = 1:T
   
  Cdata = theta(:,k);
  cmap = colormap;
% make it into a index image.
cmin = min(Cdata(:));
cmax = max(Cdata(:));
M = length(cmap);
index = fix((Cdata-cmin)/(cmax-cmin)*M)+1; %A
% Then to RGB
RGB = ind2rgb(index,cmap);
  
    for j=1:N
    % Updating the line
    
    p(j).XData = x1(j,1:k);
    p(j).YData = x2(j,1:k);
    p(j).Color=RGB(j,:,:);
    if k<T
      a(j).X=[x1(j,k) x1(j,k+1)];
      a(j).Y=[x2(j,k) x2(j,k+1)];
      a(j).Color=RGB(j,:,:);
    end
    % Delay
    pause(0.00001)
    end
   % Updating the point
    m.XData = x1(:,k); 
    m.YData = x2(:,k);
    m.CData = theta(:,k);


    % Updating the title
    title(sprintf('Trajectory\nTime: %0.2f sec', tint(k)),...
    'Interpreter','Latex');
    % Saving the figure
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