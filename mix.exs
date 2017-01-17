defmodule DcDeps.Mixfile do
  use Mix.Project

  def project do
    [app: :dcdeps,
     version: "0.1.0",
     elixir: "~> 1.4",
     escript: [main_module: DcDeps.CLI],
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :yaml_elixir]]
  end

  defp deps do
    [
      {:yaml_elixir, "~> 1.3"}
    ]
  end
end
