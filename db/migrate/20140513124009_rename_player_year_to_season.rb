class RenamePlayerYearToSeason < ActiveRecord::Migration
  def change
    rename_table :player_years, :seasons
  end
end
