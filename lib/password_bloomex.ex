defmodule PasswordBloomex do
  @moduledoc """
  Documentation for PasswordBloomex.
  """

  @base_capacity 1000000

  final_filter =
    "./lib/10-million-password-list-top-1000000.txt"
    |> File.stream!()
    |> Stream.map(&String.trim_trailing/1)
    |> Enum.take(@base_capacity)
    |> Enum.reduce(Bloomex.scalable(@base_capacity, 0.1, 0.1, 2, &(Murmur.hash_x86_128(&1))), &Bloomex.add(&2, &1))

  @filter final_filter


  def compiletime_filter do
    @filter
  end

  def prohibited?(password) do
    Bloomex.member?(compiletime_filter(), password)
  end
end
