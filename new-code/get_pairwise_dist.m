function rij = get_pairwise_dist(Pij, d, N)
% function rij = get_pairwise_dist(Pij, d, N)

% (C) M. Zhong

Pij       = Pij.^2;
rij       = zeros(N); 
for ind = 1 : d
  row_idx = ind + (0 : d : (N - 1) * d);
  rij     = rij + Pij(row_idx, :);
end
rij       = rij.^(0.5);
end