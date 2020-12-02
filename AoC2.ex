defmodule AoC2 do
  def tokenize_password(pw) do
    Enum.reduce(String.graphemes(pw), %{}, fn x, acc -> Map.update(acc, x, 1, fn c -> c+1 end) end)
  end

  def fills_pw_req(map) when is_map(map) do
    key = Map.get(map, "char")
    count = Map.get(map, "password") |> Map.get(key)
    Map.get(map, "min") <= count && count <= Map.get(map, "max")
  end

  def parse_row(row) do
    Regex.named_captures(~r/(?<min>\d+)\-(?<max>\d+) (?<char>[a-z])\: (?<password>[a-z]+)/, row)
      |> Map.update!("min", fn x -> String.to_integer(x) end)
      |> Map.update!("max", fn x -> String.to_integer(x) end)
  end 

  def has_enough_required_chars(row) do
    row
      |> Map.update!("password", &(tokenize_password(&1)))
      |> fills_pw_req
  end

  def has_exactly_one_in_specified_locations(row) do
    pw = Map.get(row, "password")
    char = Map.get(row, "char")
    min_char = String.at(pw, Map.get(row, "min")-1)
    max_char = String.at(pw, Map.get(row, "max")-1)
    ((min_char === char and max_char !== char) or (min_char !== char and max_char === char))
  end

  def main() do
    {:ok, body} = File.read("input2.txt")
    body 
      |> String.split(["\n"]) 
      |> Enum.map(&(parse_row(&1) |> has_enough_required_chars)) 
      |> Enum.filter(&(&1))
      |> length
      |> Integer.to_string
      |> IO.puts
    body 
      |> String.split(["\n"])
      |> Enum.map(&(parse_row(&1) |> has_exactly_one_in_specified_locations))
      |> Enum.filter(&(&1))
      |> length
      |> Integer.to_string
      |> IO.puts
  end
end