%%%-------------------------------------------------------------------
%%% @author jingxian.lzg
%%% @copyright (C) 2015, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 28. 十月 2015 13:56
%%%-------------------------------------------------------------------
-module(bertie).
-author("jingxian.lzg").

%% API
-export([start/0, stop/0]).

start() ->
  ok = application:ensure_started(syntax_tools),
  ok = application:ensure_started(compiler),
  ok = application:ensure_started(erlydtl),
  ok = application:ensure_started(crypto),
  ok = application:ensure_started(cowlib),
  ok = application:ensure_started(ranch),
  ok = application:ensure_started(cowboy),
  erlydtl:compile("templates/toppage.dtl", toppage_dtl),
  ok = application:ensure_started(bertie).

stop() ->
  application:stop(bertie).

%%start(Port) ->
%%  N_acceptors = 10,
%%  Dispatch = cowboy_router:compile([{'_',[{"/", simple_web_server, []}]}]),
%%  cowboy:start_http(my_simple_web_server, N_acceptors, [{port, Port}], [{env, [{dispatch, Dispatch}]}]),
%%  bertie_sup:start_link().

%%start_from_shell([PortAsAtom]) ->
%%  PortAsInt = list_to_integer(atom_to_list(PortAsAtom)),
%%  start(PortAsInt).

%%start() ->
%%  Handle = bitcask:open("bertie_db", [read_write]),
%%  N = fetch(Handle),
%%  store(Handle, N+1),
%%  io:format("bertie has been run ~p times~n", [N]),
%%  bitcask:close(Handle),
%%  init:stop().

%%store(Handle, N) ->
%%  bitcask:put(Handle, <<"bertie_executions">>, term_to_binary(N)).

%%fetch(Handle) ->
%%  case bitcask:get(Handle, <<"bertie_executions">>) of
%%    not_found -> 1;
%%    {ok, Bin} -> binary_to_term(Bin)
%%  end.