class CreatePlayerYear < ActiveRecord::Migration

  def up
    create_table :player_years do |t|
      t.references :player
      t.integer :year, :null => false
      t.string :league, :null => false
      t.string :team, :null => false
      t.integer :games, :null => false
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

  def down
    drop_table :player_years
  end

end
