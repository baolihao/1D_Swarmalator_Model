%function test_swarmalator_01()
%

% (C) M. Zhong

T                       = 10;           % final time
N                       = 100;          % Number of agents
d                       = 2;             % dimension of the physical space
ode_type                = 0;             % type of the ODE system
                                         % 0 - original, cluster and sync
                                         % 1 - original + Vicsek
                                         % 2 - original + Cucker-Smale
                                         % 3 - normal Cucker-Smale
                                         % 4 - normal Vicsek
r_neighbor              = 1;             % the size of the neighborhood
% initial distribution for x
x0                      = 2 * rand(d, N);
% set up the parameters
A                       = 1;
B                       = 1;
% (J, K) can be: (0.1, 1), (0.1, -1), (1, 0), (1, -0.1), (1, -0.75)
J                       = 0.1;
K                       = 1;
switch ode_type
  case 0
    phi                 = {@(r, z) energy_phi(r, z, A, J, B), @(r, z) xi_phi(r, z, K)};
% initial distribution for xi
    xi0                 = 2 * pi * rand(1, N) - pi;
    y0                  = [x0(:); xi0(:)];
  case 1
    phi                 = {@(r, s, z) energy_phi(r, z, A, J, B), @(r, s, z) ones(size(s)), ...
                           @(r, s, z) xi_phi(r, z, K)};
    theta0              = 2 * pi * rand(1, N) - pi;
% initial distribution for xi
    xi0                 = 2 * pi * rand(1, N) - pi;
    y0                  = [x0(:); theta0(:); xi0(:)];
  case 2
    % we take K = sigma = 1, and beta = 0.25;
    K                   = 1;
    sigma               = 1;
    beta                = 0.25;
    phi                 = {@(r, s, z) energy_phi(r, z, A, J, B), @(r, s, z) alignment_phi(r, K, ...
                           sigma, beta), @(r, s, z) xi_phi(r, z, K)};
% initial distribution for xi
    xi0                 = 2 * pi * rand(1, N) - pi;
    v0                  = rand(d, N);
    y0                  = [x0(:); v0(:); xi0(:)];
  otherwise
    % need more phis on 3 and 4
    error('');
end
% time interval for intergration
tspan                   = [0, T];
rhs                     = @(t, y) swarmalator_rhs(y, phi, d, N, ode_type, r_neighbor);
% use ode23 for possible stiffness, can switch to ode45 for faster integration
soln                    = ode23(rhs, tspan, y0);
tint                    = linspace(0, T, 101);
yint                    = deval(soln, tint);
% visualize the trajectory
plot_trajectory(tint, yint, d, N, ode_type);
%end
