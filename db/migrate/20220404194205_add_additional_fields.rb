class AddAdditionalFields < ActiveRecord::Migration[7.0]
  def change
    create_table :additional_fields do |t|
      t.string :name, null: false
      t.string :value, null: false
    end
  end
end
