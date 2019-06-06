defmodule ExRunTime.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_run_time,
      version: String.trim(File.read!("VERSION")),
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      name: "ExRunTime",
      source_url: "https://github.com/Hutchison-Technologies/ex_run_time",
      homepage_url: "https://github.com/Hutchison-Technologies/ex_run_time",
      test_coverage: [tool: :covertool]
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
      {:eliver, "~> 2.0"},
      {:junit_formatter, "~> 3.0", only: [:test]},
      {:covertool, "~> 2.0", only: [:test]},
      {:ex_doc, "~> 0.20.2", only: :dev, runtime: false}
    ]
  end
end
