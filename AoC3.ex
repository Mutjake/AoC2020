# Not my finest work :-D

defmodule AoC3 do
  def find_tree(tpl, vert_moves, hor_moves) when vert_moves == 1 do
    rowlen = 31
    index = elem(tpl, 0)
    row = elem(tpl, 1)
    charpos = rem(div((index), vert_moves)*hor_moves, rowlen)
    Tuple.append(tpl, String.at(row, charpos))
  end

  def find_tree(tpl, vert_moves, hor_moves) when vert_moves != 1 do
    rowlen = 31
    index = elem(tpl, 0)
    row = elem(tpl, 1)
    charpos = rem(div((index-1), vert_moves)*hor_moves, rowlen)
    Tuple.append(tpl, String.at(row, charpos))
      |> Tuple.append(charpos)
  end

  def thingmabob(rows, verticals, horticals) when verticals == 1 do
    1..(length(rows)-1)
      |> Enum.map(&({&1, Enum.at(rows, &1)})) # Enum.with_index *facepalm*
      |> Enum.map(&(find_tree(&1, verticals, horticals)))
      |> Enum.filter(&(elem(&1, 2) === "#"))
      |> length
  end

  def thingmabob(rows, verticals, horticals) when verticals != 1 do
    1..(length(rows)-1)
      |> Enum.map(&({&1, Enum.at(rows, &1-1)})) # Enum.with_index *facepalm*
      |> Enum.drop(1)
      |> Enum.drop_every(verticals)
      |> Enum.map(&(find_tree(&1, verticals, horticals)))
#      |> inspect
#      |> IO.puts
      |> Enum.filter(&(elem(&1, 2) === "#"))
      |> length
  end

  def main() do
    {:ok, body} = File.read("input3.txt") # 31 chars x 1000 rows
    rows = body 
      |> String.split(["\n"])
#      |> Enum.take(10)

    thingmabob(rows, 1, 3) |> Integer.to_string |> IO.puts

    {thingmabob(rows, 1, 1), thingmabob(rows, 1, 3), thingmabob(rows, 1, 5), thingmabob(rows, 1, 7), thingmabob(rows, 2, 1)}
#      |> inspect
      |> Tuple.to_list
      |> Enum.reduce(1, &(&1*&2))
      |> IO.puts
#      |> Integer.to_string
#      |> IO.puts
  end
end