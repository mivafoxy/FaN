-module(count_chars).
-export([file/1, file1/1, file2/1]).

with_file(File, Fun, Initial) ->
    case file:open(File, [read, raw, binary]) of
        {ok, Fd} ->
            try feed(Fd, file:read(Fd, 1024), Fun, Initial) of
                Res -> file:close(Fd), Res
            catch
                Class:Reason -> file:close(Fd), erlang:raise(Class, Reason, erlang:get_stacktrace())
            end;
        {error, Reason} -> {error, Reason}
    end.

scan_file(Fd, Occurs, {ok, Binary}) ->
    scan_file(Fd, Occurs + count_x(Binary), file:read(Fd, 1024));
scan_file(Fd, Occurs, eof) ->
    file:close(Fd),
    Occurs;
scan_file(Fd, _Occurs, {error, Reason}) ->
    file:close(Fd),
    {error, Reason}.

count_x(Bin) ->
    count_x(binary_to_list(Bin), 0).
count_x([$x|Tail], Ack) ->
    count_x(Tail, Ack+1);
count_x([_|Tail], Ack) ->
    count_x(Tail, Ack);
count_x([], Ack) ->
    Ack.


with_file(File, Fun, Initial) ->
    case file:open(File, [read, raw, binary]) of
    {ok, Fd} ->
        Res = feed(Fd, file:read(Fd, 1024), Fun, Initial),
        file:close(Fd),
        Res;
    {error, Reason} ->
    {error, Reason}
    end.


feed(Fd, {ok, Bin}, Fun, FArg) ->
    case Fun(Bin, FArg) of
        {done, Res} ->
            Res;
        {more, Acc} ->
            feed(Fd, file:read(Fd, 1024), Fun, Acc)
    end;
feed(Fd, eof, Fun, Acc) ->
    Acc;
feed(_Fd, {error, Reason}, _Fun, _Acc) ->
    {error, Reason}.


file1(File) ->
    F = fun(Bin, Int) ->
        {more, count_x(Bin) + Int}
    end,
    with_file(File, F, 0).
