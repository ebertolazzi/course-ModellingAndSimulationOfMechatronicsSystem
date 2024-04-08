function res = Perimeter( P1, P2, P3 )
  L12 = norm( P1 -P2 );
  L23 = norm( P2 -P3 );
  L31 = norm( P3 -P1 );
  res = L12+L23+L31;
end
