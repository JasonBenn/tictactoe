class CreateCellsTable < ActiveRecord::Migration
  def change
    create_table :cells do |t|
      t.string :coordinate
      t.string :player
    end
  end
end
