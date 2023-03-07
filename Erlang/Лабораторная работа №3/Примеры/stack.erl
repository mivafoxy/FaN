-module(stack).
-export([test_stack/1]).

%% Cтек служит для того, чтобы накапливать и доставать произвольные данные в режиме "последним пришел - первым ушел" ("LIFO"). Элемент, вставленный в стек последним, будет извлечен из него первым.

%%% Типы
%% type stack -- стек
%% any -- произвольное значение

%%% Функции
%% is_stack(any) -> boolean -- операция проверки, представляет ли произвольное значение стек
%% empty_stack() -> stack -- операция создания пустого стека
%% push(stack, any) -> stack -- добавляет в начало стека новый элемент
%% is_empty(stack) -> boolean -- проверяет, является ли стек пустым
%% pop(stack) -> {'ok', any, stack} | {'error', 'empty_stack'} -- извлекает элемент из начала стека и возвращает тройку {ok, Элемент_в_начале_стека, Остальные_элементы}, если стек не пуст, и пару {error, empty_stack}, если он пуст.

%% empty_stack и push -- конструкторы
%% is_stack и is_empty -- предикаты
%% pop -- селектор.

%%% Аксиомы
%% Для всех значений X, Y, Stack должны выполняться:
%% is_stack(empty_stack) =:= true
%% is_stack(Stack) => is_stack(push(X, Stack)) =:= true
%% pop(empty_stack()) =:= {error, empty_stack}
%% is_stack(Stack) => pop(push(X, Stack)) =:= {ok, X, Stack1} -- Stack1 и Stack "равные" стеки.
%% ещё?

%%% реализация
%% type stack = [any]
is_stack(Stack) -> is_list(Stack).

empty_stack() -> [].

push(Stack, X) -> [X | Stack].

is_empty(Stack) -> Stack == [].

pop([]) -> {error, empty_stack};
pop([H | T]) -> {ok, H, T}.

%% Заметьте, что операции для очереди такие же (хотя названия обычно отличаются), но
%% аксиомы другие


%% функция проверяет, что реализация в модуле Module соответсвует этим аксиомам
test_stack(Module) ->
    S0 = Module:empty_stack(), %% В Erlang так можно! Module должен быть атомом.
    true = Module:is_stack(S0),
    S1 = Module:push(a, S0),
    S2 = Module:push(b, S1),
    false = Module:is_empty(S2),
    {b, S3} = Module:pop(S2),
    {a, S4} = Module:pop(S3),
    true = Module:is_empty(S4). %% Можно ещё добавить тестов...