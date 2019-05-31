function M = generate_matrix
%
% M = generate_matrix
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%
global z0;
global dz N;

 rows = [];  cols = []; s    = [];
 
 % Let's define the non-zero elements of a sparse matrix..

 %m1,1
 rows = [rows, 1];      cols = [cols, 1];
 s    = [s, 1]; 

 %mi,i
 i    = 2:(N-1);
 rows = [rows, i];      cols = [cols, i];
 s    = [s, 1+eta(i).*(free_area((i-2)*dz+z0) + free_area((i-1)*dz+z0))];  
 
 %mi,i-1
 rows = [rows, i];      cols = [cols, i-1];
 s    = [s, -eta(i) .* free_area((i-2)*dz+z0)];
 
 %mi-1,i
 rows = [rows, i];      cols = [cols, i+1];
 s    = [s, -eta(i) .* free_area((i-1)*dz+z0)];
  
 %mN,N
 rows = [rows, N];      cols = [cols, N];
 s    = [s, 1+eta(N) .* free_area((N-1)*dz+z0)];
 
 %mN,N-1
 rows = [rows, N];      cols = [cols, N-1];
 s    = [s, -eta(N) .* free_area((N-1)*dz+z0)];

 % Let's now create this sparse matrix..
 M    = sparse(rows, cols, s, N, N);
end
  