defmodule Essence.Utils do
  @moduledoc """
  This module contains various utility functions that simplify
  a number of the NLP tasks in Essence.
  """

  @doc """
  Sorts a given `map` either `by` `:value` or `:key` using the supplied
  `order_fun` for comparison between elements. Returns an ordered list of
  {key, value} tuples.
  """
  def map_sort(map = %{}, order_fun \\ &>/2, by \\ :value) do
    case by do
      :key -> map |> Map.to_list |> Enum.sort( fn( {akey,_}, {bkey,_} ) -> order_fun.(akey, bkey) end )
      _ -> map |> Map.to_list |> Enum.sort( fn( {_,aval}, {_,bval} ) -> order_fun.(aval, bval) end )
    end
  end
end
