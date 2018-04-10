%% Derivation of the stiffness matrix of a 3-node bar element
%% Clean up
%%

%clear workspace
clear all;
%clear command window
clc;
%clear figures
clf;
%% Define symbolic quantities
%%
syms r x L
syms E_mod A_sec
syms q
%the derived quantities will automatically be initialized as symbolic variables as well

%% Derive shape functions N
%%
A = [1,r,r^2]
E = [1,-1,1;1,0,0;1,1,1]
N = simplify(A*E^-1)
%% Derive strain-displacement matrix B
%%
Jac = diff(2*x/L-1,x)
det_Jac = Jac^-1
B = simplify(diff(N)*Jac)
%% Construct stiffness matrix
%%
K_3node = E_mod * A_sec * int(B'*B,r,-1,1)*det_Jac
matrix_factor = gcd(K_3node), K_3node/matrix_factor
%% Construct loading vector
%%
F_3node = int(N'*q,r,-1,1)*det_Jac
vector_factor = gcd(F_3node), F_3node/vector_factor