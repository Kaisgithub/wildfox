class CreateDataNodes < ActiveRecord::Migration
  def change
    create_table :data_nodes do |t|
      t.references :data_sources, index: true
      t.string :name
      t.json :describe


    end
  end
end
