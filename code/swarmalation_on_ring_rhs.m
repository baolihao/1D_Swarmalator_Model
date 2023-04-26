function rhs = swarmalation_on_ring_rhs(y, J, K, sigma, N)
%

%

r        = y(1 : N);
phi      = y(N + 1 : 2 * N);
theta    = y(2 * N + 1 : 3 * N);
x        = r' .* [cos(phi'); sin(phi')];
xij      = repmat(x, N, 1) - repmat(x(:), 1, N);
dij      = get_pairwise_dist(xij, 2, N);
ind      = logical(eye(N));
dij(ind) = 1;
H_r      = 1/N * sum((r .* cos(phi - phi') - r') .* (1 - dij.^(-2)), 2);
Z_0      = 1/N * sum(exp(1i * theta));
R_0      = abs(Z_0);
Psi_0    = angle(Z_0);
% not sure if it should be the 1st momement or 2nd moment
Z_1      = 1/N * sum(r .* exp(1i * theta));
R_1      = abs(Z_1);
Psi_1    = angle(Z_1);
% 2nd moment
% Z_2      = 1/N * sum(r.^(2) .* exp(1i * theta));
% R_2      = abs(Z_2);
% Psi_2    = angle(Z_2);
%
W_tilde_p = 1/N * sum(r .* exp(1i * (phi + theta)));
W_tilde_m = 1/N * sum(r .* exp(1i * (phi - theta)));
S_tilde_p = abs(W_tilde_p);
S_tilde_m = abs(W_tilde_m);
Psi_p     = angle(W_tilde_p);
Psi_m     = angle(W_tilde_m);
r_dot     = H_r - J * r * R_0 .* cos(Psi_0 - theta) + J/2 * (...
            S_tilde_p * cos(Psi_p - (phi + theta)) + ...
            S_tilde_m * cos(Psi_m - (phi - theta)));
H_phi     = 1/N * sum((r ./ r') .* sin(phi - phi') .* (1 - dij.^(-2)), 2);
phi_dot   = H_phi + J./(2 * r) .* (S_tilde_p * sin(Psi_p - (phi + theta)) ...
            + S_tilde_m * sin(Psi_m - (phi - theta)));
% (R_1, Psi_1) might be (R_2, Psi_2)
theta_dot = K * (1 - r.^(2)/sigma^2) * R_0 .* sin(Psi_0 - theta) - K/sigma^2 *...
            R_1 * sin(Psi_1 - theta) + K * r/sigma^2 .* (S_tilde_p * ...
            sin(Psi_p - (phi + theta)) + S_tilde_m * sin(Psi_m - (phi - theta)));
rhs       = [r_dot; phi_dot; theta_dot];
end
