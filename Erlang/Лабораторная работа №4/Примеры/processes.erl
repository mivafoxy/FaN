-module(processes).
-export([max/1]).
%% max(N)
%% Create N processes then destroy them
%% See how much time this takes
max(N) ->
	Max = erlang:system_info(process_limit),
	io:format("Maximum allowed processes:~p~n" ,[Max]),
	statistics(runtime),
	statistics(wall_clock),
	L = for(1, N, fun() -> spawn(fun() -> wait() end) end),
	{_, Time1} = statistics(runtime),
	{_, Time2} = statistics(wall_clock),
	lists:foreach(fun(Pid) -> Pid ! die end, L),
	U1 = Time1 * 1000 / N,
	U2 = Time2 * 1000 / N,
	io:format("Average process spawn time=~p CPU (~p elapsed) microseconds~n" , [U1, U2]).

wait() ->
	receive
		die -> void
	end.

for(To, To, F) -> [F()];
for(From, To, F) -> [F()|for(From+1, To, F)].
