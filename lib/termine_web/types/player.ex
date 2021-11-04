defmodule TermineWeb.Types.Player do
  use Absinthe.Schema.Notation

  object :player do
    field :id, :id
    field :username, :string
  end
end