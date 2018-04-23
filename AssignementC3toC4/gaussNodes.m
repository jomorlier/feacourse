function [x,A] = gaussNodes(n,tol)
% Computes nodal abscissas x and weights A of
% Gauss-Legendre n-point quadrature.
% USAGE: [x,A] = gaussNodes(n,epsilon,maxIter)
% tol = error tolerance (default is 1.0e4*eps).
if nargin < 2; tol = 1.0e4*eps; end
A = zeros(n,1); x = zeros(n,1);
nRoots = fix(n + 1)/2;                % Number of non-neg. roots
for i = 1:nRoots
    t = cos(pi*(i - 0.25)/(n + 0.5)); % Approx. roots
    for j = i:30
   [p,dp] = legendre(t,n); dt=-p/dp;t=t+dt; if abs(dt) < tol
    x(i) = t; x(n-i+1) = -t;
    A(i) = 2/(1-t^2)/dp^2;
    A(n-i+1) = A(i);
    break
   end
    end
end
