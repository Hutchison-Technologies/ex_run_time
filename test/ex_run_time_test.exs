defmodule ExRunTimeTest do
  use ExUnit.Case
  doctest ExRunTime

  test "greets the world" do
    assert ExRunTime.hello() == :world
  end
end
