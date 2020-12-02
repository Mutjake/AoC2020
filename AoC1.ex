defmodule AoC1 do
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


#####################################

  def get_search_fn(target, first_num) do
    fn x -> x+first_num == 2020-target end
  end

  def find_triplet_sum(target, nums) when length(nums) > 2 do
    [head|tail] = nums
    find_triplet_sum(target, head, tail)
  end

  def find_triplet_sum(_, _) do
    {:error, nil, nil}
  end

  def find_triplet_sum(target, first, [head|tail]) do
    case Enum.find(tail, nil, get_search_fn(target, first)) do
      nil -> find_triplet_sum(target, head, tail)
      {:ok, first, x} -> {:ok, first, x}
      x when is_integer(x) -> {:ok, first, x}
      _ ->
        {:error, nil, nil}
    end
  end

  def find_triplet_sum(_, _, []) do
    {:error, nil, nil}
  end

  def ts(nums) when length(nums) > 2 do
    [xh|xt] = nums
    case find_triplet_sum(xh, xt) do
      {:ok, y, z} -> {:ok, xh, y, z}
      {:error, _, _} -> ts(xt)
    end
  end

  def ts(_) do
    {:error, nil, nil}
  end

  def main() do
    {:ok, body} = File.read("input.txt")
    nums = body |> String.split |> Enum.map(&(String.to_integer(&1)))
    {:ok, first, second} = find_sum(nums)
    IO.puts("Numbers are #{Integer.to_string(first)} x #{Integer.to_string(second)} = #{Integer.to_string(first*second)}")

    res = ts(nums)
    {:ok, x, y, z} = res
    IO.puts("Numbers are #{inspect res}, multiplied they are #{Integer.to_string(x*y*z)}")
  end
end