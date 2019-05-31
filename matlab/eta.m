function out = eta(k)
%
% out = eta(k)
%
% Helper function
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%

global z0;
global D;
global dt dz;

out = (dt * D) ./ (dz^2 * free_area((k-1)*dz+z0));

end