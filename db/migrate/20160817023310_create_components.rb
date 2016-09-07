class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.belongs_to :component_type
      t.belongs_to :component_state

      t.string :describe
      t.timestamps null: false
    end
  end
end
