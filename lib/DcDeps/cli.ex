defmodule DcDeps.CLI do
  def main(args) do
    {opts,containers,_} = OptionParser.parse(args, switches: [file: :string], aliases: [f: :file])
    load_config(opts[:file])
    |> parse_and_print(containers)
  end

  defp load_config(nil), do: load_config("docker-compose.yml")
  defp load_config(compose_file) do
    compose_file
    |> Path.expand
    |> YamlElixir.read_all_from_file
  end

  defp parse_and_print(config, containers) do
    containers
    |> Stream.map(&DcDeps.list(&1,config))
    |> Stream.filter(fn(x) -> x != nil end)
    |> Stream.concat
    |> Enum.join(" ")
    |> IO.puts
  end
end
