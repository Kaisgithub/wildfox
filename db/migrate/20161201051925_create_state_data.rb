class CreateStateData < ActiveRecord::Migration
  def change
    create_table :state_data do |t|
      t.references :data_nodes, index: true

      t.integer :data
    end
  end
end
