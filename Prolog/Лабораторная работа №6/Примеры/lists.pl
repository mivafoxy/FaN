my_append([], List, List).
my_append([H|T1], List2, [H|TResult]) :- my_append(T1, List2, TResult).

replace_first([_|T],A,[A|T]).

list([]).
list([H|T]) :- list(T).

% ?-append(L1, L2, [a, b, c]). 
% ?-append(L, [3|R], [1, 2, 3, 4, 5]).

write_last([X]) :- write('��������� ������� ������: '), write(X), nl.
write_last([H|T]) :- write_last(T).

my_last([Last], Last).
my_last([H|T], Last) :- my_last(T, Last).

%% �������������
my_last2(List, Last) :- my_append(_, [Last], List).

%% ������ �� ����� ������� ��� []?
%% ����� ��������� ������ my_member([], X)?
my_member([H|T], H).
my_member([_|T], X) :- my_member(T, X).

%% ��������� ��������� ��� �������� ������� ����� �� ������ �������
naive_rev([], []).
naive_rev([H|T], Rev) :- naive_rev(T, RevT),
                         my_append(RevT, [H], Rev).

acc_rev(List, RevList) :- acc_rev(List, RevList, []).

acc_rev([], RevList, RevList).
acc_rev([H|T], RevList, Acc) :- acc_rev(T, RevList, [H|Acc]).