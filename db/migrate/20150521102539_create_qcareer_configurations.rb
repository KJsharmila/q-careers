class CreateQcareerConfigurations < ActiveRecord::Migration
  def change
    create_table :qcareer_configurations do |t|
      t.string :name
      t.string :value

      t.timestamps null: false
    end
  end
end
