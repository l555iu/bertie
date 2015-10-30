%%%-------------------------------------------------------------------
%%% @author alacxian
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 十月 2015 5:04 PM
%%%-------------------------------------------------------------------
-module(simple_web_server).
-author("alacxian").

%% API
-compile(export_all).

start(Port) ->
    N_acceptors = 10,
    Dispatch = cowboy_router:compile([{'_', [{'_', simple_web_server, []}]}]),
    cowboy:start_http(my_simple_web_server, N_acceptors, [{port, Port}], [{env, [{dispatch, Dispatch}]}]).

start_from_shell([PortAsAtom]) ->
    PortAsInt = list_to_integer(atom_to_list(PortAsAtom)),
    start(PortAsInt).

handle(Req, State) ->
    {ok, Req2} = cowboy_req:reply(200, [
        {<<"content-type">>, <<"text/plain">>}
    ], <<"Hello World!">>, Req),
    {ok, Req2, State}.

init(_Type, Req, _Opts) ->
    {ok, Req, no_state}.

%init(Req, Opts) ->
% {Path, Req1} = cowboy_req:path(Req),
%  io:format("===========path ~p~n",["abc"]),
%  Response = read_file(<<"/erl_crash.dump">>),
%  {ok, Req2} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/plain">>}], Response, Req),
%  {ok, Req2, Opts}.

%handle(Req, State) ->
%{Path, Req1} = cowboy_req:path(Req),
%Response = read_file(Path),
%  {ok, Req2} = cowboy_req:reply(200, [{<<"content-type">>, <<"text/plain">>}], <<"Hello Erlang!">>, Req),
%  {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.

read_file(Path) ->
    File = ["." | binary_to_list(Path)],
    case file:read_file(File) of
        {ok, Bin} -> Bin;
        _ -> ["<pre>cannot readL", File, "</pre>"]
    end.