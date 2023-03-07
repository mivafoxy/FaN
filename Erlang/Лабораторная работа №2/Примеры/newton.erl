-module(newton).
-export([sqrt1/2, newton/3, converge/3, sqrt3/2, sqrt4/2]).

%% X : number
%% Eps : number
%% sqrt1(X, Eps) -> number
sqrt1(X, Eps) -> sqrt1iter(X, 1, Eps).

sqrt1iter(X, Guess, Eps) ->
  IsGoodEnough = abs(Guess*Guess - X) < Eps,
  case IsGoodEnough of
    true -> Guess;
    false ->
      ImprovedGuess = (Guess + X/Guess)/2,
      sqrt1iter(X, ImprovedGuess, Eps)
    end.

sqrt2iter(X, Guess, Eps) ->
  case isGoodEnoughSqrt(X, Guess, Eps) of
    true -> Guess;
    false ->
      ImprovedGuess = improveSqrt(X, Guess),
      sqrt2iter(X, ImprovedGuess, Eps)
    end.

isGoodEnoughSqrt(X, Guess, Eps) -> abs(Guess*Guess - X) < Eps.

improveSqrt(X, Guess) -> (Guess + X/Guess)/2.

%% Guess : number
%% Improve : fun(number) -> number
%% IsGoodEnough : fun(number) -> bool
%% converge(Guess, Improve, IsGoodEnough) -> number
converge(Guess, Improve, IsGoodEnough) ->
  case IsGoodEnough(Guess) of
    true -> Guess;
    false ->
      ImprovedGuess = Improve(X, Guess),
      converge(ImprovedGuess, Improve, IsGoodEnough)
  end.

sqrt3(X, Eps) ->
  converge(
    1,
    fun(Guess) -> abs(Guess*Guess - X) < Eps end,
    fun(Guess) -> (Guess + X/Guess)/2 end).

%% F : number -> number
%% X0 : number
%% Eps : number
newton(F, X0, Eps) ->
  DF = derive(F),
    ImproveX = fun(X) -> X - F(X)/DF(X) end,
    IsGoodEnough = fun(X) -> abs(F(X)) < Eps end,
  converge(X0, ImproveX, IsGoodEnough).

sqrt4(X, Eps) ->
  newton(fun(Y) -> Y*Y - X end, 1, Eps).

%% define average_damp, etc.
