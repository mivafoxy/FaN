-module(fact).
-compile(export_all).

fac1(0) -> 1;
fac1(N) when N > 0 -> N * fac1(N-1).

fac2(0) -> 1;
fac2(N) when is_integer(N), N > 0 -> N * fac2(N-1);
fac2(N) when is_integer(N), N < 0 -> exit({factorialNegativeArgument, N});
fac2(X) -> exit({factorialArgumentNotAnInteger, X}).
