-module(bin_tree).
-export([empty/0, node/3, is_tree/1, is_empty/1, is_node/1, data/1, left/1, right/1, view/1]).

%% Бинарное дерево -- либо является пустым, либо состоит из данных и двух поддеревьев (каждое из которых -- бинарное дерево).

%% Тип tree
-type tree() :: empty | {node, any(), tree(), tree()}.

%%% Два возможных варианта интерфейса
%%%%%%%%%%%%%%%%
%%% 1. Более традиционный
%%% Конструкторы

-spec empty() -> tree(). %% возвращает пустое дерево
empty() -> empty.

-spec node(Data::any(), Left::tree(), Right::tree()) -> tree(). %% возвращает непустое дерево с данными Data, левым наследником Left и правым наследником Right
node(Data, Left, Right) -> {node, Data, Left, Right}.

%%% Предикаты

-spec is_tree(any()) -> boolean(). %% проверяет, является ли X деревом
is_tree(X) -> is_empty(X) orelse is_node(X).

-spec is_empty(tree()) -> boolean(). %% проверяет, пустое ли дерево
is_empty(empty) -> true;
is_empty(_) -> false.

-spec is_node(tree()) -> boolean. %% проверяет, есть ли в дереве данные (можно обойтись и одним из них)
is_node({node, _, _, _}) -> true;
is_node(_) -> false.

%%% Селекторы

-spec data(tree()) -> any(). %% возвращает данные, если они есть (т.е. дерево непусто), выкидывает ошибку, если дерево пусто
data({node, Data, _, _}) -> Data.

-spec left(tree()) -> tree(). %% возвращает левое поддерево, выкидывает ошибку, если дерево пусто
left({node, _, Left, _}) -> Left.

-spec right(tree()) -> tree(). %% возвращает правое поддерево, выкидывает ошибку, если дерево пусто
right({node, _, _, Right}) -> Right.

%%% 2. Более удобный в языке с сопоставлением
%%% Конструкторы те же
%%% Предикаты и селекторы заменяются одной функцией
-spec view(tree()) -> 'empty' | {'node', any(), tree(), tree()}. %% возвращает атом empty, если дерево пусто, и кортеж {node, Data, Left, Right}, если оно непусто, и содержит данные Data, левое поддерево Left и правое поддерево Right
view(Tree) -> Tree.

%% Заметьте, что каждый из этих интерфейсов легко реализуется через другой