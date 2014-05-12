class CreatePlayer < ActiveRecord::Migration

  def up
    create_table :players, { :primary_key => :player_id,
                             :id => false } do |t|
      t.string :player_id, :null => false
      t.integer :birth_year
      t.string :first_name
      t.string :last_name
    end
  end

  def down
    drop_table :players
  end

end
