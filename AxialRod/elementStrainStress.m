 
  function [eps, sig] = elementStrainStress(u1, u2, E, h)

 B = [-1/h 1/h];
 u = [u1; u2];
 eps = B*u;
 sig = E*eps;

%