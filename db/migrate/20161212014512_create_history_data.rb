class CreateHistoryData < ActiveRecord::Migration
  def change
    create_table :history_data do |t|
      t.string :describe
      t.integer :data

      t.string :create_time
    end
  end
end
