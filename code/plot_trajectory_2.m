
function plot_trajectory_2(tint, yint, N,J,q,k_n,k_p)

T            = length(tint);

phi          = yint(1:N,:);
 
theta        = yint(N + 1 : 2 * N,:);
    

 hold on
title(sprintf('Trajectory\nTime: %0.2f sec \n J=%0.1f, q=%0.1f, k_n=%0.1f, k_p=%0.1f', tint(1),J(1),q,k_n,k_p), 'Interpreter', 'Latex');
%subtitle(sprintf('J=%0.1f, q=%0.1f, k_n=%0.1f, k_p=%0.1f',J(1),q,k_n,k_p), 'Interpreter', 'latex');
grid minor 

for i=1:N
    plot(phi(i,:),theta(i,:),'Color','None');
    p(i)= plot(phi(i,1),theta(i,1));
end
m = scatter(phi(:,1),theta(:,1),25,'filled');

for k = 1:T
    for j=1:N
        p(j).XData = phi(j,1:k);
        p(j).YData = theta(j,1:k);
        pause(0.001)
    end
   % Updating the point
    m.XData = phi(:,k); 
    m.YData = theta(:,k);
    % Updating the title
    title(sprintf('Trajectory \n Time: %0.2f sec \n J=%0.1f, q=%0.1f, k_n=%0.1f, k_p=%0.1f', tint(k),J(1),q,k_n,k_p),...
    'Interpreter','Latex');
    
end

hold off;

end