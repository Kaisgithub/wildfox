class CreateComponentStates < ActiveRecord::Migration
  def change
    create_table :component_states do |t|
      t.belongs_to :component_type

      t.string :state
      t.timestamps null: false
    end
  end
end
