function phi = energy_phi_ring(r, z, J)
% function phi = energy_phi_ring(r, z, J)
 
% (C) M. Zhong

phi      = zeros(size(r));
ind      = r > 0;
phi(ind) = 1 + J * cos(z(ind)) - r(ind).^(-2);
end