defmodule WitchcraftTest do
  use ExUnit.Case
  doctest Witchcraft

  describe ">>> (left-right)" do
    test "extracts value from tuple and keeps processing" do
      assert :hello_monads == Witchcraft.run(:hello)
      assert :hello_monads == Witchcraft.run(:world)
    end

    test "extracts errors from tuple and stops processing" do
      assert :not_an_atom == Witchcraft.run("test")
      assert :too_long == Witchcraft.run(:hello_world)
      assert :not_allowed == Witchcraft.run(:foo)
    end
  end
end
