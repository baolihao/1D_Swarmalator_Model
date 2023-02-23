function plot_traj(tint, yint, d, N, ode_type)
%

%

% plotting parameters
position              = [80, 80, 800, 800];
x_gap                 = 40;
% 
label_font            = 26;
axis_font             = 20;
title_font            = label_font;
leg_font              = axis_font;
%
theFig                = figure('Name', 'Traj', 'NumberTitle', 'Off', 'Position', ...
                        position);
%
L                     = length(tint);
% show the figures with center of mass
x1                    = yint(1 : d : d * (N - 1) + 1, :);
x2                    = yint(2 : d : d * (N - 1) + 2, :);
if d > 2
  x3                  = yint(3 : d : d * (N - 1) + 3, :);
end
switch ode_type
  case 0
    xi                = yint(d * N + 1 : (d + 1) * N, :);
  case 1
    theta             = reshape(y(d * N + 1 : (d + 1) * N), [1, N]);
    v                 = [cos(theta); sin(theta)];
    xi                = reshape(y((d + 1) * N + 1 : (d + 2) * N), [1, N]);      
  case 2
    v                 = reshape(y(d * N + 1 : 2 * d * N), [d, N]);
    xi                = reshape(y(2 * d * N + 1 : (2 * d + 1) * N), [1, N]);
end
if d == 2
  for i = 1 : N
    plot(x1(i, :), x2(i, :), 'b');
    if i == 1, hold on; end
  end
elseif d == 3
  plot3(x1, x2, x3, 'b')
end  
hold off;
ax                 = gca;
ax.FontSize        = axis_font;      
xlabel('$x$', 'Interpreter', 'latex', 'FontSize', label_font);
ylabel('$y$', 'Interpreter', 'latex', 'FontSize', label_font);   
title('Traj', 'Interpreter', 'latex', 'FontSize', title_font);
end