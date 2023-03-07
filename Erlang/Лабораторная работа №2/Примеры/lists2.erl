-module(lists2).
-compile(export_all).

map(_, [])    -> [];
map(F, [H|T]) -> [F(H)|map(F, T)].

filter(_,    [])    -> [];
filter(Pred, [H|T]) ->
    case Pred(H) of
        true  -> [H|filter(Pred, T)];
        false -> filter(Pred, T)
    end.

foldl(F, Acc, [Head|Tail]) ->
    foldl(F, F(Head, Acc), Tail);
foldl(F, Acc, []) when is_function(F, 2) -> Acc.

foldr(F, Acc, [Head|Tail]) ->
    F(Head, foldr(F, Acc, Tail));
foldr(F, Acc, []) when is_function(F, 2) -> Acc.


reverse(L) -> reverse(L, []).

reverse([H|T], L) -> reverse(T, [H|L]);
reverse([], L)    -> L.

member(X, [])              -> false;
member(X, [H|T]) if X == H -> true;
member(X, [_|T])           -> member(X, T).

search(Key, [{Key,Val}|_]) -> {ok, Val};
search(Key, [_|T])         -> search(Key, T);
search(_, [])              -> error.

sum([H|T]) -> H + sum(T);
sum([])    -> 0.

sum_via_fold(List) -> foldl(fun(X, Acc) -> X + Acc end, 0, List).
produce_via_fold(List) -> foldl(fun(X, Acc) -> X * Acc end, 1, List).