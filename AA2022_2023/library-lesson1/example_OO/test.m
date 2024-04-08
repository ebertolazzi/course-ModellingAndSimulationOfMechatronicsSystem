%
% testing Triangle class
%

p1 = [1,3];
p2 = [2,3];
p3 = [4,5];
t  = Triangle( p1, p2, p3 );

fprintf('Perimeter = %g\n', t.perimeter() );

fprintf('Perimeter (non OO) = %g\n', Perimeter( p1, p2, p3 ) );

hold off;
t.plot('Color','red');
t.translate(1,2);
hold on;
t.plot('Color','blue');

fprintf('Area = %g\n', t.area() );

