class AddOriginToFlights < ActiveRecord::Migration[5.1]
  def change
    add_column :flights, :origin, :string
  end
end
