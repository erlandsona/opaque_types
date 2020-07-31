defmodule Phone do
  @type t :: %__MODULE__{_: String.t()}
  @enforce_keys [:_]
  defstruct @enforce_keys

  @spec new!(str :: String.t()) :: t | no_return
  def new!(str) do
    if str == "blah" do
      %__MODULE__{_: str}
    else
      raise(ArgumentError, "bad phone number")
    end
  end

  @spec _(t) :: String.t()
  def _(%__MODULE__{_: str}), do: str
end

defmodule Email do
  @type t :: %__MODULE__{_: String.t()}
  @enforce_keys [:_]
  defstruct @enforce_keys

  @spec new!(str :: String.t()) :: t | no_return
  def new!(str) do
    if String.contains?(str, "@") do
      %__MODULE__{_: str}
    else
      raise(ArgumentError, "bad email")
    end
  end

  @spec _(t) :: String.t()
  def _(%__MODULE__{_: str}), do: str
end

defmodule St do
  use TypedEctoSchema

  typed_embedded_schema do
    field(:_, :string, enforce: true, null: false) ::
      :oregon | :washington | :colorado | :tennessee | :new_york
  end

  @spec new!(st :: atom) :: t | no_return
  def new!(st) do
    if st in [:oregon, :washington, :colorado, :tennessee, :new_york] do
      %__MODULE__{_: st}
    else
      raise(ArgumentError, "Unrecognized state")
    end
  end

  @spec to_s(t) :: String.t()
  def to_s(%St{_: st}), do: Atom.to_string(st)
end

defmodule Address do
  use TypedEctoSchema

  typed_embedded_schema do
    field(:street, :string, enforce: true, null: false)
    field(:unit, :string, enforce: true)
    field(:city, :string, enforce: true, null: false)
    field(:state, :string, enforce: true, null: false) :: St.t()
  end

  @spec new!(street :: String.t(), city :: String.t(), state :: St.t(), unit :: String.t()) ::
          t | no_return
  def new!(street, city, state, unit) do
    %__MODULE__{street: street, unit: unit, city: city, state: state}
  end

  @spec format(t) :: String.t()
  def format(%__MODULE__{street: street, unit: unit, city: city, state: st}) do
    "#{street} #{unit || ""}
    #{city}, #{St.to_s(st)}"
  end
end

defmodule Controller do
  @spec handle(Email.t() | Phone.t() | Address.t()) :: String.t()
  def handle(event) do
    case event do
      %Phone{} = e -> Phone._(e)
    end
  end
end

defmodule Test do
  def blah(), do: Controller.handle(Email.new!("Stuff"))
end
