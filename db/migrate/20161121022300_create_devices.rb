class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.jsonb :devices


    end
  end
end
