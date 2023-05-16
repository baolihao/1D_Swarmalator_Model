T          = 0.4;
N          = 30;
J          = 1;
K          = rand(N,1)-0.5;


phi0       = 2 * pi * rand(N, 1);
theta0     = 2 * pi * rand(N, 1); 
y0         = [phi0;theta0];

tspan      = [0, T];
rhs        = @(t, y) swarmalation_1D_ring_rhs(y, J, K, N);

soln       = ode23(rhs, tspan, y0);
L          = 101;
tint       = linspace(0, T, L);
yint       = deval(soln, tint);
yint_hat   = zeros(2 * N+N, L);
for l = 1 : L
  y_t                   = yint(:, l);
  phi_t                 = y_t(1: N);
  x_t                   = [cos(phi_t'); sin(phi_t')];
  yint_hat(:, l)        = [x_t(:); y_t(N + 1 : end)];
end


plot_trajectory_2(tint, yint_hat,N);