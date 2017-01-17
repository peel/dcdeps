defmodule DcDeps do
  def list(container,yaml) do
    [%{"services" => services}] = yaml
    fetch_container(services,container)
    |> get_deps
  end

  def fetch_container(list,container) do
    Map.fetch(list, "#{container}")
  end

  def get_deps({:ok, container_config}) do
    case Map.fetch(container_config, "depends_on") do
      {:ok, containers} -> containers
      _ -> ""
    end
  end
  def get_deps(:error), do: "No such container found"
end
