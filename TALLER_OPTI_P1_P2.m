% .-------------------------------------------------.
% |                                                 |
% |     __  __      _ ___              __           |
% |    / / / /___  (_)   |  ____  ____/ /__  _____  |
% |   / / / / __ \/ / /| | / __ \/ __  / _ \/ ___/  |
% |  / /_/ / / / / / ___ |/ / / / /_/ /  __(__  )   |
% |  \____/_/ /_/_/_/  |_/_/ /_/\__,_/\___/____/    |
% |                                                 |
% '-------------------------------------------------'
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% ~~~~~~~~~~~~~~~~~~ POINT 1 ~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%    Author  : Esteban Rodríguez
%    Date    : 02.2026
%    Purpose : Minimize absolute error (E) for a given 
%              set of points
%    Notes   : OptimizaciOn 2026-1
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% '-------------------------------------------------'

% Given points (x,y) definition
points = [1 5/2;2 7/2;3 10;5 10;7 17;8 15;10 22];
n_points = length(points);

% Matrix A and b initialization
A = zeros(2*n_points,3);
b = zeros(2*n_points,1);

% Populate the matrix A and vector b based on the given points
% according to general constraints equations for i in [0,7]:
% * -ax_i-b-E<=-y_i
% *  ax_i+b-E<= y_i
for i = 1:n_points
    p_index = 2*i-1;
    A(p_index,:) = [-points(i,1), -1, -1];
    b(p_index) = -points(i,2);

    A(p_index+1,:) = [points(i,1), 1, -1];
    b(p_index+1) = points(i,2);
end
% Define the optimization problem:
% Objective function coefficients for decision variables [a,b,E]
z = [0 0 1];
% Lower bounds for the variables
lb = [0; 0; 0]; 
% Solving the LP problem
x_opt = linprog(z,A,b,[],[],lb,[]);
% Optimal values for decision variables
a_opt = x_opt(1);
b_opt = x_opt(2);
E_opt = x_opt(3);
% Solution visualization
figure
scatter(points(:,1), points(:,2), 'filled')
hold on
x_lin = linspace(-1,11,20);
y_lin = a_opt*x_lin+b_opt;
plot(x_lin,y_lin);
title('Punto 1 - Recta con error mínimo para un conjunto de puntos')
xlabel('X')
ylabel('Y')
text(5,8, sprintf('Valor mínimo de E = %.3f',E_opt))
text(5,6, sprintf('Ecuación de la recta y = %.3fx+%.3f',a_opt,b_opt))
xlim([0 11])
ylim([0 23])
grid on
hold off
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%% ~~~~~~~~~~~~~~~~~~ POINT 2 ~~~~~~~~~~~~~~~~~~~~~~
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%    Author  : Esteban Rodríguez
%    Date    : 02.2026
%    Purpose : Find optimal values for z  
%              graphically
%    Notes   : OptimizaciOn 2026-1
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% '-------------------------------------------------'
% Mesh creation for R^2 
x = -10:0.01:10 ; 
y = -10:0.01:10 ; 
[X,Y] = meshgrid(x,y);
% Evaluation and visualtion of constrains in R^2
%---
ineq_1 = (-Y<=5);
ineq_1 = double(ineq_1);
ineq_1(ineq_1==0) = NaN;
figure
h = pcolor(X,Y,double(ineq_1)) ;
h.EdgeColor = 'none' ;
title('Región factible para restricción 1')
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
%---
ineq_2 = (-Y<=5) & (2*X-Y<=6);
ineq_2 = double(ineq_2);
ineq_2(ineq_2==0) = NaN;
figure
h = pcolor(X,Y,double(ineq_2)) ;
h.EdgeColor = 'none' ;
title('Región factible para restricción 1 y 2')
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
%---
ineq_3 = (-Y<=5) & (2*X-Y<=6) & (-2*X+Y<=2);
ineq_3 = double(ineq_3);
ineq_3(ineq_3==0) = NaN;
figure
h = pcolor(X,Y,double(ineq_3)) ;
h.EdgeColor = 'none' ; 
title('Región factible para restricción 1 - 3')
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
%---
ineq_4 = (-Y<=5) & (2*X-Y<=6) & (-2*X+Y<=2) & (-2*X-Y<=6);
ineq_4 = double(ineq_4);
ineq_4(ineq_4==0) = NaN;
figure
h = pcolor(X,Y,double(ineq_4)) ;
h.EdgeColor = 'none' ; 
title('Región factible para restricción 1 - 4')
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
%---
ineq_5 = (-Y<=5) & (2*X-Y<=6) & (-2*X+Y<=2) & (-2*X-Y<=6) & (2*X+Y<=2);
ineq_5 = double(ineq_5);
ineq_5(ineq_5 == 0) = NaN;
figure
h = pcolor(X,Y,double(ineq_5)) ;
h.EdgeColor = 'none' ;
title('Región factible para restricción 1 - 5')
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
%---
ineq = (-Y<=5) & (2*X-Y<=6) & (-2*X+Y<=2) & (-2*X-Y<=6) & (2*X+Y<=2) & (Y<=1); 
ineq = double(ineq) ;
ineq(ineq==0) = NaN ;
figure
h = pcolor(X,Y,double(ineq)) ;
h.EdgeColor = 'none' ;
title('Región factible para restricciones del problema de PL')
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')

% Non-negativity constraint to obtain feasiable set
ineq_nn = (-Y<=5) & (2*X-Y<=6) & (-2*X+Y<=2) & (-2*X-Y<=6) & (2*X+Y<=2) & (Y<=1) & (X>=0) & (Y>=0); 
ineq_nn = double(ineq_nn) ;
ineq_nn(ineq_nn==0) = NaN ;
figure
h = pcolor(X,Y,double(ineq_nn)) ;
h.EdgeColor = 'none' ;
title('Región factible para restricciones del problema de PL con condiciones de no negatividad')
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
xlim([0 2])
ylim([0 2])
%  Obtaining the solution by graphic method using cost function contour
%  lines over the feasible set.
figure
h = pcolor(X,Y,double(ineq_nn)) ;
h.EdgeColor = 'none' ;
title('Solución gráfica al problema planteado.')
xlabel('$x_1$', 'Interpreter', 'latex')
ylabel('$x_2$', 'Interpreter', 'latex')
xlim([0 2])
ylim([0 2])
hold on
h.EdgeColor = 'none' ;
Z_FR = (ineq_nn==1);
Z = -5*X+2*Y;
contour(X,Y,Z,250,"ShowText",true,"LabelFormat","%0.1f")
colormap(winter)
grid on