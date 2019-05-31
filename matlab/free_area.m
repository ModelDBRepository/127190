function area = free_area(z)
%
% area = free_area(z)
%
% Return the actual free passage area, at a given coordinate z, through the
% pipette.
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%
global alpha1 alpha2 alpha3 d;
global z0 z1 z2 z3 z4 a b1 b2;
global dz;

if (length(z)==1),  % z is not a vector!


if ( (z > (z4+dz)) || (z < (z0-dz)) || (b2 > (z3-z0)) ), 
 disp('free_area(): Error!! z or b2 out of boundaries'); 
 area = nan;
 return; 
end

if     ( (z > z3) && (z <= (z4+dz)) ),
 area = a^2;
elseif ( (z >= z2) && (z <= z3) ),
 R    = 0.5 * d + (z3 - z) * tand(alpha3);
 area = pi * R^2;
elseif ( (z >= z1) && (z < z2) ),
 R    = 0.5 * d + (z3 - z2) * tand(alpha3) + (z2 - z) * tand(alpha2);
 area = pi * R^2;
elseif ( (z >= (z0-dz)) &&(z < z1) ),
 R    = 0.5 * d + (z3 - z2) * tand(alpha3) + (z2 - z1) * tand(alpha2) + (z1 - z) * tand(alpha1) ;
 area = pi * R^2;
end

if ( (b2 > 0) && (z >= (z3 - b2)) && (z <= z3) ),
 R    = 0.5 * b1;
 area = pi * R^2; 
end

else      % z is a vector!
   area = zeros(size(z));
   if (~isempty(find(z>z4, 1)) || ~isempty(find(z<(z0-dz), 1)) || (b2 > (z3-z0))),
    disp('free_area(): Error!! z or b2 out of boundaries'); 
    area = nan * area;
    return; 
   end  

   index1 = find( (z > z3) & (z <= z4) );
   area(index1) = a^2;
   index2 = find( (z >= z2) & (z <= z3) );
   area(index2) = pi * (0.5 * d + (z3 - z(index2)) .* tand(alpha3)).^2.;
   index3 = find( (z >= z1) & (z < z2) );
   area(index3)= pi * (0.5 * d + (z3 - z2) * tand(alpha3) + (z2 - z(index3)) * tand(alpha2)).^2.;
   index4 = find( (z >= (z0-dz)) & (z < z1) );
   area(index4) = pi * (0.5 * d + (z3 - z2) * tand(alpha3) + (z2 - z1) * tand(alpha2) + (z1 - z(index4)) * tand(alpha1)).^2.;

   index5 = find((b2 > 0) & (z >= (z3 - b2)) & (z <= z3) );
   area(index5) = pi * (0.5 * b1).^2.;
         
end % if


end % free_area(z)
