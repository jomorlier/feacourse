 function [Ke] = elementStiffness(A, E, h)

 Ke = (A*E/h)*[[1 -1];[-1 1]];
