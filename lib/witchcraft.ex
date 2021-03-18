defmodule Witchcraft do
  @moduledoc false
  use Monads

  def run(x) do
    x
    |> fwrap()
    >>> atomic?()
    >>> short?()
    >>> allowed?()
    |> get()
  end

  defp atomic?(msg) when is_atom(msg), do: {:ok, Atom.to_charlist(msg)}
  defp atomic?(_msg), do: {:error, :not_an_atom}

  defp short?(msg) when length(msg) < 10, do: {:ok, to_string(msg)}
  defp short?(_long), do: {:error, :too_long}

  defp allowed?(msg) when msg in ["hello", "world"], do: {:ok, :hello_monads}
  defp allowed?(_), do: {:error, :not_allowed}

  defp get({_, res}), do: res
end
