class CreateControlData < ActiveRecord::Migration
  def change
    create_table :control_data do |t|
      t.references :data_nodes, index: true

      t.integer :data
    end
  end
end
