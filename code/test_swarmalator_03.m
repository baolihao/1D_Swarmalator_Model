%function test_swarmalator_03()
%

% (C) M. Zhong

T                       = 1;           % final time
N                       = 100;          % Number of agents
d                       = 2;             % dimension of the physical space
ode_type                = 0;             % type of the ODE system
                                         % 0 - original, cluster and sync
                                         % 1 - original + Vicsek
                                         % 2 - original + Cucker-Smale
sigma                   = 0.2;             % the size of the neighborhood
% initial distribution for x
x0                      = 2 * rand(d, N);
% set up the parameters
% (J, K) can be: (0.1, 1), (0.1, -1), (1, 0), (1, -0.1), (1, -0.75)
J                       = 0.1;
K                       = 1;
%
phi                     = {@(r, z) energy_phi_ring(r, z, J), ...
                           @(r, z) xi_phi_ring(r, z, K, sigma)};
% initial distribution for xi
xi0                     = 2 * pi * rand(1, N) - pi;
y0                      = [x0(:); xi0(:)];
% time interval for intergration
tspan                   = [0, T];
rhs                     = @(t, y) swarmalator_rhs(y, phi, d, N, ode_type, []);
% use ode23 for possible stiffness, can switch to ode45 for faster integration
soln                    = ode23(rhs, tspan, y0);
tint                    = linspace(0, T, 101);
yint                    = deval(soln, tint);
% visualize the trajectory
plot_traj(tint, yint, d, N, ode_type);
%end
