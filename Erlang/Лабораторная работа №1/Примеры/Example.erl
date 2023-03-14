%% Содержимое файла Example.erl
-module(example).
%% вместо export можно использовать -compile(export_all).
-export([add/2, subtr/2, mult/2, divis/2]).
-import(io, [format/2]).

add(X, Y) -> X + Y.
subtr(X, Y) -> X - Y.
mult(X, Y) -> X * Y.
divis(X, Y) -> X div Y.