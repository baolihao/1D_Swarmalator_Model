function phi = xi_phi_ring(r, z, K, sigma)
% function phi = xi_phi_ring(r, z, K, sigma)

% M. Zhong

phi      = zeros(size(r));
ind      = r > 0;
phi(ind) = K * sin(z(ind))./z(ind) .* (1 - r(ind).^(2)/sigma^2) ...
           .* heaviside(sigma - r(ind));
ind      = r == 0;
phi(ind) = K * (1 - r(ind).^(2)/sigma^2) .* heaviside(sigma - r(ind));
end