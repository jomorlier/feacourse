clear, clc
syms x L real % symbolic variable
P = inline('[1 x x^2 x^3]') % third order polynomial
dP = inline(diff(P(x))) % symbolic derivation
Pn = [ P(0); dP(0); P(L) ; dP(L) ] % Nodes evaluation
N = inline(( P(x) * inv(Pn))) % Shape Functions
dN = inline((dP(x) * inv(Pn))) % Derivatives
                                   
% graphs
  x = 0:0.01:1;
  subplot(2,1,1), plot(x, N(1,x')), title(' Shape functions for beam element  N1 N2 N3 N4 ')
  subplot(2,1,2), plot(x,dN(1,x')), title(' Derivative dN1 dN2 dN3 dN4 ')