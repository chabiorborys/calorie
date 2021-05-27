defmodule Calorie.Cpm do
  @moduledoc """
  The Cpm context.
  """

  import Ecto.Query, warn: false
  alias Calorie.Repo

  alias Calorie.Cpm.Bmr
  alias Calorie.Accounts

  @doc """
  Returns the list of bmrs.

  ## Examples

      iex> list_bmrs()
      [%Bmr{}, ...]

  """
  def list_bmrs do
    Repo.all(Bmr)
  end

  @doc """
  Gets a single bmr.

  Raises `Ecto.NoResultsError` if the Bmr does not exist.

  ## Examples

      iex> get_bmr!(123)
      %Bmr{}

      iex> get_bmr!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bmr!(id), do: Repo.get!(Bmr, id)

  @doc """
  Creates a bmr.

  ## Examples

      iex> create_bmr(%{field: value})
      {:ok, %Bmr{}}

      iex> create_bmr(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bmr(%Accounts.User{} = user, attrs \\ %{}) do
    %Bmr{}
    |> Bmr.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  @doc """
  Updates a bmr.

  ## Examples

      iex> update_bmr(bmr, %{field: new_value})
      {:ok, %Bmr{}}

      iex> update_bmr(bmr, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bmr(%Bmr{} = bmr, attrs) do
    bmr
    |> Bmr.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bmr.

  ## Examples

      iex> delete_bmr(bmr)
      {:ok, %Bmr{}}

      iex> delete_bmr(bmr)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bmr(%Bmr{} = bmr) do
    Repo.delete(bmr)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bmr changes.

  ## Examples

      iex> change_bmr(bmr)
      %Ecto.Changeset{source: %Bmr{}}

  """
  def change_bmr(%Bmr{} = bmr) do
    Bmr.changeset(bmr, %{})
  end

  def list_user_bmr(%Accounts.User{} = user) do
    Bmr
    |> user_bmr_query(user)
    |> Repo.all()
  end

  def get_user_bmr!(%Accounts.User{} = user, id) do
    Bmr
    |> user_bmr_query(user)
    |> Repo.get!(id)
  end

  defp user_bmr_query(query, %Accounts.User{id: user_id}) do
    from(b in query, where: b.user_id == ^user_id)
  end

end
