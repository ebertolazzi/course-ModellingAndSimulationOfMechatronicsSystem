function [newP1,newP2,newP3] = Translate( P1, P2, P3, dx, dy )
  newP1 = P1+[dx,dy];
  newP2 = P2+[dx,dy];
  newP3 = P3+[dx,dy];
end
