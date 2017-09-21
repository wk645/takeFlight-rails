class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
    	t.string :fullname
    	t.string :email
    	t.string :username
    	t.string :password_digest
    end
  end
end
