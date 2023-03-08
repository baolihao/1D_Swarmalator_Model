function phi = xi_phi(r, z, K)
% function phi = xi_phi(r, z, K)

% M. Zhong

phi      = zeros(size(r));
ind      = r > 0;
phi(ind) = K * sin(z(ind))./r(ind);
end