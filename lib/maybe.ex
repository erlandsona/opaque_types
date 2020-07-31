defmodule Maybe do
  use TypedEctoSchema

  typed_embedded_schema do
    field(:just, :string)
  end

  def just(a), do: %Maybe{just: a}
  def nothing, do: %Maybe{}
end
