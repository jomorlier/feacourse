function [p] = plotDisp(E, A, L, R, a)

 dx = 0.01;
 nseg = L/dx;
 for i=1:nseg+1
  x(i) = (i-1)*dx;
  u(i) = (1/6*A*E)*(-a*x(i)^3 + (6*R + 3*a*L^2)*x(i));
 end
 p = plot(x, u, 'LineWidth', 3); hold on;
 xlabel('x', 'FontName', 'palatino', 'FontSize', 18);
 ylabel('u(x)', 'FontName', 'palatino', 'FontSize', 18);
 set(gca, 'LineWidth', 3, 'FontName', 'palatino', 'FontSize', 18);