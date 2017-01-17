import YamlElixir.Sigil

defmodule DcDepsTest do
  use ExUnit.Case
  doctest DcDeps

  @container_name "container1"
  @container_dependency "container2"
  @config  ~y"""
  version: '2'

  services:
    #{@container_name}:
      ports:
        - 12345
      depends_on:
        - #{@container_dependency}
  """
  test "list displays a list of dependencies of given containers from list" do
    assert DcDeps.list(@container_name,[@config]) == {:ok, [@container_dependency]}
  end
end
