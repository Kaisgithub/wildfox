class CreateSwitches < ActiveRecord::Migration
  def change
    create_table :switches do |t|
      t.belongs_to :component
      t.string :describe
      t.string :state

      t.timestamps null: false
    end
  end
end
