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
-export([start/0]).

start() ->
  Handle = bitcask:open("bertie_db", [read_write]),
  N = fetch(Handle),
  store(Handle, N+1),
  io:format("bertie has been run ~p times~n", [N]),
  bitcask:close(Handle),
  init:stop().

store(Handle, N) ->
  bitcask:put(Handle, <<"bertie_executions">>, term_to_binary(N)).

fetch(Handle) ->
  case bitcask:get(Handle, <<"bertie_executions">>) of
    not_found -> 1;
    {ok, Bin} -> binary_to_term(Bin)
  end.
