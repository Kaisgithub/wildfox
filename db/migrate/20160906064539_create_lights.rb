class CreateLights < ActiveRecord::Migration
  def change
    create_table :lights do |t|
      t.belongs_to :component
      t.string :describe
      t.string :state

      t.timestamps null: false
    end
  end
end
