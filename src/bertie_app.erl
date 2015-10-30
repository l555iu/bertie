-module(bertie_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([
        {'_', [{"/", my_handler, []}]}
    ]),
    cowboy:start_http(my_http_listner, 100, [{port, 5000}], [{compress, true}, {env, [{dispatch, Dispatch}]}]),
    bertie_sup:start_link().

stop(_State) ->
    ok.
