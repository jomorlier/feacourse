%% Derivation of the stiffness matrix of a 2-node bar element
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
A = [1,r]
E = [1,-1;1,1]
N = A*E^-1
%% Derive strain-displacement matrix B
%%
Jac = diff(2*x/L-1,x)
det_Jac = Jac^-1
B = diff(N)*Jac
%% Construct stiffness matrix
%%
K_2node = E_mod * A_sec * int(B'*B,r,-1,1)*det_Jac
matrix_factor = gcd(K_2node), K_2node/matrix_factor
%% Construct loading vector
%%
F_2node = int(N'*q,r,-1,1)*det_Jac
vector_factor = gcd(F_2node), F_2node/vector_factor
%%