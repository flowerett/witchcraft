defmodule Xmap do
  @doc """
  Flattens map

  All keys in `map2` will be added to `map1`. The given function will be invoked
  when there are duplicate keys; its arguments are `key` (the duplicate key),
  `value1` (the value of `key` in `map1`), and `value2` (the value of `key` in
  `map2`). The value returned by `fun` is used as the value under `key` in
  the resulting map.

  ## Examples

      iex> Xmap.flatten(%{a: %{b: 1, c: 2, d: %{e: 3, f: 4}}, g: 5})
      %{"ab" => 1, "ac" => 2, "ade" => 3, "adf" => 4, "g" => 5}

      iex> Xmap.flatten(%{a: %{b: 1, c: 2, d: %{e: 3, f: 4}}, g: 5}, delimiter: ".")
      %{"a.b" => 1, "a.c" => 2, "a.d.e" => 3, "a.d.f" => 4, "g" => 5}

  # TODO
    support atom keys
    %{ab: 1, ac: 2, ade: 3, adf: 4, g: 5}
    %{"a.b": 1, "a.c": 2, "a.d.e": 3, "a.d.f": 4, "g": 5}
  """
  @spec flatten(map, list()) :: map
  def flatten(map, opts \\ []) do
    delimiter = Keyword.get(opts, :delimiter, "")

    flatten(map, nil, delimiter) |> Enum.into(%{})
  end

  def flatten(map, k2, del) do
    map
    |> Enum.flat_map(fn {k1, v} ->
      nk = new_key([k2, k1], del)

      case v do
        v when is_map(v) -> flatten(v, nk, del)
        v -> [{nk, v}]
      end
    end)
  end

  defp new_key([nil, k], _) when is_atom(k), do: Atom.to_string(k)
  defp new_key([nil, k], _), do: k

  defp new_key([k1, k2] = t, del) when is_atom(k1) and is_atom(k2),
    do: t |> Enum.join(del) #|> String.to_atom()

  defp new_key(t, del), do: Enum.join(t, del)
end
