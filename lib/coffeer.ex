defmodule Coffeer do
  alias Coffeer.Coffee

  # module variable are constants
  @types [:grain, :ground, :soluble]
  @kinds [:arabica, :conilon]

  @example_coffee %Coffee{kind: :arabica, type: :grain, brand: "Pilão"}

  @spec create(map) ::
          {:error, %{message: String.t(), status: :unprocessable_entity}}
          | {:ok, %{id: integer, message: String.t(), status: :created}}
  def create(%{kind: kind, brand: brand, type: type})
      when kind in @kinds and type in @types and is_binary(brand) do
    {
      :ok,
      %{
        message: "Coffee was successfully created",
        id: Enum.random(0..100),
        status: :created
      }
    }
  end

  def create(_) do
    {
      :error,
      %{
        message: "Something went wrong",
        status: :unprocessable_entity
      }
    }
  end

  @spec get(integer) ::
          {:error, %{status: :not_found}}
          | {:ok,
             %{
               coffee: %{
                 brand: String.t(),
                 id: number,
                 kind: atom,
                 type: atom
               },
               status: atom
             }}
  def get(id) when is_integer(id) and id < 51 do
    {
      :ok,
      %{
        status: :ok,
        coffee: @example_coffee
      }
    }
  end

  def get(_id) do
    {:error, %{status: :not_found}}
  end

  @spec delete(integer) ::
          {:error, %{status: :not_found}}
          | {:ok, %{message: String.t(), status: :ok}}
  def delete(id) when is_integer(id) and id < 51 do
    {
      :ok,
      %{
        status: :ok,
        message: "Coffee was successfully deleted",
        coffee: @example_coffee
      }
    }
  end

  def delete(_id) do
    {:error, %{status: :not_found}}
  end
end
