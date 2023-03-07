-module(bin_search_tree).
-export([empty/0, is_empty/1, insert/2, contains/2]).
-import(bin_tree, [empty/0, node/3, is_empty/1, data/1, left_child/1, right_child/1, view/1]).

%% Бинарное дерево поиска характеризуется тем, что у дерева
%% (Data, Left, Right) все data в Left меньше, чем Data, а в Right - больше.
