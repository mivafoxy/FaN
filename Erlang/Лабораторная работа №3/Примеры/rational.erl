-module(rational).
-export([is_rational/1, make/2, make/1, add/2,
         sub/2, mult/2, divide/2, inv/1, neg/1]).

-record(rational, {top, bot}).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) -> (A*B) div gcd(A, B).

is_rational(X) when record(X, rational) -> true;
is_rational(_) -> false.

make(Top, Bot) ->
    Gcd = gcd(Top, Bot),
    #rational{top = Top div Gcd, bot = Bot div Gcd}.

make(Num) when is_integer(Num) -> make(Num, 1);
make(Num) when record(Num, rational) -> Num.

inv(X) ->
    A = make(X),
    make(A#rational.bot, A#rational.top).

neg(X) ->
    A = make(X),
    make(-A#rational.top, A#rational.bot).

mult(X, Y) ->
    A = make(X),
    B = make(Y),
    Top = A#rational.top * B#rational.top,
    Bot = A#rational.bot * B#rational.bot,
    Gcd = gcd(Top, Bot),
    make(Top div Gcd, Bot div Gcd).

divide(X, Y) -> mult(X, inv(Y)).

add(X, Y) ->
    A = make(X),
    B = make(Y),
    Lcm = lcm(A#rational.bot, B#rational.bot),
    Top = A#rational.top * (Lcm div A#rational.bot) +
          B#rational.top * (Lcm div B#rational.bot),
    make(Top, Lcm).

sub(X, Y) -> add(X, neg(Y)).