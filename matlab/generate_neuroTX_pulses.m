function T = generate_neuroTX_pulses(actual_time, time_list, duration)
%
% T = generate_neuroTX_pulses(actual_time, time_list, duration)
% Generate a neurotransmitter pulse.
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%

tmp = (actual_time - time_list);
tmq = find( (tmp <= duration) & (tmp>0) );

if (~isempty(tmq)), 
 T = 1; 
else
 T = 0; 
end;

end