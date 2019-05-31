function x = receptor_kinetics(T, xold, deltat)
%
% x = receptor_kinetics(alpha, beta, T, xold, deltat)
% Perform a single temporal iteration updating the receptor conductance.
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%

global alpha beta;

taux = 1./(alpha * T + beta);
xinf = alpha * T * taux;

x    = (xold - xinf) * exp(-deltat/taux) + xinf;
return;