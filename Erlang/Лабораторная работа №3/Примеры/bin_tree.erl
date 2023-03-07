-module(bin_tree).
-export([empty/0, node/3, is_tree/1, is_empty/1, is_node/1, data/1, left/1, right/1, view/1]).

%% �������� ������ -- ���� �������� ������, ���� ������� �� ������ � ���� ����������� (������ �� ������� -- �������� ������).

%% ��� tree
-type tree() :: empty | {node, any(), tree(), tree()}.

%%% ��� ��������� �������� ����������
%%%%%%%%%%%%%%%%
%%% 1. ����� ������������
%%% ������������

-spec empty() -> tree(). %% ���������� ������ ������
empty() -> empty.

-spec node(Data::any(), Left::tree(), Right::tree()) -> tree(). %% ���������� �������� ������ � ������� Data, ����� ����������� Left � ������ ����������� Right
node(Data, Left, Right) -> {node, Data, Left, Right}.

%%% ���������

-spec is_tree(any()) -> boolean(). %% ���������, �������� �� X �������
is_tree(X) -> is_empty(X) orelse is_node(X).

-spec is_empty(tree()) -> boolean(). %% ���������, ������ �� ������
is_empty(empty) -> true;
is_empty(_) -> false.

-spec is_node(tree()) -> boolean. %% ���������, ���� �� � ������ ������ (����� �������� � ����� �� ���)
is_node({node, _, _, _}) -> true;
is_node(_) -> false.

%%% ���������

-spec data(tree()) -> any(). %% ���������� ������, ���� ��� ���� (�.�. ������ �������), ���������� ������, ���� ������ �����
data({node, Data, _, _}) -> Data.

-spec left(tree()) -> tree(). %% ���������� ����� ���������, ���������� ������, ���� ������ �����
left({node, _, Left, _}) -> Left.

-spec right(tree()) -> tree(). %% ���������� ������ ���������, ���������� ������, ���� ������ �����
right({node, _, _, Right}) -> Right.

%%% 2. ����� ������� � ����� � ��������������
%%% ������������ �� ��
%%% ��������� � ��������� ���������� ����� ��������
-spec view(tree()) -> 'empty' | {'node', any(), tree(), tree()}. %% ���������� ���� empty, ���� ������ �����, � ������ {node, Data, Left, Right}, ���� ��� �������, � �������� ������ Data, ����� ��������� Left � ������ ��������� Right
view(Tree) -> Tree.

%% ��������, ��� ������ �� ���� ����������� ����� ����������� ����� ������