-module(example_web).
-export([start/0, stop/0]).

start() ->
  Options = [ {ip, "0.0.0.0"}, {port, 4545} ],
  Loop = fun(Req) -> loop(Req, []) end,
  mochiweb_http:start([ {name, ?MODULE}, {loop, Loop} | Options ]).

stop() ->
  mochiweb_http:stop(?MODULE).

loop(Req, Clients) ->
  Body = io_lib:format("Requested: ~p, Clients: ~p", [Req:get(path), Clients]),
  % loop(_, [Clients | new_client]),
  Req:ok({ "text/plain", Body }).
