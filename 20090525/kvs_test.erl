-module(kvs_test).
-include_lib("eunit/include/eunit.hrl").

% running tests ->
% compile kvs module into erlang: c(kvs).
% compile the kvs_test module into erlang: c(kvs_test).
% run the tests using the test() function eunit provides: kvs_test:test().

storage_test_() ->
  {setup, fun() -> kvs:start() end,
   fun(Pid) -> kvs:stop(Pid) end,
   fun build_storage_tests/1}.

build_storage_tests(Pid) ->
  [?_assertEqual(ok, kvs:store(Pid, jon, awesome)),
   ?_assertEqual(awesome, kvs:lookup(Pid, jon))].
