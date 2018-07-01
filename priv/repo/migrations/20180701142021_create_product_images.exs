defmodule DropAlley.Repo.Migrations.CreateProductImages do
  use Ecto.Migration

  def change do
    create table(:product_images) do
      add :image, :string
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:product_images, [:product_id])
  end
end
