defmodule TruncateHtml.Mixfile do
  use Mix.Project

  def project do
    [
      app: :truncate_html,
      version: "0.1.0",
      elixir: "~> 1.5",
      package: package(),
      start_permanent: Mix.env == :prod,
    ]
  end

  defp package do
    [
      maintainers: ["Astraukh Pavel"],
      licenses: ["MIT"],
      files: ~w(mix.exs README.md lib)
    ]
  end
end
