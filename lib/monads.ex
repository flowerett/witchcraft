defmodule Monads do
  @moduledoc """
  Some functional magic
  inspired by https://github.com/ruby2elixir/rop/blob/master/lib/rop.ex
  and
  https://gist.github.com/zabirauf/17ced02bdf9829b6956e
  """
  defmacro __using__(_) do
    quote do
      import Monads
    end
  end

  # Pipe
  # how to allow more symbos?
  # >=> >=>> >>=>>
  defmacro left >>> right do
    quote do
      (fn ->
         case unquote(left) do
           {:ok, x} -> x |> unquote(right)
           {:error, _reason} = expr -> expr
         end
       end).()
    end
  end

  defmacro fwrap(x) do
    quote do
      (fn ->
         {:ok, unquote(x)}
      end).()
    end
  end

  # Bind
  # defmacro foo(args, func) do
  #   quote do
  #     (fn ->
  #       result = unquote(args) |> unquote(func)
  #       {:ok, result}
  #     end).()
  #   end
  # end

  defmacro map(args, func) do
    quote do
      (fn ->
         result = unquote(args) |> unquote(func)
         {:ok, result}
       end).()
    end
  end

  # Try - Catch
  # defmacro args >=!=> func do
  #   quote do
  #     (fn ->
  #       try do
  #         unquote(args) |> unquote(func)
  #       rescue
  #         e -> {:error, e}
  #       end
  #     end).()
  #   end
  # end

  # Tee (dead end)
  # defmacro args >=|=> func do
  #   quote bind_quoted: [args: args, func: func] do
  #     (fn ->
  #       args |> func
  #       {:ok, args}
  #     end).()
  #   end
  # end

  # defmacro tee(args, func) do
  #   quote do
  #     (fn ->
  #       unquoted_args = unquote(args)
  #       unquoted_args |> unquote(func)
  #       {:ok, unquoted_args}
  #     end).()
  #   end
  # end
end
