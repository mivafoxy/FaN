% 1> Pid = spawn(fun area_server0:loop/0).
% <0.36.0>
% 2> Pid ! {rectangle, 6, 10}.
% Area of rectangle is 60
% {rectangle,6,10}
% 3> Pid ! {circle, 23}.
% Area of circle is 1661.90
% {circle,23}
% 4> Pid ! {triangle,2,4,5}.
% I don't know what the area of a {triangle,2,4,5} is
% {triangle,2,4,5}

% 1> Pid = spawn(fun area_server0:loop/0).
% <0.51.0>
% 2> register(area, Pid).
% true
% Once the name has been registered, we can send it a message like this:
% 3> area ! {rectangle, 4, 5}.
% Area of rectangle is 20
% {rectangle,4,5}
% 4> whereis(area).
% <0.51.0>

-module(area_server0).
-export([loop/0]).

loop() ->
	receive
		{rectangle, Width, Ht} ->
			io:format("Area of rectangle is ~p~n" ,[Width * Ht]),
			loop();
		{circle, R} ->
			io:format("Area of circle is ~p~n" , [3.14159 * R * R]),
			loop();
		Other ->
			io:format("I don't know what the area of a ~p is ~n" ,[Other]),
			loop()
end.

