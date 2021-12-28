defmodule CoffeerTest do
  use ExUnit.Case, async: true

  setup do
    {
      :ok,
      id: 10,
      coffee: %Coffeer.Coffee{
        brand: "Pilão",
        kind: :arabica,
        type: :grain
      },
      status: :ok
    }
  end

  describe "create/1" do
    test "returns success response when valid params" do
      params = %{kind: :conilon, brand: "Banana Coffee", type: :soluble}
      response = Coffeer.create(params)

      assert {:ok, %{id: _id, message: "Coffee was successfully created", status: :created}} =
               response
    end

    test "returns error response when invalid params" do
      params = %{kind: :another, brand: "Banana Coffee", type: :soluble}
      response = Coffeer.create(params)

      expected_response =
        {:error, %{message: "Something went wrong", status: :unprocessable_entity}}

      assert expected_response == response
    end
  end

  describe "get/1" do
    test "returns success response when valid id", %{id: id, coffee: coffee} do
      response = Coffeer.get(id)

      assert {:ok, %{status: :ok, coffee: coffee}} == response
    end

    test "returns failed response when coffee not found" do
      response = Coffeer.get(100)

      assert {:error, %{status: :not_found}} == response
    end
  end

  describe "delete/1" do
    test "returns success response when valid id", %{id: id, coffee: coffee} do
      response = Coffeer.delete(id)

      assert {
               :ok,
               %{
                 status: :ok,
                 message: "Coffee was successfully deleted",
                 coffee: coffee
               }
             } == response
    end

    test "returns failed response when coffee not found" do
      response = Coffeer.delete(100)

      assert {:error, %{status: :not_found}} == response
    end
  end
end
