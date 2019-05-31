function R = free_radius(z)
%
% R = free_radius(z)
%
% Return the radius of the actual free passage area, at a given coordinate z, through the
% pipette.
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%
%
global alpha1 alpha2 alpha3 d;
global z0 z1 z2 z3 z4 a b1 b2;
global dz;

if (length(z)==1),  % z is not a vector!

if ( (z > (z4+dz)) || (z < (z0-dz)) || (b2 > (z3-z0)) ), 
 disp('free_area(): Error!! z or b2 out of boundaries'); 
 R    = nan;
 return; 
end

if     ( (z > z3) & (z <= (z4+dz)) ),
 R    = 0.5 * a; 
elseif ( (z >= z2) && (z <= z3) ),
 R    = 0.5 * d + (z3 - z) * tand(alpha3);
elseif ( (z >= z1) && (z < z2) ),
 R    = 0.5 * d + (z3 - z2) * tand(alpha3) + (z2 - z) * tand(alpha2);
elseif ( (z >= (z0-dz)) &&(z < z1) ),
 R    = 0.5 * d + (z3 - z2) * tand(alpha3) + (z2 - z1) * tand(alpha2) + (z1 - z) * tand(alpha1) ;
end

if ( (b2 > 0) && (z >= (z3 - b2)) && (z <= z3) ),
 R    = 0.5 * b1;
end

else     % z is a vector
   R = zeros(size(z));
   if (~isempty(find(z>z4, 1)) || ~isempty(find(z<(z0-dz), 1)) || (b2 > (z3-z0))),
    disp('free_area(): Error!! z or b2 out of boundaries'); 
    R = nan * R;
    return; 
   end  

   index1 = find( (z > z3) & (z <= z4) );
   R(index1) = 0.5 * a;
   index2 = find( (z >= z2) & (z <= z3) );
   R(index2) = 0.5 * d + (z3 - z(index2)) .* tand(alpha3);
   index3 = find( (z >= z1) & (z < z2) );
   R(index3)= 0.5 * d + (z3 - z2) * tand(alpha3) + (z2 - z(index3)) * tand(alpha2);
   index4 = find( (z >= (z0-dz)) & (z < z1) );
   R(index4) = 0.5 * d + (z3 - z2) * tand(alpha3) + (z2 - z1) * tand(alpha2) + (z1 - z(index4)) * tand(alpha1);

   index5 = find((b2 > 0) & (z >= (z3 - b2)) & (z <= z3) );
   R(index5) = 0.5 * b1;
    

% end if

end % free_radius()
