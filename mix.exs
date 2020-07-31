defmodule OpaqueTypes.MixProject do
  use Mix.Project

  def project do
    [
      app: :opaque_types,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dialyxir, "~> 1.0.0-rc.4", only: [:dev], runtime: false},
      {:typed_ecto_schema, "~> 0.1.0"},
      {:gradualixir, github: "overminddl1/gradualixir", ref: "master"},
      {:algae, "~> 1.2"},
      {:type_class, "~> 1.1"},
      {:witchcraft, "~> 1.0"}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end
end
