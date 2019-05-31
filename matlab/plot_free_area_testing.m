function plot_free_area_testing
%
% PLOT_FREE_AREA_TESTING
%
% Plot the free area - for testing purpouses only
%
%
% (c) 2010-2011 Michele Giugliano, PhD - michele.giugliano@ua.ac.be
% Department of Biomedical Sciences, University of Antwerp (Belgium)
%


set_parameters;              % Load all parameters.
dz = 0.005;                  % Only for graphical purpouses..

figure(1);                   % Open a figure
hold on;                     % Set its mode to overlap traces

if (b2>0),                   % If a clog is defined
 temp = b2;                  % Let's first plot the pipette without the clog
 b2   = 0;                   % temporarily storing the value of 'b2'
 bool = 2;                   % and preparing to plot twice
else
 bool = 1;                   % If no clog is present, proceed normally.
end

while (bool) 
 z  = z0:dz:z4;              % Initialize the x-axis to plot
 RR = zeros(length(z),2);    % Initialize the vector to plot
 % SCALAR FORM   
%  for k=1:length(z),          % Let's span the entire length of the pipette
%   RR(k,1)  = z(k);           % Store it into 'RR'
%   RR(k,2)  = free_radius(z(k)); % Return section radius
%  end
 
%VECTORIAL FORM 
RR = free_radius(z);        % Return section radius
RR = [z', RR'];

RR(end,2) = 0;              % only for graphical purposes

i1 = ceil(z1/dz);           % Index corresponding to a change in slope
i2 = ceil(z2/dz);           % Index corresponding to a change in slope
i3 = ceil(z3/dz);           % Index corresponding to the end of the pipette
i4 = ceil(z4/dz);           % Index corresponding to the end of the patch
i5 = ceil((z3-b2)/dz);      % Index corresponding to the clog
 
P1 = plot(RR(1:i3,1),      RR(1:i3,2), 'k');    % Let's plot the pipette
P2 = plot(RR(1:i3,1),     -RR(1:i3,2), 'k');    %
P3 = plot(RR(i3:end,1),  RR(i3:end,2), 'b');    % and the membrane patch
P4 = plot(RR(i3:end,1), -RR(i3:end,2), 'b');    %

set([P1 P2 P3 P4], 'LineWidth', 2);
if (b2>0)                                       % If a clog is defined
 P5 = plot(RR(i5:i3,1),  RR(i5:i3,2), 'b');     % Let's plot it
 P6 = plot(RR(i5:i3,1), -RR(i5:i3,2), 'b');     %
 set([P5 P6], 'LineWidth', 2);
end

bool = bool -1;                                 % Decrease the counter
if (bool == 1), b2 = temp; end;                 % for double plotting..
end 


%hold off;

% Let's set the X and Y scales so that the aspect ratio is 1:1
%XLIM = [z0-d z4+d];
XLIM = [z1-d z4+d];
YLIM = [-1 1] * 0.5 * diff(XLIM);
set(gca, 'XLim', XLIM, 'YLim', YLIM);

% Cosmetics for the axes..
set(gcf, 'Color', [1 1 1]);
set(gca, 'XTick', [z0 z1 z2 z3 z4], 'XTickLabel', {'z0' 'z1' 'z2' 'z3' 'z4'});
set(gca, 'XGrid', 'on', 'YGrid', 'on');
set(gca, 'YTick', [-d/2 d/2], 'YTickLabel', {'-d/2' 'd/2'});
set(gca, 'Box', 'on');
axis square;
xlabel('Length [um]');
ylabel('Length [um]');

mystring = sprintf('f = %.2f   b = %.2f um    r = %.2f um', f, b, r);
text(z1+d/2, YLIM(2)*0.6, mystring);

% Let's print it as a file, with a unique name...
mypic_name = sprintf('shape_run%s.png', datestr(now, 'yyyymmdd_HHMMSS'));
print(gcf, '-loose', '-dpng', mypic_name);
%mypic_name = sprintf('shape_run%s.eps', datestr(now, 'yyyymmdd_HHMMSS'));
%print(gcf, '-loose', '-depsc2', mypic_name);


figure(2);                   % Open a figure
set(gcf, 'Color', [1 1 1]);
plot(z, free_area(z), 'k', 'LineWidth', 1.5);
set(gca, 'XTick', [z0 z1 z2 z3 z4], 'XTickLabel', {'z0' 'z1' 'z2' 'z3' 'z4'});
set(gca, 'XGrid', 'on', 'YGrid', 'on');
set(gca, 'Box', 'on');
axis square;
ylim([0 pi * r^2]);
xlabel('Length [um]');
ylabel('Area [um^2]');

% Let's print it as a file, with a unique name...
mypic_name = sprintf('free_area_run%s.png', datestr(now, 'yyyymmdd_HHMMSS'));
print(gcf, '-loose', '-dpng', mypic_name);
%mypic_name = sprintf('free_area_run%s.eps', datestr(now, 'yyyymmdd_HHMMSS'));
%print(gcf, '-loose', '-depsc2', mypic_name);

