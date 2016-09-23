class CreateModes < ActiveRecord::Migration
  def change
    create_table :modes do |t|
      t.string :modename
      t.references :kind, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
