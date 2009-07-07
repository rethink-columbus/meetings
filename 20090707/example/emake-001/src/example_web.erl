-module(example_web).
-export([start/0, stop/0, loop/1]).

start() ->
  Options = [ {ip, "0.0.0.0"}, {port, 4545} ],
  mochiweb_http:start([ {name, ?MODULE}, {loop, {?MODULE, loop}} | Options ]).

stop() ->
  mochiweb_http:stop(?MODULE).

loop(Req) ->
  Req:ok({ "text/plain", io_lib:format("Requested: ~p", [Req:get(path)]) }).
