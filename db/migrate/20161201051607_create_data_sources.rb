class CreateDataSources < ActiveRecord::Migration
  def change
    create_table :data_sources do |t|
      t.string :name
      t.string :genre
      t.string :state
      t.json :describe

    end
  end
end
