-module(geometry).  
-export([area/1, perimeter/1]). 

area({rectangle, Width, Ht}) -> Width * Ht;
area({circle, R})            -> 3.14159 * R * R.

perimeter({square, X})            -> 4 * X;
perimeter({rectangle, Width, Ht}) -> 2 * (Width+Ht);
perimeter({circle, R})            -> 2 * math:pi() * R;
perimeter({triangle, A, B, C})    -> A + B + C.
