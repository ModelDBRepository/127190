%
% SIMULATION_STEP
%
% Perform a single temporal iteration step, solving for the concentration vector.
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%


 gate   = generate_neuroTX_pulses(t, time_list, dur);           % Neurotx
 x      = receptor_kinetics(Tmax * gate, x, dt);                % Receptor
 B(N)   = -eta(N) * dz/D * ion_current(x, c(N), Cout) / 96.48;  % Actual current

 c      = M \ (c + B);              % Actual numerical method.         
 c(find(c<0))=1e-6;
 
 itot2 = ion_current(x, Cin, Cout); % Theoretical, assuming no diffusion..
 itot1 = ion_current(x, c(N), Cout);% Computed, taking diffusion into account.
 
if (display_live)
if (mod(t,dt*4)<dt)
  title(sprintf('time = %f ms',t));
  subplot(2,1,1);
  hold on; PPP1 = plot(t, itot1, 'k.'); hold off; 
  hold on; PPP2 = plot(t, itot2, 'r.'); hold off; 
  hold on; PPP3 = plot(t, 10.*gate, 'b.'); hold off; 
  ylabel('Pipette current [pA]');
  xlabel('time [ms]')
  set(gca, 'Box', 'off');
  legend([PPP2 PPP1 PPP3], '[Cl] clamped (theoretical)', '[Cl] depletion/accumulation', 'GABA pulse');
  drawnow;
  
  subplot(2,1,2);
  cla; PP1 = plot(z(end:-1:1), c,'k'); 
  ylabel('Chloride concentration [mM]');
  xlabel('distance from the omega patch very tip [um]')
  set(gca, 'Box', 'off');
  xlim([0 max(z)]);
  drawnow;
  
 end
end

II(h,1) = itot1;    II(h,2) = itot2;    II(h,3) = gate;

if c_out_t<=h*dt, 
    CC( round(h*dt./c_out_interval)+1,: )=c; 
    c_out_t=c_out_t+c_out_interval;
end

t       = t + dt;
