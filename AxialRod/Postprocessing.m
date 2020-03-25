 figure;
 p0 = plotDisp(E, A, L, R, a);
 p1 = plot(node, dsol, 'ro--', 'LineWidth', 3); hold on;
 legend([p0 p1],'Exact','FEM');
 
 for i=1:e
  node1 = elem(i,1);
  node2 = elem(i,2);
  u1 = dsol(node1);
  u2 = dsol(node2);
  [eps(i), sig(i)] = elementStrainStress(u1, u2, E, h);
 end

 figure;
 p0 = plotStress(E, A, L, R, a);
 for i=1:e
  node1 = node(elem(i,1));
  node2 = node(elem(i,2));
  p1 = plot([node1 node2], [sig(i) sig(i)], 'r-','LineWidth',3); hold on;
 end
 legend([p0 p1],'Exact','FEM');



  



 
