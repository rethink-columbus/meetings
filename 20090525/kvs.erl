-module(kvs).
-compile(export_all).

start() ->
  spawn(fun() -> loop() end).

stop(Pid) ->
  Pid ! stop.

loop() ->
  receive
    {Caller, {store, Key, Value}} ->
      put(Key, Value),
      Caller ! {stored, Key},
      loop();
    {Caller, {lookup, Key}} ->
      Caller ! {found, get(Key)},
      loop();
    stop ->
      io:format("stopping~n"),
      ok;
    Other ->
      io:format("I don't understand!!"),
      loop()
  end.

store(Pid, Key, Value) ->
  Pid ! {self(), {store, Key, Value}},
  receive
    {stored, Key} ->
      io:format("~p stored!", [Key]),
      ok;
    Other ->
      io:format("Boom!")
  end.

lookup(Pid, Key) ->
  Pid ! {self(), {lookup, Key}},
  receive
    {found, Value} ->
      Value
  end.

