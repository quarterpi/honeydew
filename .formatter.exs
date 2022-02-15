[
  import_deps: [:ecto, :phoenix, :surface, :cqrs_tools, :cqrs_tools_ddd],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"],
  surface_inputs: ["{lib,test}/**/*.{ex,exs,sface}"]
]
