defmodule DropAlley.ChannelPartner do
  @moduledoc """
  The ChannelPartner context.
  """
  
  import Ecto.Query, warn: false
  alias DropAlley.Repo
  import Torch.Helpers, only: [sort: 1, paginate: 4]
  import Filtrex.Type.Config
  
  alias DropAlley.ChannelPartner.Partner
  alias DropAlley.ChannelPartner.Bucket

@pagination [page_size: 15]
@pagination_distance 5

@doc """
Paginate the list of partners using filtrex
filters.

## Examples

    iex> list_partners(%{})
    %{partners: [%Partner{}], ...}
"""
@spec paginate_partners(map) :: {:ok, map} | {:error, any}
def paginate_partners(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_config(:partners), params["partner"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_partners(filter, params) do
    {:ok,
      %{
        partners: page.entries,
        page_number: page.page_number,
        page_size: page.page_size,
        total_pages: page.total_pages,
        total_entries: page.total_entries,
        distance: @pagination_distance,
        sort_field: sort_field,
        sort_direction: sort_direction
      }
    }
  else
    {:error, error} -> {:error, error}
    error -> {:error, error}
  end
end

defp do_paginate_partners(filter, params) do
  Partner
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of partners.

## Examples

    iex> list_partners()
    [%Partner{}, ...]

"""
def list_partners do
  Repo.all(Partner)
end

@doc """
Gets a single partner.

Raises `Ecto.NoResultsError` if the Partner does not exist.

## Examples

    iex> get_partner!(123)
    %Partner{}

    iex> get_partner!(456)
    ** (Ecto.NoResultsError)

"""
def get_partner!(id), do: Repo.get!(Partner, id)

@doc """
Creates a partner.

## Examples

    iex> create_partner(%{field: value})
    {:ok, %Partner{}}

    iex> create_partner(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_partner(attrs \\ %{}) do
  %Partner{}
  |> Partner.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a partner.

## Examples

    iex> update_partner(partner, %{field: new_value})
    {:ok, %Partner{}}

    iex> update_partner(partner, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_partner(%Partner{} = partner, attrs) do
  partner
  |> Partner.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Partner.

## Examples

    iex> delete_partner(partner)
    {:ok, %Partner{}}

    iex> delete_partner(partner)
    {:error, %Ecto.Changeset{}}

"""
def delete_partner(%Partner{} = partner) do
  Repo.delete(partner)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking partner changes.

## Examples

    iex> change_partner(partner)
    %Ecto.Changeset{source: %Partner{}}

"""
def change_partner(%Partner{} = partner) do
  Partner.changeset(partner, %{})
end

defp filter_config(:partners) do
  defconfig do
    text :name
      boolean :active
      boolean :verified
      text :contact_no
      text :address
       #TODO add config for current_location of type map
    
  end
end

@doc """
Paginate the list of buckets using filtrex
filters.

## Examples

    iex> list_buckets(%{})
    %{buckets: [%Bucket{}], ...}
"""
@spec paginate_buckets(map) :: {:ok, map} | {:error, any}
def paginate_buckets(params \\ %{}) do
  params =
    params
    |> Map.put_new("sort_direction", "desc")
    |> Map.put_new("sort_field", "inserted_at")

  {:ok, sort_direction} = Map.fetch(params, "sort_direction")
  {:ok, sort_field} = Map.fetch(params, "sort_field")

  with {:ok, filter} <- Filtrex.parse_params(filter_bucket_config(:buckets), params["bucket"] || %{}),
       %Scrivener.Page{} = page <- do_paginate_buckets(filter, params) do
    {:ok,
      %{
        buckets: page.entries,
        page_number: page.page_number,
        page_size: page.page_size,
        total_pages: page.total_pages,
        total_entries: page.total_entries,
        distance: @pagination_distance,
        sort_field: sort_field,
        sort_direction: sort_direction
      }
    }
  else
    {:error, error} -> {:error, error}
    error -> {:error, error}
  end
end

defp do_paginate_buckets(filter, params) do
  Bucket
  |> Filtrex.query(filter)
  |> order_by(^sort(params))
  |> paginate(Repo, params, @pagination)
end

@doc """
Returns the list of buckets.

## Examples

    iex> list_buckets()
    [%Bucket{}, ...]

"""
def list_buckets do
  Repo.all(Bucket)
end

@doc """
Gets a single bucket.

Raises `Ecto.NoResultsError` if the Bucket does not exist.

## Examples

    iex> get_bucket!(123)
    %Bucket{}

    iex> get_bucket!(456)
    ** (Ecto.NoResultsError)

"""
def get_bucket!(id), do: Repo.get!(Bucket, id)

@doc """
Creates a bucket.

## Examples

    iex> create_bucket(%{field: value})
    {:ok, %Bucket{}}

    iex> create_bucket(%{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def create_bucket(attrs \\ %{}) do
  %Bucket{}
  |> Bucket.changeset(attrs)
  |> Repo.insert()
end

@doc """
Updates a bucket.

## Examples

    iex> update_bucket(bucket, %{field: new_value})
    {:ok, %Bucket{}}

    iex> update_bucket(bucket, %{field: bad_value})
    {:error, %Ecto.Changeset{}}

"""
def update_bucket(%Bucket{} = bucket, attrs) do
  bucket
  |> Bucket.changeset(attrs)
  |> Repo.update()
end

@doc """
Deletes a Bucket.

## Examples

    iex> delete_bucket(bucket)
    {:ok, %Bucket{}}

    iex> delete_bucket(bucket)
    {:error, %Ecto.Changeset{}}

"""
def delete_bucket(%Bucket{} = bucket) do
  Repo.delete(bucket)
end

@doc """
Returns an `%Ecto.Changeset{}` for tracking bucket changes.

## Examples

    iex> change_bucket(bucket)
    %Ecto.Changeset{source: %Bucket{}}

"""
def change_bucket(%Bucket{} = bucket) do
  Bucket.changeset(bucket, %{})
end

defp filter_bucket_config(:buckets) do
  defconfig do
    text :state
      boolean :active
      date :assigned_time
      date :pickup_time
       #TODO add config for pick_up_location of type map
    date :drop_time
       #TODO add config for drop_location of type map
    
  end
end
end
