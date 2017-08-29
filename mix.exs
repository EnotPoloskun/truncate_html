defmodule TruncateHtml.Mixfile do
  use Mix.Project

  def project do
    [
      app: :truncate_html,
      version: "0.1.0",
      elixir: "~> 1.5",
      package: package(),
      start_permanent: Mix.env == :prod,
      source_url: "https://github.com/EnotPoloskun/truncate_html",
      description: "Smart html truncate"
    ]
  end

  defp package do
    [
      maintainers: ["Astraukh Pavel"],
      licenses: ["MIT"],
      files: ~w(mix.exs README.md lib),
      links: %{"GitHub" => "https://github.com/EnotPoloskun/truncate_html"}
    ]
  end
end
