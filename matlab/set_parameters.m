%
% SET_PARAMETERS
%
% Utility script to set the values of numerical parameters of the model
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%

% Let's first declare the numerical parameters as global variables...

global r f b; 
global alpha1 alpha2 alpha3 L delta2 delta3 d; 
global delta1 z0 z1 z2 z3 z4 a b1 b2;
global Cin Cout D;
global N dt dz;
global gmax Tmax dur alpha beta Vhold time_list;


%--------------------------------------------------------------------------
%
%% Geometrical parameters 
%
alpha1 = 8.;    % [deg] - pipette shoulder angle
alpha2 = 5.5;   % [deg] - pipette shank angle
alpha3 = 3.;    % [deg] - pipette very tip angle

L      = 65.;   % [um] - maximal length of the simulated diffus. in pipette

delta2 = 4.5;   % [um] - pipette shank angle length
delta3 = 5.;    % [um] - pipette very tip length

d      = 1.;    % [um] - pipette tip physical diameter

r      = 1.1;   % [um] - radius of the membrane patch (hemi)sphere
b      = 0.1;   % [um] - length of the membrane clog re-entering the tip
f      = .8;    % fraction of the pipette diameter free from membrane clog
%--------------------------------------------------------------------------
%


%--------------------------------------------------------------------------
%
%% Chloride diffusion parameters
%
Cin   = 10.;    % [mM] - concentration of Cl- inside the pipette (bulk)
Cout  = 130.;   % [mM] - concentration of Cl- outside the pipette (bulk)

                % Diffusion coefficient for Chloride ions in solution
D     = 2.;     % [um^2/ms] - from 10^-5 cm^2/sec 
%--------------------------------------------------------------------------
%


%--------------------------------------------------------------------------
%
%% Electrophysiological parameters
%
gmax   = 8.;    % [nS] - was 8.5 , max receptors conductance for Cl-ions (i.e. 100 receptors) 
Tmax   = 2.;    % [mM] - was 2 ,amplitude of the neurotx (square) pulse
dur    = 1.;    % [ms] - duration of the neurotx (square) pulse  
time_list = [1]; %[ms] - time-location of pulse start(s)
alpha  = 0.5;   % [ms]^-1 [mM]^-1, bidning rate of the receptors
beta   = 0.05;  % [ms]^-1, decay time constant of receptor currents
Vhold  = -100.;    % [mV] - holding voltage / voltage command
%--------------------------------------------------------------------------
%


%--------------------------------------------------------------------------
%
%% Numerical integation parameters
%
dz = 0.002;      % [um] - spatial discretization step
dt = 0.01;       % [ms] - temporal discretization step

lifetime = dur + time_list(end) + 200; % [ms] - total time, overall simulation lifetime
%--------------------------------------------------------------------------
%


%--------------------------------------------------------------------------
%
%% Definition of useful temporary variables and parameters
Nsteps = ceil(lifetime/dt);
b1     = f * d;
b2     = b;
a      = r * (pi * 4. / 3.)^(1./3.); % [um] - length box simulating omega-patch
delta1 = L - (delta2 + delta3);
z0     = 0;
z1     = z0 + delta1;
z2     = z1 + delta2;
z3     = z2 + delta3;
z4     = z3 + a;
N      = ceil((z4-z0)/dz) + 1;
z      = (z0-dz):dz:z4;
%% ------------------------------------------------------------------------
%