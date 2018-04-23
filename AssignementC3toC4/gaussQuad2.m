function I = gaussQuad2(func,x,y,n)
% Gauss-Legendre quadrature over a quadrilateral.
% USAGE: I = gaussQuad2(func,x,y,n)
% INPUT:
% func = handle of function to be integrated.
%x =[x1;x2;x3;x4] = x-coordinates of corners.
%y = [y1;y2;y3;y4] = y-coordinates of corners.
%n =order of integration
% OUTPUT:
% I = integral

[t,A] = gaussNodes(n); I = 0;
for i = 1:n
    for j = 1:n
        [xNode,yNode] = map(x,y,t(i),t(j));
        z = feval(func,xNode,yNode);
        detJ = jac(x,y,t(i),t(j));
        I = I + A(i)*A(j)*detJ*z;
    end
end

function detJ = jac(x,y,s,t)
% Computes determinant of Jacobian matrix.
J = zeros(2);
J(1,1) = - (1 - t)*x(1) + (1 - t)*x(2)...
         + (1 + t)*x(3) - (1 + t)*x(4);
J(1,2) = - (1 - t)*y(1) + (1 - t)*y(2)...
         + (1 + t)*y(3) - (1 + t)*y(4);
J(2,1) = - (1 - s)*x(1) - (1 + s)*x(2)...
         + (1 + s)*x(3) + (1 - s)*x(4);
J(2,2) = - (1 - s)*y(1) - (1 + s)*y(2)...
         + (1 + s)*y(3) + (1 - s)*y(4);
detJ = (J(1,1)*J(2,2) - J(1,2)*J(2,1))/16;
function [xNode,yNode] = map(x,y,s,t)
% Computes x and y-coordinates of nodes.
N = zeros(4,1);
N(1) = (1 - s)*(1 - t)/4;
N(2) = (1 + s)*(1 - t)/4;
N(3) = (1 + s)*(1 + t)/4;
N(4) = (1 - s)*(1 + t)/4;
xNode = dot(N,x); yNode = dot(N,y);