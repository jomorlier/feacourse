clear all; close all;

%Exercice 1
step=1.5
x=0:step:6;

%check with
% F = @(x)exp(x);
% I_q = quad(F,0,6)

%(Gauss-Legendre quadrature)
a = 0; b = 6; Iexact = exp(6)-1;
for n = 2:6
I = gaussQuad(?,?,?,?)
%test TBD
end


%Exercice 2
I2 = gaussQuad2(@exo2,?,?,?)