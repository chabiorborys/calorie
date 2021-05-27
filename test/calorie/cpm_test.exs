defmodule Calorie.CpmTest do
  use Calorie.DataCase

  alias Calorie.Cpm

  describe "bmrs" do
    alias Calorie.Cpm.Bmr

    @valid_attrs %{age: 42, height: 42, weight: 42}
    @update_attrs %{age: 43, height: 43, weight: 43}
    @invalid_attrs %{age: nil, height: nil, weight: nil}

    def bmr_fixture(attrs \\ %{}) do
      {:ok, bmr} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Cpm.create_bmr()

      bmr
    end

    test "list_bmrs/0 returns all bmrs" do
      bmr = bmr_fixture()
      assert Cpm.list_bmrs() == [bmr]
    end

    test "get_bmr!/1 returns the bmr with given id" do
      bmr = bmr_fixture()
      assert Cpm.get_bmr!(bmr.id) == bmr
    end

    test "create_bmr/1 with valid data creates a bmr" do
      assert {:ok, %Bmr{} = bmr} = Cpm.create_bmr(@valid_attrs)
      assert bmr.age == 42
      assert bmr.height == 42
      assert bmr.weight == 42
    end

    test "create_bmr/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Cpm.create_bmr(@invalid_attrs)
    end

    test "update_bmr/2 with valid data updates the bmr" do
      bmr = bmr_fixture()
      assert {:ok, %Bmr{} = bmr} = Cpm.update_bmr(bmr, @update_attrs)
      assert bmr.age == 43
      assert bmr.height == 43
      assert bmr.weight == 43
    end

    test "update_bmr/2 with invalid data returns error changeset" do
      bmr = bmr_fixture()
      assert {:error, %Ecto.Changeset{}} = Cpm.update_bmr(bmr, @invalid_attrs)
      assert bmr == Cpm.get_bmr!(bmr.id)
    end

    test "delete_bmr/1 deletes the bmr" do
      bmr = bmr_fixture()
      assert {:ok, %Bmr{}} = Cpm.delete_bmr(bmr)
      assert_raise Ecto.NoResultsError, fn -> Cpm.get_bmr!(bmr.id) end
    end

    test "change_bmr/1 returns a bmr changeset" do
      bmr = bmr_fixture()
      assert %Ecto.Changeset{} = Cpm.change_bmr(bmr)
    end
  end
end
