
  function [fe] = elementLoad(node1, node2, a, h)

 x1 = node1;
 x2 = node2;

 fe1 = a*x2/(2*h)*(x2^2-x1^2) - a/(3*h)*(x2^3-x1^3);
 fe2 = -a*x1/(2*h)*(x2^2-x1^2) + a/(3*h)*(x2^3-x1^3);
 fe = [fe1;fe2];