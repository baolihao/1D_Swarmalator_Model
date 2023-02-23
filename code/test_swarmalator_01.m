%function test_swarmalator_01()
%

% (C) M. Zhong

T                       = 100;           % final time
N                       = 100;          % Number of agents
d                       = 2;             % dimension of the physical space
ode_type                = 0;             % type of the ODE system
                                         % 0 - original, cluster and sync
                                         % 1 - original + Viscek
                                         % 2 - original + Cucker-Smale
r_neighbor              = 1;             % the size of the neighborhood
% initial distribution for x
x0                      = 2 * rand(d, N);
% initial distribution for xi
xi0                     = 2 * pi * rand(1, N) - pi;
% set up the parameters
A                       = 1;
B                       = 1;
% (J, K) can be: (0.1, 1), (0.1, -1), (1, 0), (1, -0.1), (1, -0.75)
J                       = 0.1;
K                       = 1;
switch ode_type
  case 0
    phi                 = {@(r, z) energy_phi(r, z, A, J, B), @(r, z) xi_phi(r, z, K)};
    y0                  = [x0(:); xi0(:)];
  case 1
    theta0              = 2 * pi * rand(1, N) - pi;
    phi                 = {@(r, s, z) energy_phi(r, z, A, J, B), @(r, s, z) ones(size(s)), ...
                           @(r, s, z) xi_phi(r, z, K)};
    y0                  = [x0(:); theta0(:); xi0(:)];
  case 2
    v0                  = rand(d, N);
end
% time interval for intergration
tspan                   = [0, T];
rhs                     = @(t, y) swarmalator_rhs(y, phi, d, N, ode_type, r_neighbor);
% use ode23 for possible stiffness, can switch to ode45 for faster integration
soln                    = ode23(rhs, tspan, y0);
tint                    = linspace(0, T, 101);
yint                    = deval(soln, tint);
% visualize the trajectory
plot_traj(tint, yint, d, N, ode_type);
%end