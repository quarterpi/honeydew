[
  import_deps: [:ecto, :phoenix, :surface, :blunt, :blunt_ddd],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"],
  surface_inputs: ["{lib,test}/**/*.{ex,exs,sface}"]
]
