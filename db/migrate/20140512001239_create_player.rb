class CreatePlayer < ActiveRecord::Migration

  def change
    create_table :players, { :primary_key => :player_id,
                             :id => false } do |t|
      t.string :player_id, :null => false
      t.integer :birth_year
      t.string :first_name
      t.string :last_name
    end

    add_index :players, :player_id, unique: true

    create_table :player_years do |t|
      t.belongs_to :player
      t.string :player_id, :null => false
      t.integer :year, :null => false
      t.string :league, :null => false
      t.string :team, :null => false
      t.integer :games
      t.integer :at_bats
      t.integer :runs
      t.integer :hits
      t.integer :doubles
      t.integer :triples
      t.integer :home_runs
      t.integer :rbis
      t.integer :stolen_bases
      t.integer :caught_stealing
    end

  end
end
