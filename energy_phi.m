function phi = energy_phi(r, z, A, J, B)
% function phi = energy_phi(r, z, A, J, B)

% M. Zhong

phi      = zeros(size(r));
ind      = r > 0;
phi(ind) = (A + J * cos(z(ind)))./r(ind) - B./r(ind).^2;
end