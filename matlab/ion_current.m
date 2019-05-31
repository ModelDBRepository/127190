function out = ion_current(x, Cin, Cout)
%
% out = ion_current(x, Cin, Cout) [pA] 
% 
% x     : fraction of open receptors, [0 ; 1]
% Cin   : concentration inside [mM]
% Cout  : concentration outside [mM]
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%
global gmax Tmax dur alpha beta Vhold;


Enernst = -26.0 * log (Cout / Cin);        % [mV], holds for Cl-

out     = -gmax * x * (Vhold - Enernst);

 %
 % This current is the electrical current flowing inside the patch,
 % i.e. from outside to inside..
 %
 if (Cin <= 1.0000e-06), out = 0; end;
end


