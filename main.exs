defmodule Aoc do
  def find_sum(nums) do
    [head|tail] = nums
    find_sum(head, tail)
  end

  def find_sum(first, [head|tail]) do
    case Enum.find(tail, nil, get_search_fn(first)) do
      nil -> find_sum(head, tail)
      x when is_integer(x) -> {:ok, first, x}
      _ ->
        {:error, nil, nil}
    end
  end

  def get_search_fn(first_num) do
    fn x -> x+first_num == 2020 end
  end
end

{:ok, body} = File.read("input.txt")
nums = body |> String.split |> Enum.map(&(String.to_integer(&1)))
{:ok, first, second} = Aoc.find_sum(nums)
IO.puts("Numbers are ")
IO.puts(Integer.to_string(first))
IO.puts(" x ")
IO.puts(Integer.to_string(second))
IO.puts(" = ")
IO.puts(Integer.to_string(first*second))