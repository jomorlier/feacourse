function [p] = plotStress(E, A, L, R, a)

 dx = 0.01;
 nseg = L/dx;
 for i=1:nseg+1
  x(i) = (i-1)*dx;
  sig(i) = (1/2*A*E)*(-a*x(i)^2 + (2*R + a*L^2));
 end
 p = plot(x, sig, 'LineWidth', 3); hold on;
 xlabel('x', 'FontName', 'palatino', 'FontSize', 18);
 ylabel('\sigma(x)', 'FontName', 'palatino', 'FontSize', 18);
 set(gca, 'LineWidth', 3, 'FontName', 'palatino', 'FontSize', 18);
