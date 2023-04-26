%function test_swarmalator_01()
%

% (C) M. Zhong

T                       = 1;            % final time
N                       = 20;            % Number of agents
d                       = 2;             % dimension of the physical space
% (J, K) can be: (0.1, 1), (0.1, -1), (1, 0), (1, -0.1), (1, -0.75)
J                       = 0.1;
K                       = 1;
% sigma might control the size of the neighborhood?
sigma                   = 0.1;
% initial distribution for (r, phi, theta)
r_min                   = 1;
r_max                   = 5;
r0                      = (r_max - r_min) * rand(N, 1) + r_min;
phi0                    = 2 * pi * rand(N, 1);
theta0                  = 2 * pi * rand(N, 1);
y0                      = [r0; phi0; theta0];
% time interval for intergration
tspan                   = [0, T];
rhs                     = @(t, y) swarmalation_on_ring_rhs(y, J, K, sigma, N);
% use ode23 for possible stiffness, can switch to ode45 for faster integration
soln                    = ode23(rhs, tspan, y0);
L                       = 101;
tint                    = linspace(0, T, L);
yint                    = deval(soln, tint);
yint_hat                = zeros(2 * N + N, L);
%
for l = 1 : L
  y_t                   = yint(:, l);
  r_t                   = y_t(1 : N);
  phi_t                 = y_t(N + 1 : 2 * N);
  x_t                   = r_t' .* [cos(phi_t'); sin(phi_t')];
  yint_hat(:, l)        = [x_t(:); y_t(2 * N + 1 : end)];
end
% visualize the trajectory
plot_traj(tint, yint_hat, 2, N, 0);
%end
