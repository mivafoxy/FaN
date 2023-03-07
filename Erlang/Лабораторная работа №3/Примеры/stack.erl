-module(stack).
-export([test_stack/1]).

%% C��� ������ ��� ����, ����� ����������� � ��������� ������������ ������ � ������ "��������� ������ - ������ ����" ("LIFO"). �������, ����������� � ���� ���������, ����� �������� �� ���� ������.

%%% ����
%% type stack -- ����
%% any -- ������������ ��������

%%% �������
%% is_stack(any) -> boolean -- �������� ��������, ������������ �� ������������ �������� ����
%% empty_stack() -> stack -- �������� �������� ������� �����
%% push(stack, any) -> stack -- ��������� � ������ ����� ����� �������
%% is_empty(stack) -> boolean -- ���������, �������� �� ���� ������
%% pop(stack) -> {'ok', any, stack} | {'error', 'empty_stack'} -- ��������� ������� �� ������ ����� � ���������� ������ {ok, �������_�_������_�����, ���������_��������}, ���� ���� �� ����, � ���� {error, empty_stack}, ���� �� ����.

%% empty_stack � push -- ������������
%% is_stack � is_empty -- ���������
%% pop -- ��������.

%%% �������
%% ��� ���� �������� X, Y, Stack ������ �����������:
%% is_stack(empty_stack) =:= true
%% is_stack(Stack) => is_stack(push(X, Stack)) =:= true
%% pop(empty_stack()) =:= {error, empty_stack}
%% is_stack(Stack) => pop(push(X, Stack)) =:= {ok, X, Stack1} -- Stack1 � Stack "������" �����.
%% ���?

%%% ����������
%% type stack = [any]
is_stack(Stack) -> is_list(Stack).

empty_stack() -> [].

push(Stack, X) -> [X | Stack].

is_empty(Stack) -> Stack == [].

pop([]) -> {error, empty_stack};
pop([H | T]) -> {ok, H, T}.

%% ��������, ��� �������� ��� ������� ����� �� (���� �������� ������ ����������), ��
%% ������� ������


%% ������� ���������, ��� ���������� � ������ Module ������������ ���� ��������
test_stack(Module) ->
    S0 = Module:empty_stack(), %% � Erlang ��� �����! Module ������ ���� ������.
    true = Module:is_stack(S0),
    S1 = Module:push(a, S0),
    S2 = Module:push(b, S1),
    false = Module:is_empty(S2),
    {b, S3} = Module:pop(S2),
    {a, S4} = Module:pop(S3),
    true = Module:is_empty(S4). %% ����� ��� �������� ������...