defmodule HamStudyTest do
  use ExUnit.Case
  doctest HamStudy

  test "greets the world" do
    assert HamStudy.hello() == :world
  end
end
