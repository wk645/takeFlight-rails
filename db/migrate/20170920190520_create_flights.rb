class CreateFlights < ActiveRecord::Migration[5.1]
  def change
    create_table :flights do |t|
    	t.integer :rank
    	t.string :destination
    	t.datetime :departureDateTime
    	t.datetime :returnDateTime
    	t.integer :fare
    end
  end
end
