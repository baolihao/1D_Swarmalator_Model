function rhs = swarmalation_PC_rhs(y, J, K, sigma, N)
% function rhs = swarmalation_PC_rhs(y, J, K, sigma, N)
% swarmalator on Polar Coordinates

% (C) M. Zhong

% y is a column vector of size 3Nx1
% rj is column, ri is row
rj        = y(1 : N);
ri        = rj';
% phij is column, phii is row
phij      = y(N + 1 : 2 * N);
phii      = phij';
phiij     = phij - phii;
% thetaj is column, thetai is row, thetai is never needed
thetaj    = y(2 * N + 1 : 3 * N);
% compute dij = |xj - xi|
x         = ri .* [cos(phii); sin(phii)];
dij       = fast_pairwise_dist(x, N);
ind       = logical(eye(N));
dij(ind)  = 1;
% compute 1 - dij^(-2)
mod       = 1 - dij.^(-2);
H_r       = 1/N * sum((rj .* cos(phiij) - ri) .* mod, 2);
Z_0       = 1/N * sum(exp(1i * thetaj));
R_0       = abs(Z_0);
Psi_0     = angle(Z_0);
% not sure if it should be the 1st momement or 2nd moment
% Z_1       = 1/N * sum(rj .* exp(1i * thetaj));
% R_1       = abs(Z_1);
% Psi_1     = angle(Z_1);
% 2nd moment
Z_2      = 1/N * sum(rj.^(2) .* exp(1i * thetaj));
R_2      = abs(Z_2);
Psi_2    = angle(Z_2);
%
phiptheta = phij + thetaj;
phimtheta = phij - thetaj;
%
W_tilde_p = 1/N * sum(rj .* exp(1i * phiptheta));
W_tilde_m = 1/N * sum(rj .* exp(1i * phimtheta));
S_tilde_p = abs(W_tilde_p);
S_tilde_m = abs(W_tilde_m);
Psi_p     = angle(W_tilde_p);
Psi_m     = angle(W_tilde_m);
%
diff1     = Psi_p - phiptheta;
diff2     = Psi_m - phimtheta;
diff3     = Psi_0 - thetaj;
%
r_dot     = H_r - J * rj * R_0 .* cos(diff3) + J/2 * (S_tilde_p * cos(diff1) + S_tilde_m * cos(diff2));
H_phi     = 1/N * sum((rj ./ ri) .* sin(phiij) .* mod, 2);
phi_dot   = H_phi + J./(2 * rj) .* (S_tilde_p * sin(diff1) + S_tilde_m * sin(diff2));
% (R_1, Psi_1) might be (R_2, Psi_2)
theta_dot = K * (1 - rj.^(2)/sigma^2) * R_0 .* sin(diff3) - K/sigma^2 * R_2 * sin(Psi_2 - thetaj) ...
            + K * rj/sigma^2 .* (S_tilde_p * sin(diff1) + S_tilde_m * sin(diff2));
rhs       = [r_dot; phi_dot; theta_dot];
end
