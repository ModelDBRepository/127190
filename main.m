%
% RUN_ME
%
% Main script to run the simulation 
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%

clear all;          % Clear all variables and functions from the memory. 
close all;          % Close all figures and files open.
clc;                % Clear the command window.

addpath matlab;     % Add directory './matlab' to search path.

display_live   =  0;    % When set to 1, enables live plots.


disp('Simulating the impact of chloride accumulation or depletion inside a');
disp('patch-pipette, under outside-out patch-clamp recordings of GABAa currents.');
disp(' ');
disp('Version 2.0, Jan 31st 2011, Michele Giugliano');
disp('Acknowledgements: Thanks to Istvan Biro for important comments and discussions.');
disp(sprintf('\n'));


disp('Setting numerical parameters for the simulation...');
set_parameters;     % Numerical parameters are specified here.
disp('done!');


c_out_interval = 25; % interval in [ms] at which to save concentration profile
c_out_t        =  0; %

% Definition of the numerical method (sparse) matrices..
M = generate_matrix;
B = zeros(N,1);

% Initialization of the state variables..
c      = Cin * ones(N,1);
x      = 0.;
  
if (display_live) 
 disp('Live display of simulation results has been switched on!');
 figure(3); clf;      % Create a clean new figure
 set(gcf, 'Color', [1 1 1], 'DoubleBuffer', 'on');
end


% Output data structures
mytime = 0:dt:(dt*(Nsteps-1));
II     = zeros(Nsteps,2);
CC     = zeros( ceil(lifetime./c_out_interval), length(c) ); % concentration profiles to save (time)(profile)

t      = 0.;      % [ms] time - actual simulation time

% The actual simulation major iterative part starts here ------------------
N1 = fix(Nsteps/4);

tic;                % Start a stopwatch timer.
h = 1;
simulation_step;
elapsed = toc;
disp(sprintf('Simulation will last about %d minute(s)...\n', fix(elapsed * 4 * N1 / 60.)));
disp('Please be patient!');
if (display_live) 
 disp('Setting to 0, display_live will make the simulation faster!');
end


for h=2:N1,    
 simulation_step;
end
disp('25% done..');

for h=(N1+1):2*N1,    
 simulation_step;
end
disp('50% done..');

for h=(2*N1+1):3*N1,    
 simulation_step;
end
disp('75% done..');

for h=(3*N1+1):4*N1,    
 simulation_step;
end
disp('100% done..');
toc;                % Stop the stopwatch timer.


%
%% Visualizing the output
%
plot_results;

%
%% Writing files
%
fname = sprintf('data_files/simulation_data_%.1f_%.1f_%.1f.mat',r,b,f);
%save(fname, 'II', 'mytime', 'c_out_interval', 'CC', 'r', 'b', 'f', 'c2', 'gof2', 'dt', 'dz');
toc

