defmodule OpaqueTypesTest do
  use ExUnit.Case
  doctest OpaqueTypes

  test "greets the world" do
    assert OpaqueTypes.hello() == :world
  end
end
