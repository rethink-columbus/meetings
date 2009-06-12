-module(euler_004).
-export([start/0]).

% Find the largest palindrome made from the product of two 3-digit numbers.
% run at the OS shell with: erl -noshell -s euler_004 -run init stop

start() -> io:format("Answer: ~B~n",[try_pal(997)]).

brute(99, _) -> false;
brute(TestFactor, Pal) when (Pal rem TestFactor =:= 0) ->
  OtherFactor = Pal div TestFactor,
  ((OtherFactor > 99) and (OtherFactor < 1000)) orelse brute(TestFactor - 1, Pal);
brute(TestFactor,Pal) -> brute(TestFactor -1, Pal).

try_pal(Left) ->
  Pal = pal(Left),
  case brute(999, Pal) of
    true -> Pal;
    false -> try_pal(Left -1)
  end.
    
pal(Left) ->
  Left * 1000 +
    (Left rem 10) * 100 + % 300
    (Left rem 100 div 10) * 10 +
    (Left div 100).