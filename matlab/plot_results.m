%
% PLOT_RESULTS
%
% Visualize the final result of the simulation.
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%

  
  subplot(2,1,1);
  hold on; PPP1 = plot(mytime, II(:,1), 'k'); hold off; 
  hold on; PPP2 = plot(mytime, II(:,2), 'r'); hold off; 
  hold on; PPP3 = plot(mytime, max(II(:,1)).*II(:,3), 'b--'); hold off; 
  ylabel('Pipette current [pA]');
  xlabel('time [ms]')
  set(gca, 'Box', 'off');
  legend([PPP2 PPP1 PPP3], '[Cl] clamped (theoretical)', '[Cl] depletion/accumulation', 'GABA pulse');
  drawnow;
  
  subplot(2,1,2);
  k = fix(size(CC,1)/2);
  hold on; PP1 = plot(z(end:-1:1), CC(1,:),'k'); hold off; 
  hold on; PP2 = plot(z(end:-1:1), CC(k,:),'b'); hold off; 
  hold on; PP3 = plot(z(end:-1:1), CC(end,:),'r'); hold off; 
  ylabel('Chloride concentration [mM]');
  xlabel('distance from the omega patch very tip [um]')
  set(gca, 'Box', 'off');
  str1 = sprintf('@t = %.1fms',c_out_interval);
  str2 = sprintf('@t = %.1fms',k*c_out_interval);
  str3 = sprintf('@t = %.1fms',size(CC,1)*c_out_interval);
  legend([PP1 PP2 PP3], str1, str2, str3);
  xlim([0 max(z)]);
  
  
  plot_free_area_testing;