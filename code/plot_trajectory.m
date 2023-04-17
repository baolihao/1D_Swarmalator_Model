
function plot_trajectory(tint, yint, d, N, ode_type)
%

%

% plotting parameters
T=length(tint);

% x_gap                 = 40;
% % 
% label_font            = 26;
% axis_font             = 20;
% title_font            = label_font;
% leg_font              = axis_font;
%
%theFig                = figure('Name', 'Traj', 'NumberTitle', 'Off', 'Position', ...
                       % position);
%
% L                     = length(tint);
% % show the figures with center of mass


x1                    = yint(1 : d : d * (N - 1) + 1, :);
x2                    = yint(2 : d : d * (N - 1) + 2, :);

if d > 2
  x3                  = yint(3 : d : d * (N - 1) + 3, :);
end
switch ode_type
  case 0
    xi                = yint(d * N + 1 : (d + 1) * N, :);
   
  case 1
    theta             = reshape(yint(d * N + 1 : (d + 1) * N), [1, N]);
    v                 = [cos(theta); sin(theta)];
    xi                = yint((d + 1) * N + 1 : (d + 2) * N,:);  
   
  case 2
    v                 = reshape(yint(d * N + 1 : 2 * d * N), [d, N]);
    xi                = yint(2 * d * N + 1 : (2 * d + 1) * N,:);
   
end

if d == 2
 

hf=figure; hold on
title(sprintf('Trajectory\nTime: %0.2f sec', tint(1)), 'Interpreter', 'Latex');
grid minor 


Cdata = xi(:,1);
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
m = scatter(x1(:,1),x2(:,1),25,xi(:,1),'filled');


filename = 'animation.gif';
for k = 1:T
   
  Cdata = xi(:,k);
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
    m.CData=xi(:,k);


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
% ax                 = gca;
% ax.FontSize        = axis_font;      
% xlabel('$x$', 'Interpreter', 'latex', 'FontSize', label_font);
% ylabel('$y$', 'Interpreter', 'latex', 'FontSize', label_font);   
% title('Traj', 'Interpreter', 'latex', 'FontSize', title_font);
end