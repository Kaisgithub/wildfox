class CreateRuntimes < ActiveRecord::Migration
  def change
    create_table :runtimes do |t|
      t.string :describe
      t.jsonb :runtimes
    end
  end
end
