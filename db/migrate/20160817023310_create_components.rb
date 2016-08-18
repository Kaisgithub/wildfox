class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :describe
      t.string :struct

      t.timestamps null: false
    end
  end
end
