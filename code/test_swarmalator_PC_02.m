T          = 100;
N          = 50;
J          = ones(N,1);
k_p        = 1;
k_n        = -0.5;
q          = 0;
N_q        = floor(q * N); % better be an integer
K          = zeros( N,1);
ind        = randperm(N); % randomly shuffle 1:N integers
K(ind(1 : N_q)) = k_n;
K(ind(N_q + 1 : end)) = k_p;



phi0       = 2*pi*rand(N, 1);
theta0     = 2*pi*rand(N, 1); 
y0         = [phi0;theta0];

tspan      = [0, T];
rhs        = @(t, y) swarmalation_1D_ring_rhs(y, J, K, N);

soln       = ode23(rhs, tspan, y0);
L          = 101;
tint       = linspace(0, T, L);
yint       = deval(soln, tint);
x_sol      = yint(1:N,:);
theta_sol  = yint(N+1:end,:);
plot_trajectory_2(tint, yint,N,J,q,k_n,k_p);

